# OralGuard — Flutter App

A Flutter conversion of the OralGuard oral cancer screening web platform.

## Screens

| Screen | Route | Description |
|---|---|---|
| Home | `/` | Landing page with hero, feature cards, how-it-works |
| Self-Exam Guide | `/self-exam` | Step-by-step mouth inspection guide |
| Risk Screener | `/screener` | 18-question clinical questionnaire with follow-up differential questions |
| Image Matcher | `/matcher` | Upload lesion photo → AI returns top 6 benign + 6 malignant matches |

## Setup

### 1. Prerequisites
- Flutter SDK ≥ 3.0.0
- Dart ≥ 3.0.0

### 2. Install dependencies
```bash
cd oralgard
flutter pub get
```

### 3. Create assets folder
```bash
mkdir -p assets/images
```
Add any local images (e.g., self-exam diagram) to `assets/images/`.

### 4. Android permissions
Merge the permissions from `android_manifest_reference.xml` into your:
`android/app/src/main/AndroidManifest.xml`

### 5. iOS permissions (Info.plist)
Add these keys to `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>OralGuard needs camera access to photograph oral lesions for analysis.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>OralGuard needs photo library access to select lesion images for analysis.</string>
```

### 6. Run
```bash
flutter run
```

## Architecture

```
lib/
├── main.dart                    # App entry + GoRouter config
├── theme.dart                   # Colors, typography, theme
├── models/
│   ├── questionnaire_models.dart  # Data classes for Q&A
│   └── questionnaire_data.dart    # All questions/sections defined here
├── screens/
│   ├── home_screen.dart
│   ├── self_exam_screen.dart
│   ├── questionnaire_screen.dart
│   └── matcher_screen.dart
└── widgets/
    └── nav_bar.dart             # Shared top nav + bottom nav
```

## Key dependencies

| Package | Purpose |
|---|---|
| `go_router` | Navigation/routing |
| `image_picker` | Gallery + camera image selection |
| `http` | API calls to AI matching service |
| `google_fonts` | Playfair Display + Source Sans 3 |
| `permission_handler` | Runtime camera/storage permissions |

## AI API

The Image Matcher calls:
```
POST https://gprabhanjana-oral-cancer-cbir-api.hf.space/search
Body: multipart/form-data with field `file` (the image)
```

Response shape:
```json
{
  "results": {
    "benign": [{ "image_path": "...", "label": "...", "similarity": 0.82 }],
    "malignant": [{ "image_path": "...", "label": "...", "similarity": 0.71 }]
  }
}
```

## Medical Disclaimer

This app is a research and educational tool only. It does not provide medical diagnoses. Always consult a qualified dentist, oral surgeon, or oncologist.
