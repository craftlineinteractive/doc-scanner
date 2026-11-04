# Doc Scanner: UI Reference Package

Source of truth for the **Doc Scanner** Flutter app UI. It contains every screen exported from Google Stitch (a PNG preview plus the generated HTML/Tailwind code), organised by feature, and documented so a developer or an AI coding agent can build each screen without guessing.

> **Branding note.** The original Stitch export used the placeholder name "docLoom". The app is **Doc Scanner**.
> - All `code.html` files and `DESIGN.md` were updated: `docLoom`/`DocLoom`/`DOCLOOM` became `Doc Scanner`/`DOC SCANNER`, and the Tailwind colour keys `docloom-accent` became `docscanner-accent` (115 replacements).
> - The **`screen.png` images were not edited**, so some still show "docLoom". Ignore that text; always use "Doc Scanner" in the real app.
> - The mock user name and email shown in the drawer ("Prince Patel") are dummy data.

---

## 1. At a glance

| Item | Value |
|---|---|
| Screen folders | **28** (each has `screen.png` + `code.html`) |
| Individual screen states (frames) | **about 58** (many folders are multi-frame "suites") |
| Design system file | `00_design_system/DESIGN.md` |
| Design viewport | 390 x 844 (Android reference); build responsively for 360 to 430 wide |
| Font | Inter (400 / 500 / 600 / 700) |
| Primary colour | Indigo `#4F46E5` |
| Themes designed | Light (all screens) and Dark (camera and scan-adjust screens only) |
| Icons | Mixed in the export (see section 5); one family must be chosen for Flutter |

### What is inside each screen folder
```
<screen_folder>/
├── screen.png   <- visual reference. Open this first.
└── code.html    <- Stitch's HTML + Tailwind. Use it for exact colours, sizes, spacing,
                    text, icon names. It is NOT code to port; rebuild it in Flutter widgets.
```

> **Suite pages are presentation wrappers.** Folders named `*_suite_*` are single HTML pages that show several phone frames side by side on a showcase page. The showcase chrome (top nav such as "Overview Gallery", the title block, "Render Speed: 60 FPS", footer cards, "Core Engine v3.2" captions) is **not part of the app**. Only the phone frames inside matter.

---

## 2. Folder map

```
DocScanner_UI_Reference/
├── README.md                         <- this file
├── 00_design_system/
│   └── DESIGN.md                     <- tokens, typography, spacing, elevation, components
├── 01_home/                          (4 folders)
│   ├── 01_home_screen
│   ├── 02_home_overflow_menu
│   ├── 03_home_empty_state
│   └── 04_add_document_sheet
├── 02_navigation_drawer/             (3 folders)
│   ├── 01_drawer_default_general_expanded
│   ├── 02_drawer_signed_out
│   └── 03_drawer_tools_and_other_expanded
├── 03_camera/                        (8 folders)
│   ├── 01_camera_screen_photo_mode_layout
│   ├── 02_camera_settings_panel_suite_4_frames
│   ├── 03_mode_id_card_dialog
│   ├── 04_mode_book_dialog
│   ├── 05_mode_photo_id_photo_editor
│   ├── 06_mode_signature
│   ├── 07_mode_qr_scanner
│   └── 08_mode_ocr_text_dialog
├── 04_scan_review/                   (5 folders)
│   ├── 01_adjust_crop_default
│   ├── 02_adjust_dragging_corner
│   ├── 03_filter_bottom_sheet
│   ├── 04_doc_name_dialog_and_crop_shape_sheet
│   └── 05_review_scan_suite_5_frames
├── 05_document_viewer/               (3 folders)
│   ├── 01_post_scan_viewer_suite_5_frames
│   ├── 02_saved_document_viewer_suite_5_frames
│   └── 03_multi_page_manager_suite_3_frames
├── 06_pdf_tools/                     (1 folder)
│   └── 01_pdf_tools_toolkit_suite_4_frames
├── 07_ocr/                           (1 folder)
│   └── 01_ocr_result_screen
├── 08_trash/                         (1 folder)
│   └── 01_trash_suite_5_frames
├── 09_settings/                      (1 folder)
│   └── 01_settings_suite_6_frames
├── 10_premium/                       (1 folder)
│   └── 01_premium_paywall
└── docs/
    └── FLUTTER_ARCHITECTURE.md       <- recommended project structure and build plan
```

Folder numbering follows the user journey: Home -> Drawer -> Camera -> Review -> Viewer -> Tools -> OCR -> Trash -> Settings -> Premium.

### Original Stitch name -> new name (so you can trace anything)

| New path | Original Stitch folder |
|---|---|
| 01_home/01_home_screen | docloom_home_screen |
| 01_home/02_home_overflow_menu | docloom_overflow_menu |
| 01_home/03_home_empty_state | docloom_empty_state |
| 01_home/04_add_document_sheet | docloom_add_document_sheet |
| 02_navigation_drawer/01_drawer_default_general_expanded | docloom_drawer_general_expanded |
| 02_navigation_drawer/02_drawer_signed_out | docloom_drawer_signed_out |
| 02_navigation_drawer/03_drawer_tools_and_other_expanded | docloom_drawer_tools_other_expanded |
| 03_camera/01_camera_screen_photo_mode_layout | docloom_camera_screen_updated_layout |
| 03_camera/02_camera_settings_panel_suite_4_frames | docloom_camera_settings_panel_suite_4_frames |
| 03_camera/03_mode_id_card_dialog | docloom_frame_6_id_card_mode_dialog |
| 03_camera/04_mode_book_dialog | docloom_frame_7_book_mode_dialog |
| 03_camera/05_mode_photo_id_photo_editor | docloom_frame_5_photo_mode_id_photo_editor |
| 03_camera/06_mode_signature | docloom_frame_8_signature_mode |
| 03_camera/07_mode_qr_scanner | docloom_frame_9_qr_scanner_mode |
| 03_camera/08_mode_ocr_text_dialog | docloom_frame_10_ocr_text_mode_dialog |
| 04_scan_review/01_adjust_crop_default | docloom_frame_1_adjust_default |
| 04_scan_review/02_adjust_dragging_corner | docloom_frame_2_adjust_dragging_a_corner |
| 04_scan_review/03_filter_bottom_sheet | docloom_frame_3_filter_bottom_sheet |
| 04_scan_review/04_doc_name_dialog_and_crop_shape_sheet | docloom_frame_4_doc_name_dialog_crop_ratio_sheet |
| 04_scan_review/05_review_scan_suite_5_frames | docloom_review_scan_screens_5_frames |
| 05_document_viewer/01_post_scan_viewer_suite_5_frames | docloom_document_viewer_suite_post_scan_100 |
| 05_document_viewer/02_saved_document_viewer_suite_5_frames | docloom_saved_document_viewer_suite_5_frames |
| 05_document_viewer/03_multi_page_manager_suite_3_frames | docloom_document_open_multi_page_manager_suite |
| 06_pdf_tools/01_pdf_tools_toolkit_suite_4_frames | docloom_pdf_tools_toolkit_suite_4_frames |
| 07_ocr/01_ocr_result_screen | docloom_frame_11_ocr_result_screen |
| 08_trash/01_trash_suite_5_frames | docloom_trash_screen_suite_5_frames |
| 09_settings/01_settings_suite_6_frames | docloom_settings_screen_suite_6_frames |
| 10_premium/01_premium_paywall | doc_scanner_pro_premium_paywall |
| 00_design_system/DESIGN.md | docloom_document_scanner/DESIGN.md |

---

## 3. Screen catalogue (what each folder contains)

Suggested Flutter names are in `code font`; they match the feature folders in `docs/FLUTTER_ARCHITECTURE.md`.

### 01_home

| Folder | Frames | What it shows | Key components |
|---|---|---|---|
| `01_home_screen` | 1 | Main Home, light theme, signed in. **Top bar:** hamburger (opens drawer), app name, gold **PRO** crown pill, search icon, three-dot menu, user avatar. Below: search field "Search scanned docs, text, or tags..." with a filter icon. **"Edge OCR Active"** info banner with a "100% On-Device" chip. **Folders** section (count badge, add-folder button) with pastel folder tiles: Client Files, Property Docs, Personal IDs. **Documents** section (count badge, "Date" sort chip) with 5+ list cards: PDF thumbnail, title, relative date, page-count chip, copy/duplicate icon, three-dot. **Floating dual-pill** (camera, plus) at bottom right. | `HomeScreen`, `AppTopBar`, `SearchField`, `InfoBanner`, `FolderTile`, `DocumentListCard`, `DualPillFab` |
| `02_home_overflow_menu` | 1 | Three-dot menu open over a dimmed Home. Rows: **Export Preset** (PDF/JPG segmented), **Import** (expands to chips: Files (PDF, Doc), Gallery, ID Badge, Passport), **PDF Tools** (green "OCR Ready" chip), **Sort By** (value "Modified"), **Select Items**, **Create Folder**, **Sync Now** (green status dot), **View Mode** (value "Grid"). | `HomeOverflowMenu`, `MenuRow`, `SegmentedPill`, `StatusChip` |
| `03_home_empty_state` | 1 | First-run empty Home: illustration (page with sparkle, check, scan badge), "Scan your first document", description, two hint rows ("Tap camera to scan", "Tap + to import files"), footer "ON-DEVICE EDGE PROCESSING". | `EmptyState`, `HintRow` |
| `04_add_document_sheet` | 1 | Bottom sheet "Add Document" with close button. Options: **From Gallery** (green "Fast" tag), **PDF as Image**, **Import Documents** (PDF, Word tag). Footer: "AI auto-cropping active for all imports" + Cancel. | `AddDocumentSheet`, `OptionCard` |

> **Heads-up:** the blurred Home behind `02_home_overflow_menu` shows an *alternate* Home layout (a "Categories" row and a "Recent Scans" list with tags such as Contracts / Expenses / Identity). **`01_home_screen` is the source of truth for Home.** Treat the blurred layout as background only.

### 02_navigation_drawer

| Folder | Frames | What it shows | Key components |
|---|---|---|---|
| `01_drawer_default_general_expanded` | 1 | Left drawer, signed in. Header: avatar with online dot, name, email, "Google Drive" label, "Backup size: 589 MB" + green **Synced** chip. Gold **Upgrade to Premium** card ("Unlock all features, no ads"). Collapsible sections with a chevron: **GENERAL** (open: Favourites, Manage Tags, Trash, Settings), **TOOLS**, **OTHER**, About Us, **MORE**. Footer: version and build string. | `AppDrawer`, `DrawerHeader`, `PremiumUpsellCard`, `ExpandableSection`, `DrawerItem` |
| `02_drawer_signed_out` | 1 | Same drawer signed out: header becomes "Back up your documents / Sign in to sync with Google Drive" with a filled **Sign in with Google** button. | `DrawerHeaderSignedOut` |
| `03_drawer_tools_and_other_expanded` | 1 | Signed-in drawer with **TOOLS** (PDF Tools, Edit / Create PDF, Signature, QR Scanner, QR Generator) and **OTHER** (Help & FAQ, Contact Us) expanded. | same |

### 03_camera

All camera screens are **dark** (background about `#0F1220`, accent `#6366F1`).

| Folder | Frames | What it shows | Key components |
|---|---|---|---|
| `01_camera_screen_photo_mode_layout` | 1 | Camera with the updated layout, Photo mode selected, showing the **ID Photo Editor** dialog (same as `05_mode_photo_id_photo_editor`; this is an alternate render). Mode strip: ID Card, Document, Book, Photo, Signature, QR Scanner, OCR Text. | `CameraScreen`, `ModeSelector` |
| `02_camera_settings_panel_suite_4_frames` | 4 | **A** default Document camera (top bar: back, flash, grid, flip, settings; bottom: AUTO chip, shutter, gallery thumbnail). **B** settings grid overlay with **10 tiles**: Capture Sound, Focus Sound, Auto Crop, Color Filter (Vivid Light), Image Rotation (Auto), Settings, Home Screen, Spirit Level, Scan Quality (High), Auto Capture Time (2 sec). **C** Scan Quality picker sheet (Standard / High *recommended* / Max) + Done. **D** flash states Off / On / Auto; tapping cycles directly with no popup. | `CameraTopBar`, `CameraSettingsGrid`, `SettingTile`, `ScanQualitySheet`, `FlashButton` |
| `03_mode_id_card_dialog` | 1 | "Scan ID Card" dialog: **Single side** vs **Both sides** (front and back on one page) + Close. | `IdCardModeDialog` |
| `04_mode_book_dialog` | 1 | "Scan Book" dialog: **Single page**, **Two pages (auto split)** (selected), **Flatten curved page**. | `BookModeDialog` |
| `05_mode_photo_id_photo_editor` | 1 | "ID Photo Editor / Select photo size / Long press and drag to rearrange": 2x2 inches (DPI 600, selected), 35x45 mm (300), 2x2.5 cm (450), 600x600 px, 51x51 mm (300), 25x35 mm (450). Each has a remove (x) and person icon. Buttons: Close, **Add New**, **Select**. This is the "Image scan with multiple sizes" feature. | `PhotoSizeDialog`, `PhotoSizeChip` |
| `06_mode_signature` | 1 | Signature mode: white "SIGNATURE PAPER" frame with corner brackets, **AUTO CROP** tag, hint "Optimal lighting detected - High contrast". | `SignatureViewfinder` |
| `07_mode_qr_scanner` | 1 | QR mode: square frame with corner brackets, scan line, "Align QR code within the frame", "Automatic scanning enabled", **Auto Detect** chip, no shutter button. | `QrViewfinder` |
| `08_mode_ocr_text_dialog` | 1 | "OCR Recognition" dialog with **Edge AI Model** chip, "Convert scans into editable, searchable text", **OCR LANGUAGE: English** row (opens language picker, *not designed yet*), Close / Continue. | `OcrModeDialog` |

### 04_scan_review

Right after capture. The first four folders are the **dark** Adjust screen; the suite is the **light** multi-page review.

| Folder | Frames | What it shows | Key components |
|---|---|---|---|
| `01_adjust_crop_default` | 1 | "Adjust" screen, counter "1/1". Page with a 4-corner crop quadrilateral and edge midpoint handles. Hint "Drag the points to adjust the borders." **FILTER** dropdown (Vivid Light). Tool row: **Rotate, Crop, Doc Name**. Toggle "Show crop screen after every capture". Buttons **Retake** / **Continue**. | `AdjustScreen`, `CropOverlay`, `ToolButton` |
| `02_adjust_dragging_corner` | 1 | Same, while dragging a corner. A circular **magnifier loupe** appears above the finger. | `CropMagnifier` |
| `03_filter_bottom_sheet` | 1 | "Filters - 5 Presets" sheet: **Original, Auto Enhance, Vivid Light** (selected, check badge), **Grayscale, B&W**. Thumbnails scroll horizontally. **Done** button. | `FilterSheet`, `FilterThumb` |
| `04_doc_name_dialog_and_crop_shape_sheet` | 2 | **4A** "Document name" dialog (default "Doc Scanner 10 Oct 2026 12-02", Cancel / Save). **4B** "Crop shape" sheet with radios: Free, Original, A4, Letter, Square. | `DocNameDialog`, `CropShapeSheet` |
| `05_review_scan_suite_5_frames` | 5 | **1** Default review (page + title with pencil + counter "2 / 5"). **2** Crop open: Free, **Auto Detect** (sparkle = the auto-adjust feature), Flip, cancel/confirm. **3** Color open: filter strip with **"Apply to all pages"**. **4** **Arrange pages**: 2-column grid, "Long press, then drag to reorder", one card lifted, Done. **5** Dialogs. Bottom toolbar: **Crop, Color, Rotate, Arrange, Retake, Delete** + big check button. | `ReviewScanScreen`, `ArrangePagesScreen`, `ReviewToolbar` |

### 05_document_viewer

| Folder | Frames | What it shows |
|---|---|---|
| `01_post_scan_viewer_suite_5_frames` | 5 | Viewer right after saving. **01** default: title (editable), "1 / 3", star, three-dot; bottom bar **Edit, Open PDF, Share, Retake, Print, Copy Text, Image To, Rotate, More**. **02** Edit tools 2-tier row: **Crop, Filter, Rotate, Erase, Sign, Watermark**. **03** Crop nested 3-tier ("Crop & Perspective", Free / Original / A4 / Auto / Flip). **04** OCR & PDF recognition: "OCR Extracted - 98% accuracy", extracted-text preview (84 words), **Copy All, TXT, Translate, Search**, "Copied to Clipboard!" toast. **05** More Options sheet: Rename Document, Move to Folder, Add to Favorites, Manual Adjust / Reorder Pages, Image To (JPEG / PNG), Document Details & Info, Delete Document. |
| `02_saved_document_viewer_suite_5_frames` | 5 | Viewer for already-saved documents (light, indigo bottom bar). **1** default. **2** "Which version do you want to edit?" dialog (*Original document* vs *Last edited document*). **3** Edit sub-row. **4** Crop nested sub-row. **5** Open PDF sub-row & More options. |
| `03_multi_page_manager_suite_3_frames` | 3 | Multi-page document manager. **1** default 2-column **page grid** (page cards with number badge, filter label such as "Auto Enhanced / Vivid Light / Original"), header with "PDF" chip and "Cloud Synced", floating dual pill (**Scan Page** / **Import**). **2** **Action drawer** sheet: PDF/JPG, Share, To Email, Compress, Save Gallery, Delete; File management: Move to Folder, Make a Copy, MultiSide Doc / Collage (**PRO**), Mark as Favorite, OCR Extract All Text, Storage & Resolution Details; footer "Storage Location: Device Internal / Scans". **3** In-document **search** ("Invoice", "2 occurrences in 2 pages", filter chips All / Pg 1 / Pg 3, per-page match cards with "Jump to line"). |

### 06_pdf_tools

`01_pdf_tools_toolkit_suite_4_frames` (4 frames, PDF viewer plus the tool hub):
1. **PDF viewer default**: title `Annual_Report_2026_Q3.pdf`, search + help icons, "Page 1 of 6", bottom dock **Toolkit, Share, Save, Watermark, Compress, Adjust, Edit, Open In, Print**.
2. **Toolkit drawer, 14 tools**: *PDF Document Tools (9):* Open PDF, Merge Files, Add Gallery, Split PDF, Page Size, Rotate/Del, Add Pass, Unlock, Signature. *PDF to Other Format (3):* To Image, To Text (OCR TXT), To ZIP. *Other Format to PDF (2):* Image to PDF, Text to PDF. *More options:* Share as Long Image, Share via Secure Link.
3. **In-document text search**: search field with keyword highlight, match counter "1 / 3", up/down arrows, "Match 1 of 3" snackbar with **Jump**.
4. **Contextual help modal** "How to Use PDF Tools": 5 numbered tips + "Got It, Let's Start".

> Only the tool **hub** is designed. The individual tool screens (merge, split, compress, set password, etc.) still need designs.

### 07_ocr

`01_ocr_result_screen` (1 frame, light): "Extracted Text" header with a copy icon; summary card "Scanned Document" + **99.4% OCR** badge, "1 page - English - Tap to preview original", expand chevron; "RECOGNIZED TEXT CONTENT" card with an **Edit** action; bottom buttons **Copy** / **Share**.

### 08_trash

`01_trash_suite_5_frames` (5 frames): **1** list (info banner "deleted automatically after 30 days", "Folders (1)", "Documents (6)", each card with type badge, deleted-time, page count and a **"N days left"** chip). **2** empty state. **3** top-bar menu: **Select, Restore all, Empty trash** (red). **4** selection mode ("2 selected", bottom **Restore** / **Delete forever**). **5** dialogs and toasts: item options (Restore / Delete forever), "Delete forever?" confirmation, toast "Restored to Home" + **Undo**, and the message "Original folder no longer exists. Restored to Home."

### 09_settings

`01_settings_suite_6_frames` (6 frames): **1 Top**: BACKUP & SYNC (Auto Local Backup and Restore, Cloud Sync - Off), APPEARANCE & HOME (Theme, Date and Time Format, Tools Shortcut, Tags, Favourite Documents, Recent Documents, Recent Documents on Home - 50). **2 Middle**: PDF (PDF Settings), DOCUMENT (Document Import and Export, New Document Name Format, Scan Quality, Default Color Filter, Protect Document, Auto Save to Gallery), OCR (OCR Settings). **3 Bottom**: CAMERA (System Camera, Set Camera as Home, Capture Sound, Volume Buttons to Capture), APP (Language, Analytics, Send to Email, Enable System Gallery, Folder Navigation Path, Reset Settings), ABOUT (Send Feedback by Email, Privacy Policy, version). **4 Radio dialogs**: Theme (System default / Light / Dark), Scan quality (Standard / High / Original). **5 Picker dialogs**: Recent documents count (10 / 25 / 50 / 100), Date and time format (4 options). **6 Confirm and hint states**: "Reset all settings?" dialog, and a hint toast "Turn on Tags to use Favourite Documents" (dependent toggles are disabled until the parent toggle is on).

### 10_premium

`01_premium_paywall` (1 frame): "Premium Paywall" header (close, avatar), gold crown medallion, **Doc Scanner Pro / Scan without limits**, 2-column checklist (No ads, Unlimited OCR, All OCR languages, Cloud backup, Advanced filters, Batch export, Password PDF, Premium themes). Plan cards: **Yearly** (selected, "BEST VALUE - SAVE 60%", "3-Day Trial", $2.50/mo, $29.99/yr), **Monthly** $6.99, **Weekly** $2.99. CTA "Start 3-Day Free Trial", "Restore Purchase", Terms / Privacy. *Prices are mock USD; real prices come from the store later.*

---

## 4. Design tokens (what the screens actually use)

`DESIGN.md` and the HTML do not fully agree (the export mixes two palettes). The values below are **what the HTML screens actually render** (counted across all 28 `code.html` files). **Confirm this decision before writing the Flutter theme**; the recommendation is to follow the screens.

| Token | Value used in screens | `DESIGN.md` says |
|---|---|---|
| Primary (buttons, active, links) | `#4F46E5` | `#4F46E5` |
| Primary pressed | `#4338CA` | `#4338CA` |
| Primary tint (selected pill/row) | `#EEF0FF` | `#EEF2FF` |
| Camera accent / dark surfaces | `#6366F1` / `#0F1220` / sheet `#1A1D2E` | not listed |
| Text primary ("ink") | `#1E2340` | `#0F172A` |
| Text secondary / muted | `#8A90A6` | `#64748B` |
| App canvas (page background) | `#F4F6FA` | `#F4F6FA` |
| Surface (cards, sheets) | `#FFFFFF` | `#FFFFFF` |
| Hairline / border | `#E9ECF3` (also `#E2E8F0`, `#E5E7EB`) | `#E2E8F0` |
| Destructive | `#E5484D` | frontmatter has `#BA1A1A` |
| Premium gold / tint | `#F5B301` / `#FFF6DD` | `#EAB308` / `#FEFCE8` |
| Success (synced, OCR ready) | green chips | Emerald `#10B981` / `#ECFDF5` |

**Category accents** (folder tiles and tags, foreground / pastel): Indigo `#4F46E5`/`#EEF2FF`, Orange `#F97316`/`#FFF7ED`, Emerald `#10B981`/`#ECFDF5`, Rose `#F43F5E`/`#FFF1F2`.

**Typography:** Inter only. Display 28/700, Title 22/600, Heading 18/600, Subheading 16/600, Body-L 15/400, Body 14/400, Caption 12/400, Label 13/500, Label-S 11/600 (uppercase, letter-spaced for section headers).

**Spacing:** 8 px grid. Screen side margin 16. Card gap 12. Section gap 24. List bottom padding 100 so the floating pill never covers content.

**Radii:** inputs 12 to 14, cards 16 to 20, sheets about 24 to 28 top corners, chips and pills fully round (9999). *Radii of 32 to 36 in the HTML belong to the phone mock-up frame, not the app.*

**Elevation:** Level 1 card shadow, Level 2 lifted/dragging, Level 3 indigo glow for the floating pill (exact CSS in `DESIGN.md`).

**Signature components (build once, reuse everywhere):**
- **Dual-pill FAB:** one capsule, 56 px high, indigo; left half = camera (fast scan), 1 px divider, right half = plus (import / new folder). Press scales to 0.96.
- **PRO crown pill:** gold crown + "PRO" on a pale gold container.
- **Document card:** thumbnail, title, relative date, page chip, trailing three-dot.
- **Pastel folder tile:** category colour container + 8 px padded round icon badge.
- **Bottom sheets and dialogs:** white, rounded top, drag handle, indigo primary / grey secondary buttons.
- **Camera chrome:** translucent dark panels, white icons, indigo-violet accents, large white shutter.

---

## 5. Things to know before coding

1. **Icons are inconsistent in the export.** Home, overflow menu, empty state, add-document sheet, paywall, and the viewer/PDF/multi-page suites use **Material Symbols Outlined** (icon names are in the HTML, such as `picture_as_pdf`, `workspace_premium`, `ink_eraser`). Drawer, camera, scan review, saved viewer, trash and settings use **inline SVG** in a thin Lucide-like style. `DESIGN.md` asks for Lucide. **Pick one family for Flutter** (recommended: Material Symbols via the `material_symbols_icons` package, because most icon names are already given in the HTML).
2. **Dark theme exists only for camera/adjust screens.** Every other screen is light only. A full dark theme and the multi-theme feature still need design.
3. **Tailwind is loaded from a CDN** in the HTML; 11 files define a `tailwind.config`. Class names like `rounded-[16px]` or `bg-[#EEF0FF]` map directly to Flutter values.
4. **Mock data is realistic** (invoices, receipts, IDs). Reuse it as the dummy data for the UI phase.
5. **Home has two layouts in the export** (see the heads-up under 01_home). Use `01_home_screen`.
6. **Camera mode names in the design:** ID Card, Document, Book, Photo, Signature, QR Scanner, OCR Text. This differs from the original plan (Book, ID, QR, OCR, Image with sizes). The design's **Photo** mode covers "Image with multiple size options".
7. **The "Auto Adjust" feature** appears as the sparkle **Auto Detect** button in `04_scan_review/05_review_scan_suite_5_frames` (Crop open), and as **Auto Enhance** / **Vivid Light** filter presets. Keep the scan/enhancement logic isolated from the UI when the logic phase starts (see `docs/FLUTTER_ARCHITECTURE.md`).

---

## 6. User-journey flow (how the designed screens connect)

```
Launch -> [Splash/Onboarding: NOT DESIGNED] -> Home
Home
 ├─ hamburger -> Drawer (signed in / signed out)
 │     ├─ Favourites / Manage Tags / Trash / Settings
 │     ├─ Tools: PDF Tools, Edit-Create PDF, Signature, QR Scanner, QR Generator
 │     └─ Other: Help & FAQ, Contact Us, About Us, Upgrade -> Paywall
 ├─ three-dot -> Overflow menu (export preset, import, PDF tools, sort, select, create folder, sync, view mode)
 ├─ dual pill: camera -> Camera
 │                        ├─ mode strip -> mode dialogs (ID Card, Book, Photo sizes, OCR) / Signature / QR
 │                        ├─ settings gear -> Settings panel -> Scan quality sheet
 │                        └─ shutter -> Adjust (crop + filter + doc name) -> Review scan (multi-page, arrange)
 │                                         -> Save -> Post-scan viewer (edit tools, OCR result, more options)
 ├─ dual pill: plus -> Add Document sheet (gallery / PDF as image / import documents)
 ├─ tap document -> Saved document viewer / Multi-page manager (grid, action drawer, in-doc search)
 ├─ PDF -> PDF viewer + Toolkit (14 tools) + in-document search + help
 └─ Settings (backup, appearance, PDF, document, OCR, camera, app, about)
Trash <- delete from anywhere;  Premium paywall <- PRO pill / upgrade card / premium-tagged features
```

---

## 7. Screens requested but NOT yet designed

Design these in Stitch before (or while) building the matching feature. This list covers the original requirements that have no folder here yet.

| Priority | Missing screen | Why it matters |
|---|---|---|
| High | Splash, onboarding (3), permission request, **sign-in screen** | First-run flow; the drawer has only a sign-in button |
| High | **Global search** results screen (title and OCR text) | Home search field exists; results screen does not |
| High | **New folder** sheet (name, colour, icon), folder detail screen, move-to-folder picker | "Create Folder" menu item has no destination |
| High | Home **multi-select mode** (share, merge, move, delete) | Documents are selectable only in Trash right now |
| High | **Export / share** sheet (PDF/JPG/Word/TXT, page size, quality, password, searchable PDF) + success screen | Core flow |
| High | **Backup & Sync** screen (Google Drive account, progress, restore) | Required by your Supabase + Drive architecture |
| High | **OCR language manager** (download languages) and the language picker opened from the OCR dialog | Required for offline OCR in many languages |
| Medium | **Themes** screen (several accent themes, AMOLED) + dark versions of all light screens | Multiple-theme requirement |
| Medium | QR **result** sheets (URL, Wi-Fi, contact, text), **scan history**, **QR Generator** | Drawer lists QR Generator |
| Medium | **Signature** create / manage screen, annotation tools, watermark and page-number editor | Edit row has Sign and Watermark buttons only |
| Medium | PDF tool sub-screens (merge, split, compress, set/remove password, page size, rotate/delete) | Toolkit hub only |
| Medium | Tags management, Document details & info, Favourites list | Drawer / More menu entries |
| Medium | Image-mode size picker for standard sizes (A4, Letter, ...) if wanted beyond ID photos | Original request |
| Low | App lock (PIN / biometric) screens, Help & FAQ, Contact Us, About Us | Settings / drawer entries |
| Low | Error, no-internet, permission-denied, loading skeleton, processing overlay | Needed for polish |

---

## 8. Suggested way to use this package with an AI coding agent

For each screen, give the agent **only**: (1) the screen's `screen.png`, (2) its `code.html`, (3) `00_design_system/DESIGN.md`, (4) the rules in `docs/FLUTTER_ARCHITECTURE.md`. One screen per prompt, dummy data only, reuse widgets from `core/widgets`, no business logic. Do not hand over the whole package at once.

Recommended order: project setup and theme -> common widgets -> Home + Drawer -> Camera -> Scan review -> Viewers -> PDF tools -> OCR result -> Trash -> Settings -> Premium -> the missing screens once designed.
