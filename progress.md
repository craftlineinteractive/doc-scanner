# Project Progress Log: Doc Scanner UI

## Definition of Done
Every task must tick:
- [x] Code complete and follows AI_RULES.md
- [x] flutter analyze: 0 issues
- [x] flutter test: all pass
- [x] Installed and run on the emulator, no crashes, no overflow errors
- [x] Compared against mockup screen.png
- [x] progress.md updated
- [x] Committed with a Conventional Commit message (hash recorded)

## Session Status
- **Current Milestone**: M4 (Scan Review & Adjust)
- **Status**: Completed (ready for M5: Document Viewers & Multi-Page Manager)

## Milestone Checklist
- [x] **M0: Foundation & UI Gallery** (`4adb380`)
  - [x] Step 0: Onboard & inspection
  - [x] Step 1: Planning files (`task_plan.md`, `progress.md`)
  - [x] Step 2: Add core packages (`flutter_riverpod`, `go_router`, `material_symbols_icons`, `google_fonts`, `flutter_animate`, `shimmer`)
  - [x] Step 3: Rules file (`docs/AI_RULES.md`)
  - [x] Step 4: Folder structure setup
  - [x] Step 5: Constants (`app_strings.dart`, `app_assets.dart`, `app_durations.dart`, `app_limits.dart`)
  - [x] Step 6: Theme implementation (`app_colors.dart`, `app_typography.dart`, `app_spacing.dart`, `app_radii.dart`, `app_shadows.dart`, `doc_colors.dart`, `app_theme.dart`)
  - [x] Step 7: App & Router (`main.dart`, `app.dart`, `routes.dart`, `app_router.dart`, `placeholder_screen.dart`)
  - [x] Step 8: UI Gallery (`ui_gallery_screen.dart`)
  - [x] Step 9: Verification (`test/theme_test.dart`, `test/app_smoke_test.dart`, `flutter analyze`, `flutter test`)
- [x] **Workflow Setup (Part A)** (`acfc359`)
  - [x] A1: Git setup check & ignore cleanup
  - [x] A2: Permanent Rule 11 (Commits) in `docs/AI_RULES.md`
  - [x] A3: Permanent Rule 12 (Emulator testing) in `docs/AI_RULES.md`
  - [x] A4: Definition of Done checklist in `progress.md`
  - [x] A5: Verification & commit (`acfc359`)
- [x] **M1: Common Widgets UI Kit** (`9b28d5a`)
  - [x] Group 1: Mock visuals and buttons (`lib/core/widgets/mock/`, `lib/core/widgets/buttons/`)
  - [x] Group 2: Navigation and inputs (`lib/core/widgets/navigation/`, `lib/core/widgets/inputs/`)
  - [x] Group 3: Cards and chips (`lib/core/widgets/cards/`, `lib/core/widgets/chips/`)
  - [x] Group 4: Overlays and feedback (`lib/core/widgets/sheets/`, `dialogs/`, `feedback/`)
  - [x] Group 5: Camera widgets (`lib/core/widgets/camera/`)
  - [x] Group 6: Components page & integration (`lib/dev/ui_gallery/`, `/dev/components`)
- [x] **M2: Home & Drawer** (tagged `m2-home-drawer`)
  - [x] Models & dummy data: `ScanDocument`, `ScanFolder`, `DrawerUser`, mock repositories (`8b2ba0e`)
  - [x] Navigation Drawer: `AppDrawer`, signed-in & signed-out headers, accordion sections, preview screen (`d369388`)
  - [x] Home Screen: `HomeScreen`, `HomeFoldersSection`, `HomeDocumentsSection`, grid mode, empty onboarding state (`2cc7ffa`)
  - [x] Menus & sheets: `HomeOverflowMenu`, `AddDocumentSheet`, gallery routes integration (`2a01452`)
  - [x] Tests: 6 widget tests for home and drawer (`e12cff8`)
- [x] **M3: Camera & Modes** (tagged `m3-camera`)
  - [x] Models & state: `PhotoSize`, mock sizes, `CameraMode`, `FlashMode`, `CameraSettings`, `IdScanSides`, `BookScanType`, `photoSizeProvider` (`df88ae3`)
  - [x] Camera screen: `CameraScreen`, `CameraViewfinder`, `CameraBottomControls`, `CameraTopBar`, `SpiritLevelWidget`, `CameraGridOverlay`, `MockCameraBackground` (`a62fc9c`)
  - [x] Settings panel & sheets: `CameraSettingsPanel`, `SettingTile`, `ScanQualitySheet`, flash cycling (`2214a5f`)
  - [x] Mode dialogs: `IdCardModeDialog`, `BookModeDialog`, `PhotoSizeDialog`, `OcrModeDialog`, route params & UI Gallery entries (`78f7a40`)
  - [x] Tests: 7 widget tests in `test/camera_test.dart`, total 19 tests all passing (`5aba597`)
  - [x] Verification: Android emulator verification on `emulator-5554` (API 36), font scale 1.3 tested with 0 overflows, 0 unhandled exceptions
- [x] **M4: Scan Review & Adjust** (tagged `m4-scan-review`)
  - [x] Step 1: Session models & providers: `ScanPage`, `CropQuad`, `CropShape`, `ScanFilter`, `ScanSessionNotifier`, `ReviewUiNotifier` (`6fc4112`)
  - [x] Step 2: Adjust screen: `AdjustScreen`, `AdjustCanvas`, `AdjustControls`, `CropOverlay`, `CropMagnifier` (`c475438`)
  - [x] Step 3: Sheets & dialogs: `FilterBottomSheet`, `DocNameDialog`, `CropShapeSheet` (`4556a02`)
  - [x] Step 4: Review screen: `ReviewScanScreen`, `ReviewTopBar`, `ReviewBottomBar`, `ReviewCropBar`, `ReviewColorBar` (`efe9244`)
  - [x] Step 5: Arrange pages & dialogs: `ArrangePagesScreen`, `DeletePageDialog`, `DiscardScanDialog` (`69229f4`)
  - [x] Step 6: Tests: 7 widget tests in `test/scan_review_test.dart`, 26 total passing tests (`74535c1`)
  - [x] Step 7: Android emulator verification on `emulator-5554` (API 36), font scale 1.3 tested with 0 overflows, 0 unhandled exceptions
- [ ] **M5: Document Viewers & Multi-Page Manager**
- [ ] **M6: PDF Tools & Viewer**
- [ ] **M7: OCR Result**
- [ ] **M8: Trash**
- [ ] **M9: Settings**
- [ ] **M10: Premium Paywall**
- [ ] **M11: Late-Designed Screens**

## Verification Log
| Date | Check | Result | Notes |
|---|---|---|---|
| Step 0 | `flutter --version` | Flutter 3.44.9, Dart 3.12.2 | Verified |
| Step 2 | `flutter pub add` | 6 packages added | Resolved versions logged |
| Step 9 | `flutter analyze` | 0 issues found | Clean static analysis |
| Step 9 | `flutter test` | All 4 tests passed | Theme sanity & app smoke passed |
| Part A | `flutter analyze` & `test` | 0 issues / 4 passed | Clean gate check before commit `acfc359` |
| Part B (M1) | `flutter analyze` | 0 issues found | Clean static analysis across all 40+ widgets |
| Part B (M1) | `flutter test` | All 6 tests passed | Added & verified `test/components_page_test.dart` |
| Part B (M1) | Android Emulator verification | Passed (`emulator-5554`) | Android 16 (API 36); launched Components Page, switched light/dark/camera themes, font scale 1.3 test clean |
| M2 | `flutter analyze` | 0 issues found | Clean static analysis across models, repository, drawer, and home |
| M2 | `flutter test` | All 12 tests passed | 6 new tests in `test/home_and_drawer_test.dart`, all project tests green |
| M2 | Android Emulator verification | Passed (`emulator-5554`) | Android 16 (API 36); verified 9 states (Home list/grid, empty state, overflow menu, import submenu, add sheet, drawer signed-in/signed-out/tools-other), font scale 1.3 tested with 0 overflows and 0 exceptions |
| M3 | `flutter analyze` | 0 issues found | Clean static analysis across camera domain, application, presentation, dialogs, sheets, and router |
| M3 | `flutter test` | All 19 tests passed | 7 new tests in `test/camera_test.dart`, 19/19 project tests green |
| M3 | Android Emulator verification | Passed (`emulator-5554`) | Android 16 (API 36); tested all 11 gallery states (Document default, Photo layout, Settings panel, Scan Quality sheet, Flash cycle, ID Card dialog + flip back side, Book dialog + 2-page split, Photo size dialog + reorder/add/select, Signature mode, QR Scanner mode + scan line, OCR dialog), font scale 1.3 tested with 0 overflows and 0 unhandled exceptions |
| M4 | `flutter analyze` | 0 issues found | Clean static analysis across scan review domain, application, presentation, sheets, dialogs, and router |
| M4 | `flutter test` | All 26 tests passed | 7 new tests in `test/scan_review_test.dart`, 26/26 project tests green |
| M4 | Android Emulator verification | Passed (`emulator-5554`) | Android 16 (API 36); tested all 11 gallery states (Adjust default, Dragging corner + 2.5x loupe, Filter bottom sheet, Doc Name dialog, Crop Shape sheet, Review default, Crop open, Color open, Arrange pages grid, Delete page dialog, Discard scan dialog), font scale 1.3 tested with 0 overflows and 0 unhandled exceptions |
