import io
import os
import numpy as np
from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from PIL import Image
import torch
import torch.nn as nn
import torchvision.models as models
import torchvision.transforms as transforms
from sklearn.metrics.pairwise import cosine_similarity

# ──────────────────────────────────────────────
# CONFIG
# ──────────────────────────────────────────────
INDEX_PATH = "cbir_index.npz"
IMG_SIZE = 224
TOP_K = 10  # number of matches to return

# ──────────────────────────────────────────────
# LOAD INDEX (Runs once at startup)
# ──────────────────────────────────────────────
if not os.path.exists(INDEX_PATH):
    raise FileNotFoundError(f"{INDEX_PATH} not found in container.")

data = np.load(INDEX_PATH, allow_pickle=True)

index = {
    "embeddings": data["embeddings"],
    "paths": data["paths"],
    "labels": data["labels"],
}

print(f"Loaded {len(index['paths'])} indexed images.")

# ──────────────────────────────────────────────
# LOAD MODEL (Runs once at startup)
# ──────────────────────────────────────────────
device = torch.device("cpu")

backbone = models.mobilenet_v2(
    weights=models.MobileNet_V2_Weights.IMAGENET1K_V1
)

model = nn.Sequential(
    backbone.features,
    nn.AdaptiveAvgPool2d((1, 1)),
    nn.Flatten(),
).to(device)

model.eval()

transform = transforms.Compose([
    transforms.Resize((IMG_SIZE, IMG_SIZE)),
    transforms.ToTensor(),
    transforms.Normalize(
        mean=[0.485, 0.456, 0.406],
        std=[0.229, 0.224, 0.225]
    ),
])

@torch.no_grad()
def extract_embedding(image: Image.Image):
    tensor = transform(image).unsqueeze(0).to(device)
    emb = model(tensor).squeeze().cpu().numpy()
    return emb / (np.linalg.norm(emb) + 1e-8)

# ──────────────────────────────────────────────
# FASTAPI APP
# ──────────────────────────────────────────────
app = FastAPI(title="Oral Cancer CBIR API")

# Allow requests from Netlify / browser
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # restrict later if needed
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"message": "Oral Cancer CBIR API is running."}

@app.post("/search")
async def search(file: UploadFile = File(...)):
    contents = await file.read()
    img = Image.open(io.BytesIO(contents)).convert("RGB")

    query_emb = extract_embedding(img)

    sims = cosine_similarity(
        query_emb.reshape(1, -1),
        index["embeddings"]
    )[0]

    benign_results = []
    malignant_results = []

    for idx, sim in enumerate(sims):
        original_path = str(index["paths"][idx])

        parts = original_path.replace("\\", "/").split("/")
        class_folder = parts[-2]
        filename = parts[-1]

        public_url = f"https://huggingface.co/datasets/GPrabhanjana/oral-images/resolve/main/{class_folder}/{filename}"

        result = {
            "image_path": public_url,
            "label": str(index["labels"][idx]),
            "similarity": float(sim),
        }

        if str(index["labels"][idx]) == "benign":
            benign_results.append(result)
        else:
            malignant_results.append(result)

    # Sort each group separately
    benign_results = sorted(
        benign_results,
        key=lambda x: x["similarity"],
        reverse=True
    )[:6]

    malignant_results = sorted(
        malignant_results,
        key=lambda x: x["similarity"],
        reverse=True
    )[:6]

    # Add rank inside each group
    for i, r in enumerate(benign_results):
        r["rank"] = i + 1

    for i, r in enumerate(malignant_results):
        r["rank"] = i + 1

    return {
        "results": {
            "benign": benign_results,
            "malignant": malignant_results
        }
    }