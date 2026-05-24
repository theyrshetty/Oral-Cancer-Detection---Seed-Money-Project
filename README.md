# OralGuard - Oral Cancer Detection System

A content-based image retrieval (CBIR) system for oral cancer diagnosis support.
Upload an oral lesion image to retrieve visually similar cases from a curated
dataset, classified as benign or malignant, to assist clinical decision-making.

---

## Repository Structure

```
├── Documents/          # SRS, UI design, literature review, PPT, conference papers
├── Huggingface_sv/     # FastAPI backend (deployed on Hugging Face Spaces)
├── website/            # Web frontend
├── oralguard_flutter/  # Flutter mobile application (Android/iOS)
└── Output/             # Release APK ready for download
```

---

## System Components

### Backend — FastAPI (Hugging Face Spaces)
Located in `Huggingface_sv/`

- MobileNetV2 backbone extracts feature embeddings from uploaded images
- Cosine similarity search against a pre-built index (`cbir_index.npz`)
- Returns top 6 benign and top 6 malignant matches with similarity scores
- Deployed as a Docker container on Hugging Face Spaces

**Endpoint:** `POST /search` — accepts an image, returns ranked results by class

---

### Web Frontend
Located in `website/`

- Browser-based interface to upload oral lesion images
- Displays retrieval results grouped by benign and malignant
- Connects to the Hugging Face backend API

---

### Mobile Application — Flutter
Located in `oralguard_flutter/`

- Cross-platform Flutter app (Android/iOS)
- Upload from gallery or capture directly with camera
- Displays top similar cases with similarity scores and ranks
- Connects to the same backend API

**Release APK:** Available in `Output/` — `Demo_app-arm64-v8a-release.apk`

---

## How It Works

1. User uploads an oral lesion image via the web or mobile app
2. The image is sent to the FastAPI backend
3. MobileNetV2 extracts a feature embedding from the image
4. Cosine similarity is computed against all indexed embeddings
5. Top 6 benign and top 6 malignant matches are returned with scores
6. Results are displayed for clinical comparison

---

## Dataset

Images are sourced from the
[GPrabhanjana/oral-images](https://huggingface.co/datasets/GPrabhanjana/oral-images)
dataset on Hugging Face, containing labelled benign and malignant oral lesion images.

---

## Installing the Android App

1. Download `Demo_app-arm64-v8a-release.apk` from the `Output/` folder
2. Transfer it to your Android device
3. Enable unknown sources: `Settings > Security > Install unknown apps`
4. Open the APK and follow the on-screen prompts

**Requirements:** Android 8.0 (API level 26) or higher, internet connection

---

## Running the Backend Locally

**Prerequisites:** Docker

```bash
cd Huggingface_sv
docker build -t oralguard-api .
docker run -p 7860:7860 oralguard-api
```

API available at `http://localhost:7860`

---

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | FastAPI, Python 3.10, Docker |
| ML Model | MobileNetV2 (torchvision, ImageNet weights) |
| Similarity | Cosine similarity (scikit-learn) |
| Mobile | Flutter (Dart) |
| Deployment | Hugging Face Spaces |
| Dataset | Hugging Face Datasets |

---

## Documents

The `Documents/` folder contains the full project documentation:

- Software Requirements Specification (SRS)
- UI/UX Design
- Literature Review
- Presentation (PPT)
- Conference Draft Papers

---

## License

MIT
