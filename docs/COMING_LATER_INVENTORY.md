# Coming Later Inventory: Simulated & Dummy Actions

This document tracks all features, capabilities, and behaviors in **Doc Scanner** that are currently simulated with mock data or toast notifications ("*is coming later*") as specified in the Phase 1 UI-only milestone deliverables (M1 through M10).

---

## 1. Authentication & Cloud Services
| Feature | Location | Current Simulation | Planned Real Integration |
|---|---|---|---|
| Google Sign-In | Drawer (`/drawer-preview`) | Visual toggle between signed-in and signed-out states via query param | Google Sign-In SDK / OAuth2 / Firebase Auth |
| Cloud Sync | Settings (`/settings`), Viewer | Snackbars: `"Cloud sync is coming later"` / static `"Cloud Synced"` status badge | Cloud storage synchronization service (Google Drive / Firebase) |
| Cloud Backup & Restore | Settings (`/settings`) | Snackbar toast upon tap | Remote backup snapshot upload & download manager |

---

## 2. Hardware & Camera Pipeline
| Feature | Location | Current Simulation | Planned Real Integration |
|---|---|---|---|
| Camera Viewfinder | Camera (`/camera`) | Synthetic document canvas with textured desktop and lighting gradient | `camera` or `camerawesome` native platform view |
| Flashlight / Torch | Camera Top Bar | State toggle (`off`, `on`, `auto`, `torch`) updating icon | Native camera lens torch API |
| Live Edge Detection | Camera Viewfinder | Math-interpolated SVG/Path corner brackets | OpenCV / ML Kit Document Scanner API |
| System Camera Handoff | Settings (`/settings`) | Settings switch toggle | Android `MediaStore.ACTION_IMAGE_CAPTURE` intent |
| Shutter Sound & Haptics | Camera Settings | Toggle switch | `audioplayers` or system shutter tone |

---

## 3. PDF Processing & Export Engine
| Feature | Location | Current Simulation | Planned Real Integration |
|---|---|---|---|
| PDF Document Rendering | PDF Viewer (`/pdf-viewer`) | Synthetic vector report layout drawn with `CustomPainter` | Native PDF viewer engine (`pdfx` or Android `PdfRenderer`) |
| Merge / Split Files | PDF Toolkit (`/pdf-viewer?toolkit=true`) | Snackbar: `"Merge Files is coming later"` / `"Split PDF is coming later"` | `pdf` / `syncfusion_flutter_pdf` package manipulation |
| PDF Password Protection | PDF Toolkit | Interactive dialog collecting password and returning simulated success toast | PDF encryption standard AES-256 via native PDF library |
| Convert to Image / Text / ZIP | PDF Toolkit | Snackbars announcing format conversion | Background isolate export pipeline producing file archives |
| Share Document | PDF Bottom Dock, Viewer | Snackbar: `"Share is coming later"` | `share_plus` native OS share sheet |
| Print Document | PDF Bottom Dock | Snackbar: `"Print is coming later"` | Android Print Spooler (`printing` package) |

---

## 4. OCR (Optical Character Recognition)
| Feature | Location | Current Simulation | Planned Real Integration |
|---|---|---|---|
| Text Recognition Engine | Scan Review & OCR Result (`/ocr-result`) | Mock pre-parsed text from legal consulting agreement | Google ML Kit Text Recognition (`google_mlkit_text_recognition`) |
| Search within Scanned Text | Document Viewer & Page Manager | String matching with position highlight overlay | Full-text SQLite FTS5 / inverted search index |
| Copy Scanned Text | OCR Result Screen | Floating `"Copied to Clipboard!"` toast | `flutter/services` `Clipboard.setData` |

---

## 5. Monetization & Security
| Feature | Location | Current Simulation | Planned Real Integration |
|---|---|---|---|
| In-App Purchases | Premium Paywall (`/premium`) | Plan selection, terms links, simulated purchase snackbars | Google Play Billing (`in_app_purchase` package) |
| App Lock / Protect Document | Settings (`/settings`) | Settings tile with `"Protect Document is coming later"` toast | `local_auth` biometric (fingerprint/Face ID/PIN) prompt |
