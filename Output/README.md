# Oral Cancer CBIR - Android App

An Android application for oral cancer image retrieval. Upload or capture an oral lesion image and find the most visually similar images from a curated dataset, grouped by class (benign and malignant).

---

## Overview

This app is the mobile client for the Oral Cancer CBIR system. It connects to a FastAPI backend that uses MobileNetV2 embeddings and cosine similarity to retrieve the top matching images from a pre-indexed dataset.

Results are displayed in two groups — benign and malignant — each ranked by visual similarity, helping clinicians and researchers compare query images against known cases.

---

## APK

The release APK is built for `arm64-v8a` architecture.

- **File:** `Demo_app-arm64-v8a-release.apk`
- **Architecture:** arm64-v8a
- **Build type:** Release

### Installation

1. Transfer the APK to your Android device.
2. Enable installs from unknown sources: `Settings > Security > Install unknown apps`.
3. Open the APK file and follow the on-screen prompts.

---

## Features

- Upload an image from gallery or capture using camera
- Sends the image to the CBIR backend via the `/search` endpoint
- Displays top 6 similar benign and top 6 similar malignant results
- Shows similarity score and rank for each retrieved image

---

## Backend

The app communicates with the FastAPI backend hosted on Hugging Face Spaces.

- **Endpoint:** `POST /search` — accepts `multipart/form-data` with the query image
- **Response:** JSON with `benign` and `malignant` result groups, each containing image URLs, similarity scores, and ranks


---

## Requirements

- Android 8.0 (API level 26) or higher
- Internet connection to reach the backend

---

## License

MIT
