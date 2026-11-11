import '../../app/routes.dart';

/// Single source of truth model representing an entry in the UI Gallery.
class GalleryEntry {
  const GalleryEntry({
    required this.group,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.mockupFolder,
    required this.mockupFrame,
    this.badge,
  });

  final String group;
  final String title;
  final String subtitle;
  final String route;
  final String mockupFolder;
  final String mockupFrame;
  final String? badge;
}

/// Represents a numbered section of gallery entries.
class GallerySection {
  const GallerySection({
    required this.number,
    required this.title,
    required this.items,
  });

  final String number;
  final String title;
  final List<GalleryEntry> items;
}

/// Complete grouped gallery sections for UI Gallery screen.
const List<GallerySection> kGallerySections = <GallerySection>[
  GallerySection(
    number: '00',
    title: 'Design System & Primitives',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '00_design_system',
        title: 'Components Gallery',
        subtitle: 'Buttons, Inputs, Cards, Chips, Sheets, and Dialogs',
        route: AppRoutes.components,
        mockupFolder: 'mockups/DocScanner/00_design_system',
        mockupFrame: 'DESIGN.md primitives',
        badge: 'M1',
      ),
    ],
  ),
  GallerySection(
    number: '01',
    title: '01_home',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '01_home',
        title: '01 Home Screen (List)',
        subtitle: 'Main screen, search, OCR banner, folders & doc cards',
        route: '${AppRoutes.home}?mode=list',
        mockupFolder: 'mockups/DocScanner/01_home/01_home_screen',
        mockupFrame: '01 (List)',
        badge: 'List',
      ),
      GalleryEntry(
        group: '01_home',
        title: '01 Home Screen (Grid)',
        subtitle: '2-column documents grid layout with preview tiles',
        route: '${AppRoutes.home}?mode=grid',
        mockupFolder: 'mockups/DocScanner/01_home/01_home_screen',
        mockupFrame: '02 (Grid)',
        badge: 'Grid',
      ),
      GalleryEntry(
        group: '01_home',
        title: '02 Home Overflow Menu',
        subtitle: 'Three-dot contextual popup over dimmed home',
        route: '${AppRoutes.home}?overflow=true',
        mockupFolder: 'mockups/DocScanner/01_home/02_home_overflow_menu',
        mockupFrame: '01 (Menu)',
        badge: 'Menu',
      ),
      GalleryEntry(
        group: '01_home',
        title: '02 Home Overflow (Import Expanded)',
        subtitle: 'Import submenu expanded with format chips',
        route: '${AppRoutes.home}?overflow=true&importExpanded=true',
        mockupFolder: 'mockups/DocScanner/01_home/02_home_overflow_menu',
        mockupFrame: '02 (Import Expanded)',
        badge: 'Expanded',
      ),
      GalleryEntry(
        group: '01_home',
        title: '03 Home Empty State',
        subtitle: 'First-run onboarding illustration and hints',
        route: AppRoutes.homeEmpty,
        mockupFolder: 'mockups/DocScanner/01_home/03_home_empty_state',
        mockupFrame: '01 (Empty)',
        badge: 'Empty',
      ),
      GalleryEntry(
        group: '01_home',
        title: '04 Add Document Sheet',
        subtitle: 'Import from gallery, PDF, or files modal',
        route: '${AppRoutes.home}?addSheet=true',
        mockupFolder: 'mockups/DocScanner/01_home/04_add_document_sheet',
        mockupFrame: '01 (Add Sheet)',
        badge: 'Sheet',
      ),
    ],
  ),
  GallerySection(
    number: '02',
    title: '02_navigation_drawer',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '02_navigation_drawer',
        title: '01 Drawer Default (General Expanded)',
        subtitle: 'Signed-in header, sync status, General accordion open',
        route: AppRoutes.drawerSignedIn,
        mockupFolder:
            'mockups/DocScanner/02_navigation_drawer/01_drawer_default_general_expanded',
        mockupFrame: '01 (Default)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '02_navigation_drawer',
        title: '02 Drawer Signed Out',
        subtitle: 'Sign in with Google CTA header',
        route: AppRoutes.drawerSignedOut,
        mockupFolder:
            'mockups/DocScanner/02_navigation_drawer/02_drawer_signed_out',
        mockupFrame: '01 (Signed Out)',
        badge: 'Auth',
      ),
      GalleryEntry(
        group: '02_navigation_drawer',
        title: '03 Drawer Tools & Other Expanded',
        subtitle: 'PDF tools, signature, QR tools accordion open',
        route: AppRoutes.drawerToolsOther,
        mockupFolder:
            'mockups/DocScanner/02_navigation_drawer/03_drawer_tools_and_other_expanded',
        mockupFrame: '01 (Tools Expanded)',
        badge: 'Accordion',
      ),
    ],
  ),
  GallerySection(
    number: '03',
    title: '03_camera',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: Document (default)',
        subtitle: 'Document mode viewfinder, auto-detection and shutter bar',
        route: '${AppRoutes.camera}?mode=document',
        mockupFolder:
            'mockups/DocScanner/03_camera/01_camera_screen_photo_mode_layout',
        mockupFrame: '01 (Document)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: Photo mode layout',
        subtitle: 'Photo capture frame with aspect ratio hints',
        route: '${AppRoutes.camera}?mode=photo',
        mockupFolder:
            'mockups/DocScanner/03_camera/01_camera_screen_photo_mode_layout',
        mockupFrame: '02 (Photo)',
        badge: 'Mode',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: Settings panel open',
        subtitle:
            '10-tile camera settings grid with sound, level, grid toggles',
        route: '${AppRoutes.camera}?panel=settings',
        mockupFolder:
            'mockups/DocScanner/03_camera/02_camera_settings_panel_suite_4_frames',
        mockupFrame: '01 (Settings Panel)',
        badge: 'Panel',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: Scan Quality sheet open',
        subtitle: 'Dark modal picker for Standard, High, and Max quality',
        route: '${AppRoutes.camera}?panel=quality',
        mockupFolder:
            'mockups/DocScanner/03_camera/02_camera_settings_panel_suite_4_frames',
        mockupFrame: '02 (Quality Sheet)',
        badge: 'Sheet',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: Flash states (Auto)',
        subtitle: 'Top bar flash indicator toggled to Auto state',
        route: '${AppRoutes.camera}?mode=document&flash=auto',
        mockupFolder:
            'mockups/DocScanner/03_camera/02_camera_settings_panel_suite_4_frames',
        mockupFrame: '03 (Flash Auto)',
        badge: 'State',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: ID Card dialog',
        subtitle: 'Single Side vs Both Sides scan option cards',
        route: '${AppRoutes.camera}?mode=idCard&dialog=idCard',
        mockupFolder: 'mockups/DocScanner/03_camera/03_mode_id_card_dialog',
        mockupFrame: '01 (ID Card Dialog)',
        badge: 'Dialog',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: Book dialog',
        subtitle: 'Single Page, Two Pages, Flatten Curved options',
        route: '${AppRoutes.camera}?mode=book&dialog=book',
        mockupFolder: 'mockups/DocScanner/03_camera/04_mode_book_dialog',
        mockupFrame: '01 (Book Dialog)',
        badge: 'Dialog',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: Photo size dialog',
        subtitle: '2-column draggable reorderable photo preset sizes',
        route: '${AppRoutes.camera}?mode=photo&dialog=photo',
        mockupFolder:
            'mockups/DocScanner/03_camera/05_mode_photo_id_photo_editor',
        mockupFrame: '01 (Photo Sizes)',
        badge: 'Dialog',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: Signature mode',
        subtitle: 'High contrast viewfinder for signature capture',
        route: '${AppRoutes.camera}?mode=signature',
        mockupFolder: 'mockups/DocScanner/03_camera/06_mode_signature',
        mockupFrame: '01 (Signature)',
        badge: 'Mode',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: QR Scanner mode',
        subtitle: 'Square viewfinder with animated scan line',
        route: '${AppRoutes.camera}?mode=qrScanner',
        mockupFolder: 'mockups/DocScanner/03_camera/07_mode_qr_scanner',
        mockupFrame: '01 (QR Scanner)',
        badge: 'Mode',
      ),
      GalleryEntry(
        group: '03_camera',
        title: 'Camera: OCR dialog',
        subtitle: 'Edge AI on-device model and language selection dialog',
        route: '${AppRoutes.camera}?mode=ocrText&dialog=ocr',
        mockupFolder: 'mockups/DocScanner/03_camera/08_mode_ocr_text_dialog',
        mockupFrame: '01 (OCR Dialog)',
        badge: 'Dialog',
      ),
    ],
  ),
  GallerySection(
    number: '04',
    title: '04_scan_review',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '04_scan_review',
        title: '01 Adjust Crop Default',
        subtitle: 'Dark adjust screen, quadrilateral 4-point crop handles',
        route: AppRoutes.adjust,
        mockupFolder: 'mockups/DocScanner/04_scan_review/01_adjust_crop_default',
        mockupFrame: '01 (Adjust Default)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '02 Adjust Dragging Corner',
        subtitle: 'Active corner drag with 2.5x circular magnifier loupe',
        route: '${AppRoutes.adjust}?drag=true',
        mockupFolder:
            'mockups/DocScanner/04_scan_review/02_adjust_dragging_corner',
        mockupFrame: '01 (Dragging Loupe)',
        badge: 'Loupe',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '03 Filter Bottom Sheet',
        subtitle: '5 presets (Auto Enhance, Vivid Light, Grayscale, etc.)',
        route: '${AppRoutes.adjust}?sheet=filters',
        mockupFolder:
            'mockups/DocScanner/04_scan_review/03_filter_bottom_sheet',
        mockupFrame: '01 (Filters Sheet)',
        badge: 'Sheet',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '04A Document Name Dialog',
        subtitle: 'Prefilled name input with autofocus and selection',
        route: '${AppRoutes.adjust}?dialog=doc_name',
        mockupFolder:
            'mockups/DocScanner/04_scan_review/04_doc_name_dialog_and_crop_shape_sheet',
        mockupFrame: '01 (Doc Name)',
        badge: 'Dialog',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '04B Crop Shape Sheet',
        subtitle: 'Free, Original, A4, Letter, Square aspect ratio radios',
        route: '${AppRoutes.adjust}?sheet=shape',
        mockupFolder:
            'mockups/DocScanner/04_scan_review/04_doc_name_dialog_and_crop_shape_sheet',
        mockupFrame: '02 (Crop Shape)',
        badge: 'Sheet',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '05 Review - Default',
        subtitle: 'Light theme multi-page review, bottom toolbar, 2 / 5 pill',
        route: AppRoutes.reviewScan,
        mockupFolder:
            'mockups/DocScanner/04_scan_review/05_review_scan_suite_5_frames',
        mockupFrame: '01 (Review Default)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '05 Review - Crop Open',
        subtitle: 'Crop sub-toolbar with Free, Auto Detect sparkle, Flip',
        route: '${AppRoutes.reviewScan}?mode=crop',
        mockupFolder:
            'mockups/DocScanner/04_scan_review/05_review_scan_suite_5_frames',
        mockupFrame: '02 (Crop Toolbar)',
        badge: 'Sub-mode',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '05 Review - Color Open',
        subtitle: 'Horizontal filter strip with Apply to all pages toggle',
        route: '${AppRoutes.reviewScan}?mode=color',
        mockupFolder:
            'mockups/DocScanner/04_scan_review/05_review_scan_suite_5_frames',
        mockupFrame: '03 (Color Strip)',
        badge: 'Sub-mode',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '05 Review - Arrange Pages',
        subtitle: '2-column page grid with drag-and-drop reordering',
        route: AppRoutes.arrangePages,
        mockupFolder:
            'mockups/DocScanner/04_scan_review/05_review_scan_suite_5_frames',
        mockupFrame: '04 (Arrange Pages)',
        badge: 'Reorder',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '05 Review - Delete Page Dialog',
        subtitle: 'Confirmation dialog: Page N will be removed',
        route: '${AppRoutes.reviewScan}?dialog=delete',
        mockupFolder:
            'mockups/DocScanner/04_scan_review/05_review_scan_suite_5_frames',
        mockupFrame: '05 (Delete Page Dialog)',
        badge: 'Dialog',
      ),
      GalleryEntry(
        group: '04_scan_review',
        title: '05 Review - Discard Scan Dialog',
        subtitle: 'Warning dialog: All N pages will be lost',
        route: '${AppRoutes.reviewScan}?dialog=discard',
        mockupFolder:
            'mockups/DocScanner/04_scan_review/05_review_scan_suite_5_frames',
        mockupFrame: '05 (Discard Dialog)',
        badge: 'Dialog',
      ),
    ],
  ),
  GallerySection(
    number: '05',
    title: '05_document_viewer',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '05_document_viewer',
        title: '01 Post-Scan Viewer - 01 Default',
        subtitle: '9-tool bottom bar, 1/3 pill, pinch-zoom A4 canvas',
        route: '${AppRoutes.postScanViewer}?tier=main',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/01_post_scan_viewer_suite_5_frames',
        mockupFrame: '01 (Default)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '01 Post-Scan Viewer - 02 Edit Tier',
        subtitle: 'Editing Mode banner & 2nd-tier floating sub-tool row',
        route: '${AppRoutes.postScanViewer}?tier=edit',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/01_post_scan_viewer_suite_5_frames',
        mockupFrame: '02 (Edit Tier)',
        badge: 'Edit',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '01 Post-Scan Viewer - 03 Crop Tier',
        subtitle: '3rd-tier elevated crop bar, CropOverlay & aspect ratios',
        route: '${AppRoutes.postScanViewer}?tier=crop',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/01_post_scan_viewer_suite_5_frames',
        mockupFrame: '03 (Crop Tier)',
        badge: 'Crop',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '01 Post-Scan Viewer - 04 OCR Panel',
        subtitle: 'OCR accuracy chip, highlighted text & extracted preview',
        route: '${AppRoutes.postScanViewer}?panel=ocr',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/01_post_scan_viewer_suite_5_frames',
        mockupFrame: '04 (OCR Panel)',
        badge: 'OCR',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '01 Post-Scan Viewer - 05 More Options',
        subtitle: '7 action rows: rename, move, favorites, reorder, delete',
        route: '${AppRoutes.postScanViewer}?panel=more',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/01_post_scan_viewer_suite_5_frames',
        mockupFrame: '05 (More Options)',
        badge: 'Sheet',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '02 Saved Viewer - 1 Default',
        subtitle: 'Light theme canvas (#F4F6FA), 6-tool bar, 1/5 page pill',
        route: '${AppRoutes.savedViewer}?frame=1',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/02_saved_document_viewer_suite_5_frames',
        mockupFrame: '01 (Default)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '02 Saved Viewer - 2 Edit Choice Dialog',
        subtitle: 'Modal: Original document vs Last edited document',
        route: '${AppRoutes.savedViewer}?frame=2',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/02_saved_document_viewer_suite_5_frames',
        mockupFrame: '02 (Edit Choice)',
        badge: 'Dialog',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '02 Saved Viewer - 3 Edit Sub-Row',
        subtitle: 'Sub-tool row: Crop, Color, Rotate, Erase, Sign, Watermark',
        route: '${AppRoutes.savedViewer}?frame=3',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/02_saved_document_viewer_suite_5_frames',
        mockupFrame: '03 (Edit Sub-Row)',
        badge: 'Sub-Row',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '02 Saved Viewer - 4 Crop Nested Sub-Row',
        subtitle: '3-tier toolbar stack with interactive quad crop handles',
        route: '${AppRoutes.savedViewer}?frame=4',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/02_saved_document_viewer_suite_5_frames',
        mockupFrame: '04 (Crop Sub-Row)',
        badge: 'Crop',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '02 Saved Viewer - 5 PDF Sub-Row & More',
        subtitle: 'PDF sub-row & More PDF Options bottom sheet',
        route: '${AppRoutes.savedViewer}?frame=5',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/02_saved_document_viewer_suite_5_frames',
        mockupFrame: '05 (PDF Sub-Row & Sheet)',
        badge: 'PDF',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '03 Page Manager - 1 Default Grid',
        subtitle: '2-column page grid, Cloud Synced status & Dual Pill FAB',
        route: '${AppRoutes.pageManager}?state=grid',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/03_multi_page_manager_suite_3_frames',
        mockupFrame: '01 (Page Grid)',
        badge: 'Grid',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '03 Page Manager - 2 Action Drawer',
        subtitle: '3x2 action matrix, Move, Copy, Collage PRO & DPI info',
        route: '${AppRoutes.pageManager}?state=drawer',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/03_multi_page_manager_suite_3_frames',
        mockupFrame: '02 (Action Drawer)',
        badge: 'Drawer',
      ),
      GalleryEntry(
        group: '05_document_viewer',
        title: '03 Page Manager - 3 Search & Instant PDF',
        subtitle: 'In-doc search "Invoice", 2 occurrences & instant jump',
        route: '${AppRoutes.pageManager}?state=search&q=Invoice',
        mockupFolder:
            'mockups/DocScanner/05_document_viewer/03_multi_page_manager_suite_3_frames',
        mockupFrame: '03 (Search View)',
        badge: 'Search',
      ),
    ],
  ),
  GallerySection(
    number: '06',
    title: '06_pdf_tools',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '06_pdf_tools',
        title: '01 PDF Viewer Default',
        subtitle: 'Resting viewer, 6 pages, 68px bottom dock & page pill',
        route: '${AppRoutes.pdfViewer}?state=default',
        mockupFolder:
            'mockups/DocScanner/06_pdf_tools/01_pdf_tools_toolkit_suite_4_frames',
        mockupFrame: '01 (Resting Viewer)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '06_pdf_tools',
        title: '02 PDF Toolkit Drawer Open',
        subtitle: '14 tools categorized, 9 document actions, conversions',
        route: '${AppRoutes.pdfViewer}?state=toolkit',
        mockupFolder:
            'mockups/DocScanner/06_pdf_tools/01_pdf_tools_toolkit_suite_4_frames',
        mockupFrame: '02 (Toolkit Drawer)',
        badge: 'Toolkit',
      ),
      GalleryEntry(
        group: '06_pdf_tools',
        title: '03 In-Document Search',
        subtitle: 'Lexical search "Financial", 1/3 match counter & jump card',
        route: '${AppRoutes.pdfViewer}?state=search&q=Financial',
        mockupFolder:
            'mockups/DocScanner/06_pdf_tools/01_pdf_tools_toolkit_suite_4_frames',
        mockupFrame: '03 (Search Mode)',
        badge: 'Search',
      ),
      GalleryEntry(
        group: '06_pdf_tools',
        title: '04 Contextual Help Modal',
        subtitle: 'How to Use PDF Tools, 5 numbered tips & Got It CTA',
        route: '${AppRoutes.pdfViewer}?state=help',
        mockupFolder:
            'mockups/DocScanner/06_pdf_tools/01_pdf_tools_toolkit_suite_4_frames',
        mockupFrame: '04 (Help Modal)',
        badge: 'Help',
      ),
      GalleryEntry(
        group: '06_pdf_tools',
        title: '05 Add Password Dialog',
        subtitle: 'AES-256 encryption password dialog with visibility toggle',
        route: '${AppRoutes.pdfViewer}?state=password',
        mockupFolder:
            'mockups/DocScanner/06_pdf_tools/01_pdf_tools_toolkit_suite_4_frames',
        mockupFrame: '02 (Add Password Dialog)',
        badge: 'Dialog',
      ),
    ],
  ),
  GallerySection(
    number: '07',
    title: '07_ocr',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '07_ocr',
        title: '01 OCR Result Default',
        subtitle: '99.4% accuracy badge, consulting agreement, Copy/Share bar',
        route: '${AppRoutes.ocrResult}?state=default',
        mockupFolder: 'mockups/DocScanner/07_ocr/01_ocr_result_screen',
        mockupFrame: '01 (Default OCR)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '07_ocr',
        title: '02 OCR Editing Text',
        subtitle: 'Inline multiline text editor with Done action',
        route: '${AppRoutes.ocrResult}?state=editing',
        mockupFolder: 'mockups/DocScanner/07_ocr/01_ocr_result_screen',
        mockupFrame: '02 (Editing Text)',
        badge: 'Edit',
      ),
      GalleryEntry(
        group: '07_ocr',
        title: '03 OCR Original Preview Expanded',
        subtitle: 'Thumbnail expand toggle showing original document',
        route: '${AppRoutes.ocrResult}?state=preview',
        mockupFolder: 'mockups/DocScanner/07_ocr/01_ocr_result_screen',
        mockupFrame: '03 (Preview Expanded)',
        badge: 'Preview',
      ),
    ],
  ),
  GallerySection(
    number: '08',
    title: '08_trash',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '08_trash',
        title: '01 Trash - List Default',
        subtitle: 'Info banner, Folders (1), Documents (6), Days-left chips',
        route: '${AppRoutes.trash}?state=list',
        mockupFolder: 'mockups/DocScanner/08_trash/01_trash_suite_5_frames',
        mockupFrame: '01 (Trash List)',
        badge: 'List',
      ),
      GalleryEntry(
        group: '08_trash',
        title: '02 Trash - Empty State',
        subtitle: 'Trash is empty illustration, disabled 3-dot action',
        route: '${AppRoutes.trash}?state=empty',
        mockupFolder: 'mockups/DocScanner/08_trash/01_trash_suite_5_frames',
        mockupFrame: '02 (Empty State)',
        badge: 'Empty',
      ),
      GalleryEntry(
        group: '08_trash',
        title: '03 Top Bar Menu Open',
        subtitle: 'Anchored popup with Select, Restore all, Empty trash',
        route: '${AppRoutes.trash}?state=menu',
        mockupFolder: 'mockups/DocScanner/08_trash/01_trash_suite_5_frames',
        mockupFrame: '03 (Menu Open)',
        badge: 'Menu',
      ),
      GalleryEntry(
        group: '08_trash',
        title: '04 Selection Mode (2 Selected)',
        subtitle: 'Round checkboxes, selection counter and bottom action bar',
        route: '${AppRoutes.trash}?state=selecting',
        mockupFolder: 'mockups/DocScanner/08_trash/01_trash_suite_5_frames',
        mockupFrame: '04 (Selection Mode)',
        badge: 'Select',
      ),
      GalleryEntry(
        group: '08_trash',
        title: '05A Item Options Sheet',
        subtitle: 'Item Options sheet with Restore and Delete forever',
        route: '${AppRoutes.trash}?state=options',
        mockupFolder: 'mockups/DocScanner/08_trash/01_trash_suite_5_frames',
        mockupFrame: '05 (Options Sheet)',
        badge: 'Options',
      ),
      GalleryEntry(
        group: '08_trash',
        title: '05B Delete Forever Dialog',
        subtitle: 'Destructive confirmation modal for permanent deletion',
        route: '${AppRoutes.trash}?state=deleteDialog',
        mockupFolder: 'mockups/DocScanner/08_trash/01_trash_suite_5_frames',
        mockupFrame: '05 (Delete Dialog)',
        badge: 'Dialog',
      ),
      GalleryEntry(
        group: '08_trash',
        title: '05C Restored Toast with Undo',
        subtitle: 'Restored to Home toast notification with Undo action',
        route: '${AppRoutes.trash}?state=toast',
        mockupFolder: 'mockups/DocScanner/08_trash/01_trash_suite_5_frames',
        mockupFrame: '05 (Toast with Undo)',
        badge: 'Toast',
      ),
    ],
  ),
  GallerySection(
    number: '09',
    title: '09_settings',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '09_settings',
        title: '01 Settings: Top (Backup & Appearance)',
        subtitle:
            'Backup & Sync, Appearance & Home with theme, format, shortcuts',
        route: '${AppRoutes.settings}?scroll=top',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '01 (Settings Top)',
        badge: 'Top',
      ),
      GalleryEntry(
        group: '09_settings',
        title: '02 Settings: Middle (PDF & Document)',
        subtitle: 'PDF settings, name format, scan quality, color filter',
        route: '${AppRoutes.settings}?scroll=middle',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '02 (Settings Middle)',
        badge: 'Middle',
      ),
      GalleryEntry(
        group: '09_settings',
        title: '03 Settings: Bottom (Camera & App)',
        subtitle: 'Camera toggles, sound, app options, reset button, version',
        route: '${AppRoutes.settings}?scroll=bottom',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '03 (Settings Bottom)',
        badge: 'Bottom',
      ),
      GalleryEntry(
        group: '09_settings',
        title: '04 Theme Dialog',
        subtitle: 'RadioDialog with System default, Light, and Dark',
        route: '${AppRoutes.settings}?dialog=theme',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '04 (Theme Dialog)',
        badge: 'Modal',
      ),
      GalleryEntry(
        group: '09_settings',
        title: '05 Scan Quality Dialog',
        subtitle: 'RadioDialog with Standard, High, and Original presets',
        route: '${AppRoutes.settings}?dialog=quality',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '05 (Quality Dialog)',
        badge: 'Modal',
      ),
      GalleryEntry(
        group: '09_settings',
        title: '06 Recent Documents Count Picker',
        subtitle: 'Count picker with 10, 25, 50, and 100 options',
        route: '${AppRoutes.settings}?dialog=count',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '06 (Count Picker)',
        badge: 'Picker',
      ),
      GalleryEntry(
        group: '09_settings',
        title: '07 Date and Time Format Picker',
        subtitle:
            'Date format picker with 4 standard presentation patterns',
        route: '${AppRoutes.settings}?dialog=format',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '06 (Format Picker)',
        badge: 'Picker',
      ),
      GalleryEntry(
        group: '09_settings',
        title: '08 Reset Settings Confirmation',
        subtitle: 'Destructive modal confirm dialog with red button',
        route: '${AppRoutes.settings}?dialog=reset',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '06 (Reset Dialog)',
        badge: 'Destructive',
      ),
      GalleryEntry(
        group: '09_settings',
        title: '09 Hint Toast Notification',
        subtitle:
            'Capsule toast: "Turn on Tags to use Favourite Documents"',
        route: '${AppRoutes.settings}?hint=true',
        mockupFolder:
            'mockups/DocScanner/09_settings/01_settings_suite_6_frames',
        mockupFrame: '06 (Hint Toast)',
        badge: 'Toast',
      ),
    ],
  ),
  GallerySection(
    number: '10',
    title: '10_premium',
    items: <GalleryEntry>[
      GalleryEntry(
        group: '10_premium',
        title: '01 Premium Paywall (Yearly - Default)',
        subtitle:
            'Hero crown, 8-feature grid, yearly access (\$2.50/mo, \$29.99/yr), trial CTA',
        route: AppRoutes.premium,
        mockupFolder: 'mockups/DocScanner/10_premium/01_premium_paywall',
        mockupFrame: '01 (Yearly Plan)',
        badge: 'Default',
      ),
      GalleryEntry(
        group: '10_premium',
        title: '02 Premium Paywall (Monthly Selected)',
        subtitle: 'Monthly plan active (\$6.99/mo), Subscribe Monthly CTA',
        route: '${AppRoutes.premium}?plan=monthly',
        mockupFolder: 'mockups/DocScanner/10_premium/01_premium_paywall',
        mockupFrame: '01 (Monthly Plan)',
        badge: 'Monthly',
      ),
      GalleryEntry(
        group: '10_premium',
        title: '03 Premium Paywall (Weekly Selected)',
        subtitle: 'Weekly plan active (\$2.99/wk), Subscribe Weekly CTA',
        route: '${AppRoutes.premium}?plan=weekly',
        mockupFolder: 'mockups/DocScanner/10_premium/01_premium_paywall',
        mockupFrame: '01 (Weekly Plan)',
        badge: 'Weekly',
      ),
    ],
  ),
];

/// Flat list of every gallery entry for automated testing and auditing.
final List<GalleryEntry> kGalleryEntries = <GalleryEntry>[
  for (final GallerySection section in kGallerySections) ...section.items,
];
