# Oral Cancer CBIR API

A Content-Based Image Retrieval (CBIR) API for oral cancer images. Given a query image, it returns the most visually similar images from a pre-built index, separated by class (benign and malignant).

---

## Overview

The API accepts an oral lesion image and retrieves the top visually similar images from an indexed dataset using deep learning embeddings and cosine similarity. Results are grouped by label so clinicians or researchers can compare the query against both benign and malignant examples simultaneously.

---

## How It Works

1. A MobileNetV2 backbone (pretrained on ImageNet) extracts a feature embedding from the uploaded image.
2. The embedding is compared against a pre-built index (`cbir_index.npz`) using cosine similarity.
3. The top 6 most similar images from each class (benign, malignant) are returned, along with their similarity scores and public image URLs.

---

## Stack

- **Framework:** FastAPI
- **Model:** MobileNetV2 (torchvision, ImageNet weights)
- **Similarity:** Cosine similarity via scikit-learn
- **Image index:** NumPy `.npz` file containing embeddings, file paths, and labels
- **Dataset:** [GPrabhanjana/oral-images](https://huggingface.co/datasets/GPrabhanjana/oral-images) on Hugging Face
- **Runtime:** Python 3.10, Docker

---

## API Reference

### `GET /`

Health check.

**Response:**
```json
{
  "message": "Oral Cancer CBIR API is running."
}
```

---

### `POST /search`

Upload an image and retrieve similar images from the index.

**Request:** `multipart/form-data` with a single field `file` containing the image.

**Response:**
```json
{
  "results": {
    "benign": [
      {
        "image_path": "https://huggingface.co/datasets/.../benign/image.jpg",
        "label": "benign",
        "similarity": 0.97,
        "rank": 1
      }
    ],
    "malignant": [
      {
        "image_path": "https://huggingface.co/datasets/.../malignant/image.jpg",
        "label": "malignant",
        "similarity": 0.91,
        "rank": 1
      }
    ]
  }
}
```

Each group returns up to 6 results, sorted by similarity in descending order.

---

## Running Locally

**Prerequisites:** Docker

```bash
# Build the image
docker build -t cbir-api .

# Run the container
docker run -p 7860:7860 cbir-api
```

The API will be available at `http://localhost:7860`.

---

## Files

| File | Description |
|---|---|
| `app.py` | FastAPI application, model loading, and search endpoint |
| `cbir_index.npz` | Pre-built index of embeddings, paths, and labels |
| `requirements.txt` | Python dependencies |
| `Dockerfile` | Container definition |

---

## Notes

- The model runs on CPU. No GPU is required.
- CORS is open to all origins (`*`). Restrict `allow_origins` in production.
- The index is loaded once at startup and held in memory for fast retrieval.

---

## License

MIT
