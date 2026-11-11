# Doc Scanner

A production-grade mobile document scanning application built with Flutter, Riverpod 3.x, and GoRouter. Faithfully reproduces every layout, gesture, and component from high-fidelity pixel mockups with strict WCAG AA accessibility, zero design debt, and full cross-resolution responsiveness.

---

## 🏛️ Architecture Overview

The codebase is organized by feature following domain-driven design principles:

```
lib/
├── app/                  # App entry point, GoRouter config, route definitions
├── core/
│   ├── constants/        # Centralized asset, duration, limit, and string constants
│   ├── models/           # Common data models (ScanDocument, ScanFolder)
│   ├── theme/            # Design tokens: AppColors, AppTypography, AppSpacing, AppRadii, AppShadows, DocColors
│   └── widgets/          # Reusable design system primitives (buttons, inputs, cards, sheets, dialogs)
├── dev/
│   └── ui_gallery/       # Interactive UI gallery cataloging all 72 screen states and components
└── features/
    ├── home/             # Document listing, grid/list view toggle, empty states, search
    ├── camera/           # Viewfinder, multi-mode selector (Docs, ID, Book, OCR), live crop guides
    ├── scan_review/      # Document edge crop, color filters, page rotation, multi-page arrange
    ├── document_viewer/  # Single-doc viewer, multi-page grid manager, full-text OCR search
    ├── pdf_tools/        # PDF reader, persistent 9-tool dock, 14-tool slide-up toolkit matrix
    ├── ocr/              # Text recognition extraction, original preview toggle, clipboard copy
    ├── trash/            # Retention bin, days-left warning chips, multi-select batch restore/delete
    ├── settings/         # Theme switcher, backup/cloud sync toggles, scan quality, name format
    ├── drawer/           # Navigation drawer with Google sign-in toggle and Pro upgrade banner
    └── premium/          # High-converting paywall, benefit breakdown cards, subscription billing
```

---

## 🎨 UI Gallery & Deep Linking

In debug mode (`kDebugMode`), the app boots directly to the **UI Gallery** (`/gallery`), providing rapid navigation to all 72 screen variations.

### Deep Linking Scheme
The app registers the custom scheme `docscanner://`. You can launch any screen or specific state directly via Android ADB:

```bash
# Open Page Manager in OCR search mode:
adb shell am start -a android.intent.action.VIEW -d "docscanner:///page-manager?id=doc_multi_4&state=search&q=Invoice"

# Open PDF Viewer with Toolkit drawer opened:
adb shell am start -a android.intent.action.VIEW -d "docscanner:///pdf-viewer?toolkit=true"

# Open Premium Paywall:
adb shell am start -a android.intent.action.VIEW -d "docscanner:///premium"
```

---

## 🧪 Testing & Verification

The test suite includes a comprehensive table-driven smoke test (`test/gallery_smoke_test.dart`) that verifies all 72 gallery entries across 4 demanding screen configurations:
1. **Compact Portrait**: 360 x 800, text scale 1.0 (Light Theme)
2. **Flagship Tall**: 430 x 932, text scale 1.0 (Light Theme)
3. **Accessibility Zoom**: 360 x 800, text scale 1.3 (Light Theme)
4. **Dark Mode**: 360 x 800, text scale 1.0 (Dark Theme)

### Running the Tests
```bash
# Run all unit, widget, and gallery smoke tests:
flutter test

# Run the gallery smoke test directly:
flutter test test/gallery_smoke_test.dart

# Run static analysis:
flutter analyze
```

---

## 📋 Documentation
- [`docs/UI_AUDIT.md`](docs/UI_AUDIT.md): Detailed 72-screen audit matrix verifying mockup frame fidelity and dark mode contrast ratios.
- [`docs/COMING_LATER_INVENTORY.md`](docs/COMING_LATER_INVENTORY.md): Comprehensive inventory of simulated actions and their planned backend/native API equivalents.
- [`docs/AI_RULES.md`](docs/AI_RULES.md): 12 development guidelines governing codebase structure, design tokens, and verification procedures.
