# Doc Scanner: Recommended Flutter Architecture

Recommendations for the UI phase (dummy data, no logic) and the later logic phase. Package choices should be re-checked on pub.dev when you start, because versions and maintenance status change.

## 1. Guiding principles

1. **Feature-first folders.** Each feature owns its screens, widgets, models and (later) logic. Nothing about "camera" lives outside `features/camera`.
2. **One design system.** All colours, text styles, spacing, radii and shadows live in `core/theme`. No hard-coded colours or sizes inside screens.
3. **Reusable widgets first.** A button, card, sheet or chip is built once in `core/widgets` and reused. Screens only assemble widgets.
4. **Dummy data behind interfaces.** Screens read from a repository interface that returns mock data now and real data later, so adding logic does not change any screen file.
5. **The scan pipeline is isolated.** Edge detection, perspective warp, auto-adjust and filters live in a separate local package (`packages/scan_engine`) with automated tests. This directly prevents the earlier problem where fixing one thing silently broke auto-adjust.
6. **One screen per AI prompt.** Small, checkable steps; run the app after each.

## 2. Recommended stack

| Concern | Recommendation | Why |
|---|---|---|
| State management | `flutter_riverpod` | Testable, no BuildContext coupling, works well with AI agents |
| Navigation | `go_router` | Declarative routes, deep links, bottom-sheet and dialog routes |
| Models | plain Dart classes now; `freezed` + `json_serializable` in the logic phase | Keep UI phase simple |
| Local database (logic phase) | SQLite via `drift` | Relational (documents, pages, folders, tags); can use FTS5 full-text search for OCR text |
| Icons | `material_symbols_icons` | Most icon names in the Stitch HTML are already Material Symbols |
| Fonts | Inter, **bundled in `assets/fonts`** | Works offline, no network font fetch |
| Theme extras | `ThemeExtension<DocColors>` for custom tokens | Lets you ship multiple themes cleanly |
| Preview tooling | a debug-only **UI Gallery** screen (see section 5) | Open any screen without navigating; ideal for the no-logic phase |
| Tests | golden tests for key screens later | Catches accidental UI changes |

Logic-phase packages (do not add yet): `camera`, `opencv_dart` (or a platform scanner such as ML Kit document scanner), `google_mlkit_text_recognition`, `mobile_scanner` (QR), `pdf`, `supabase_flutter` (auth and subscription only), `google_sign_in` + Google Drive API (backup), `in_app_purchase` or RevenueCat.

## 3. Project structure

```
doc_scanner/
├── pubspec.yaml
├── analysis_options.yaml
├── assets/
│   ├── fonts/                      Inter-*.ttf
│   ├── images/                     illustrations, empty-state art, logo
│   └── mock/                       sample page images used by dummy data
├── docs/
│   └── ui_reference/               <- this whole DocScanner_UI_Reference folder
├── packages/
│   └── scan_engine/                (logic phase) isolated scan pipeline + tests
├── test/
│   ├── golden/
│   └── scan_engine/                (logic phase)
└── lib/
    ├── main.dart
    ├── app/
    │   ├── app.dart                MaterialApp.router, theme wiring
    │   ├── router/
    │   │   ├── app_router.dart
    │   │   └── routes.dart         route names / paths as constants
    │   └── bootstrap.dart
    ├── core/
    │   ├── constants/
    │   │   ├── app_strings.dart    app name, fixed labels
    │   │   ├── app_assets.dart     asset paths
    │   │   ├── app_durations.dart
    │   │   └── app_limits.dart     e.g. trash days = 30
    │   ├── theme/
    │   │   ├── app_colors.dart     raw colour tokens (light + dark + camera)
    │   │   ├── app_typography.dart Inter text styles
    │   │   ├── app_spacing.dart    4 / 8 / 12 / 16 / 24 ...
    │   │   ├── app_radii.dart
    │   │   ├── app_shadows.dart
    │   │   ├── doc_colors.dart     ThemeExtension (primary tint, gold, success, ...)
    │   │   ├── theme_presets.dart  Ocean/Emerald/... accent presets (premium themes)
    │   │   └── app_theme.dart      ThemeData light / dark / camera
    │   ├── widgets/                shared UI kit (see section 4)
    │   │   ├── buttons/
    │   │   ├── cards/
    │   │   ├── chips/
    │   │   ├── dialogs/
    │   │   ├── sheets/
    │   │   ├── inputs/
    │   │   ├── feedback/           snackbar, toast, progress, shimmer, empty state
    │   │   ├── navigation/         app bar, drawer parts, dual-pill FAB
    │   │   └── camera/             camera chrome used by all camera modes
    │   ├── models/                 plain data classes shared across features
    │   ├── utils/                  formatters (dates, file sizes), extensions
    │   └── l10n/                   (later) translations
    ├── features/
    │   ├── home/
    │   ├── drawer/
    │   ├── camera/
    │   ├── scan_review/
    │   ├── document_viewer/
    │   ├── pdf_tools/
    │   ├── ocr/
    │   ├── trash/
    │   ├── settings/
    │   ├── premium/
    │   ├── onboarding/             (design pending)
    │   ├── auth/                   (design pending)
    │   ├── search/                 (design pending)
    │   ├── folders/                (design pending)
    │   ├── export/                 (design pending)
    │   ├── backup/                 (design pending)
    │   ├── themes/                 (design pending)
    │   └── qr/                     (design pending)
    └── dev/
        └── ui_gallery/             debug-only screen index
```

### Inside every feature folder

```
features/home/
├── presentation/
│   ├── screens/        home_screen.dart, home_empty_screen.dart
│   ├── sheets/         add_document_sheet.dart, home_overflow_menu.dart
│   └── widgets/        feature-specific pieces only (e.g. folder_tile.dart)
├── data/
│   └── mock_home_repository.dart      dummy data now
└── domain/
    └── home_repository.dart           abstract interface (logic phase swaps the implementation)
```
Add `application/` (Riverpod providers/controllers) when logic starts. A widget used by two or more features moves to `core/widgets`.

## 4. Common component list (build these before any screen)

Derived from the Stitch screens:

| Group | Components |
|---|---|
| Buttons | `PrimaryButton`, `SecondaryButton`, `TextActionButton`, `DualPillFab`, `ShutterButton`, `IconCircleButton`, `ToolButton` (icon + label) |
| Navigation | `AppTopBar` (hamburger, title, PRO pill, actions), `ProPill`, `DrawerHeader`, `DrawerItem`, `ExpandableSection` |
| Inputs | `AppSearchField`, `AppTextField`, `AppSwitch`, `RadioTile`, `SegmentedPill` |
| Cards | `DocumentListCard`, `DocumentGridCard`, `FolderTile`, `InfoBanner`, `PremiumUpsellCard`, `SettingsTile`, `SettingsSection` |
| Chips and badges | `StatusChip` (Synced, OCR Ready), `CountBadge`, `DaysLeftChip`, `PlanCard` |
| Overlays | `AppBottomSheet` (handle + rounded top), `AppDialog`, `RadioDialog`, `ConfirmDialog`, `AppSnackbar` with Undo |
| Feedback | `EmptyState`, `ShimmerSkeleton`, `ProcessingOverlay` |
| Camera | `CameraTopBar`, `ModeSelector`, `CameraSettingTile`, `CornerBracketsOverlay`, `CropOverlay` (4 corners + mid handles), `CropMagnifier` |
| Viewer | `PageThumbnail`, `PageIndicatorPill`, `ToolRow` (nested 2 and 3 tier tool rows) |

## 5. The UI Gallery (very useful for the no-logic phase)

Create `dev/ui_gallery/ui_gallery_screen.dart`: a debug-only list of every screen and sheet, grouped exactly like the numbered folders in `ui_reference`. Tap an entry to open that screen with mock data. Benefits:
- You can review all 58 states quickly without clicking through flows.
- AI agents can be told "register the new screen in the gallery", so nothing gets forgotten.
- Hide it behind `kDebugMode`.

## 6. Naming and coding rules (paste these into every AI prompt)

- Files: `snake_case.dart`. Classes: `PascalCase`. Screen classes end with `Screen`, sheets with `Sheet`, dialogs with `Dialog`.
- **Never** hard-code a colour, font size, radius or spacing in a screen. Use `AppColors`, `AppTypography`, `AppSpacing`, `AppRadii`.
- **Never** write business logic in a widget. In the UI phase every button does nothing, or navigates, or shows a snackbar.
- Use `const` constructors wherever possible.
- Each screen file stays small; split into widgets when it passes about 200 lines.
- Dummy data lives only in `data/mock_*` files or `assets/mock`.
- Every screen must handle small phones (360 wide) and large phones (430 wide) and respect safe areas.
- Run `flutter analyze` after each prompt; fix all warnings before continuing.

## 7. UI-phase milestones

| # | Milestone | Reference folders |
|---|---|---|
| M0 | Project setup, fonts, assets, theme (light/dark/camera), constants, router skeleton, UI Gallery | `00_design_system` |
| M1 | Common widgets (section 4) shown on a "Components" page in the gallery | `00_design_system`, all |
| M2 | Home (list, empty, overflow menu, add-document sheet) + Drawer (3 states) | `01_home`, `02_navigation_drawer` |
| M3 | Camera shell + mode dialogs + settings panel | `03_camera` |
| M4 | Adjust / crop / filter / doc-name / review-and-arrange | `04_scan_review` |
| M5 | Document viewers + multi-page manager | `05_document_viewer` |
| M6 | PDF viewer + toolkit + search + help | `06_pdf_tools` |
| M7 | OCR result | `07_ocr` |
| M8 | Trash (5 states) | `08_trash` |
| M9 | Settings (6 states) | `09_settings` |
| M10 | Premium paywall | `10_premium` |
| M11 | Screens designed later (onboarding, sign-in, search, folders, export, backup, OCR languages, themes, QR) | see README section 7 |

## 8. Logic-phase order (after the UI is approved)

Build in this order so the riskiest part is proven first:

1. **`scan_engine` package** (isolated, no UI): edge detection, perspective correction, filters, **auto-adjust**. Cover each with tests using saved sample images, so any later change that breaks auto-adjust fails a test instead of reaching you silently. Test on a **real phone** early.
2. Camera capture wired to the engine (frame processing off the main thread).
3. Local database + file storage for documents, pages, folders, tags, trash.
4. Viewer, page management, export to PDF/JPG.
5. OCR (on-device), searchable text, language downloads.
6. Google sign-in and Google Drive backup/restore.
7. Supabase authentication and subscription status (no document data stored there), then purchases.
8. Settings wiring, app lock, polish, analytics, store release.

## 9. Decisions to confirm before coding

1. **Token source:** follow the colours the screens actually use (`#1E2340` text, `#8A90A6` muted) or the values in `DESIGN.md` (`#0F172A`, `#64748B`). Recommendation: the screens.
2. **Icon family:** Material Symbols (recommended) or Lucide.
3. **Home bottom control:** the design has a camera + plus **dual pill**; your original request had a gallery icon on the left. Gallery import currently lives in the plus half and the Add Document sheet.
4. **Camera modes:** keep the designed set (ID Card, Document, Book, Photo, Signature, QR Scanner, OCR Text).
5. **Supported minimum devices** (e.g. Android 8+, iOS 14+).
