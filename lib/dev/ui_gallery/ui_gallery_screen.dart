import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../app/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/doc_colors.dart';

class _GalleryItem {
  const _GalleryItem({
    required this.title,
    required this.subtitle,
    required this.route,
    this.badge,
  });

  final String title;
  final String subtitle;
  final String route;
  final String? badge;
}

class _GallerySection {
  const _GallerySection({
    required this.number,
    required this.title,
    required this.items,
  });

  final String number;
  final String title;
  final List<_GalleryItem> items;
}

/// Debug-only gallery listing every screen and modal grouped by numbered mockup folder.
class UiGalleryScreen extends StatelessWidget {
  const UiGalleryScreen({super.key});

  static const List<_GallerySection> _sections = <_GallerySection>[
    _GallerySection(
      number: '00',
      title: 'Design System & Primitives',
      items: <_GalleryItem>[
        _GalleryItem(
          title: 'Components Gallery',
          subtitle: 'Buttons, Inputs, Cards, Chips, Sheets, and Dialogs',
          route: AppRoutes.components,
          badge: 'M1',
        ),
      ],
    ),
    _GallerySection(
      number: '01',
      title: '01_home',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Home Screen (List)',
          subtitle: 'Main screen, search, OCR banner, folders & doc cards',
          route: '${AppRoutes.home}?mode=list',
          badge: 'List',
        ),
        _GalleryItem(
          title: '01 Home Screen (Grid)',
          subtitle: '2-column documents grid layout with preview tiles',
          route: '${AppRoutes.home}?mode=grid',
          badge: 'Grid',
        ),
        _GalleryItem(
          title: '02 Home Overflow Menu',
          subtitle: 'Three-dot contextual popup over dimmed home',
          route: '${AppRoutes.home}?overflow=true',
          badge: 'Menu',
        ),
        _GalleryItem(
          title: '02 Home Overflow (Import Expanded)',
          subtitle: 'Import submenu expanded with format chips',
          route: '${AppRoutes.home}?overflow=true&importExpanded=true',
          badge: 'Expanded',
        ),
        _GalleryItem(
          title: '03 Home Empty State',
          subtitle: 'First-run onboarding illustration and hints',
          route: AppRoutes.homeEmpty,
          badge: 'Empty',
        ),
        _GalleryItem(
          title: '04 Add Document Sheet',
          subtitle: 'Import from gallery, PDF, or files modal',
          route: '${AppRoutes.home}?addSheet=true',
          badge: 'Sheet',
        ),
      ],
    ),
    _GallerySection(
      number: '02',
      title: '02_navigation_drawer',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Drawer Default (General Expanded)',
          subtitle: 'Signed-in header, sync status, General accordion open',
          route: AppRoutes.drawerSignedIn,
          badge: 'Default',
        ),
        _GalleryItem(
          title: '02 Drawer Signed Out',
          subtitle: 'Sign in with Google CTA header',
          route: AppRoutes.drawerSignedOut,
          badge: 'Auth',
        ),
        _GalleryItem(
          title: '03 Drawer Tools & Other Expanded',
          subtitle: 'PDF tools, signature, QR tools accordion open',
          route: AppRoutes.drawerToolsOther,
          badge: 'Accordion',
        ),
      ],
    ),
    _GallerySection(
      number: '03',
      title: '03_camera',
      items: <_GalleryItem>[
        _GalleryItem(
          title: 'Camera: Document (default)',
          subtitle: 'Document mode viewfinder, auto-detection and shutter bar',
          route: '${AppRoutes.camera}?mode=document',
          badge: 'Default',
        ),
        _GalleryItem(
          title: 'Camera: Photo mode layout',
          subtitle: 'Photo capture frame with aspect ratio hints',
          route: '${AppRoutes.camera}?mode=photo',
          badge: 'Mode',
        ),
        _GalleryItem(
          title: 'Camera: Settings panel open',
          subtitle: '10-tile camera settings grid with sound, level, grid toggles',
          route: '${AppRoutes.camera}?panel=settings',
          badge: 'Panel',
        ),
        _GalleryItem(
          title: 'Camera: Scan Quality sheet open',
          subtitle: 'Dark modal picker for Standard, High, and Max quality',
          route: '${AppRoutes.camera}?panel=quality',
          badge: 'Sheet',
        ),
        _GalleryItem(
          title: 'Camera: Flash states (Auto)',
          subtitle: 'Top bar flash indicator toggled to Auto state',
          route: '${AppRoutes.camera}?mode=document&flash=auto',
          badge: 'State',
        ),
        _GalleryItem(
          title: 'Camera: ID Card dialog',
          subtitle: 'Single Side vs Both Sides scan option cards',
          route: '${AppRoutes.camera}?mode=idCard&dialog=idCard',
          badge: 'Dialog',
        ),
        _GalleryItem(
          title: 'Camera: Book dialog',
          subtitle: 'Single Page, Two Pages, Flatten Curved options',
          route: '${AppRoutes.camera}?mode=book&dialog=book',
          badge: 'Dialog',
        ),
        _GalleryItem(
          title: 'Camera: Photo size dialog',
          subtitle: '2-column draggable reorderable photo preset sizes',
          route: '${AppRoutes.camera}?mode=photo&dialog=photo',
          badge: 'Dialog',
        ),
        _GalleryItem(
          title: 'Camera: Signature mode',
          subtitle: 'High contrast viewfinder for signature capture',
          route: '${AppRoutes.camera}?mode=signature',
          badge: 'Mode',
        ),
        _GalleryItem(
          title: 'Camera: QR Scanner mode',
          subtitle: 'Square viewfinder with animated scan line',
          route: '${AppRoutes.camera}?mode=qrScanner',
          badge: 'Mode',
        ),
        _GalleryItem(
          title: 'Camera: OCR dialog',
          subtitle: 'Edge AI on-device model and language selection dialog',
          route: '${AppRoutes.camera}?mode=ocrText&dialog=ocr',
          badge: 'Dialog',
        ),
      ],
    ),
    _GallerySection(
      number: '04',
      title: '04_scan_review',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Adjust Crop Default',
          subtitle: 'Dark adjust screen, quadrilateral 4-point crop handles',
          route: AppRoutes.adjust,
          badge: 'Default',
        ),
        _GalleryItem(
          title: '02 Adjust Dragging Corner',
          subtitle: 'Active corner drag with 2.5x circular magnifier loupe',
          route: '${AppRoutes.adjust}?drag=true',
          badge: 'Loupe',
        ),
        _GalleryItem(
          title: '03 Filter Bottom Sheet',
          subtitle: '5 presets (Auto Enhance, Vivid Light, Grayscale, etc.)',
          route: '${AppRoutes.adjust}?sheet=filters',
          badge: 'Sheet',
        ),
        _GalleryItem(
          title: '04A Document Name Dialog',
          subtitle: 'Prefilled name input with autofocus and selection',
          route: '${AppRoutes.adjust}?dialog=doc_name',
          badge: 'Dialog',
        ),
        _GalleryItem(
          title: '04B Crop Shape Sheet',
          subtitle: 'Free, Original, A4, Letter, Square aspect ratio radios',
          route: '${AppRoutes.adjust}?sheet=shape',
          badge: 'Sheet',
        ),
        _GalleryItem(
          title: '05 Review - Default',
          subtitle: 'Light theme multi-page review, bottom toolbar, 2 / 5 pill',
          route: AppRoutes.reviewScan,
          badge: 'Default',
        ),
        _GalleryItem(
          title: '05 Review - Crop Open',
          subtitle: 'Crop sub-toolbar with Free, Auto Detect sparkle, Flip',
          route: '${AppRoutes.reviewScan}?mode=crop',
          badge: 'Sub-mode',
        ),
        _GalleryItem(
          title: '05 Review - Color Open',
          subtitle: 'Horizontal filter strip with Apply to all pages toggle',
          route: '${AppRoutes.reviewScan}?mode=color',
          badge: 'Sub-mode',
        ),
        _GalleryItem(
          title: '05 Review - Arrange Pages',
          subtitle: '2-column page grid with drag-and-drop reordering',
          route: AppRoutes.arrangePages,
          badge: 'Reorder',
        ),
        _GalleryItem(
          title: '05 Review - Delete Page Dialog',
          subtitle: 'Confirmation dialog: Page N will be removed',
          route: '${AppRoutes.reviewScan}?dialog=delete',
          badge: 'Dialog',
        ),
        _GalleryItem(
          title: '05 Review - Discard Scan Dialog',
          subtitle: 'Warning dialog: All N pages will be lost',
          route: '${AppRoutes.reviewScan}?dialog=discard',
          badge: 'Dialog',
        ),
      ],
    ),
    _GallerySection(
      number: '05',
      title: '05_document_viewer',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Post-Scan Viewer - 01 Default',
          subtitle: '9-tool bottom bar, 1/3 pill, pinch-zoom A4 canvas',
          route: '${AppRoutes.postScanViewer}?tier=main',
          badge: 'Default',
        ),
        _GalleryItem(
          title: '01 Post-Scan Viewer - 02 Edit Tier',
          subtitle: 'Editing Mode banner & 2nd-tier floating sub-tool row',
          route: '${AppRoutes.postScanViewer}?tier=edit',
          badge: 'Edit',
        ),
        _GalleryItem(
          title: '01 Post-Scan Viewer - 03 Crop Tier',
          subtitle: '3rd-tier elevated crop bar, CropOverlay & aspect ratios',
          route: '${AppRoutes.postScanViewer}?tier=crop',
          badge: 'Crop',
        ),
        _GalleryItem(
          title: '01 Post-Scan Viewer - 04 OCR Panel',
          subtitle: 'OCR accuracy chip, highlighted text & extracted preview',
          route: '${AppRoutes.postScanViewer}?panel=ocr',
          badge: 'OCR',
        ),
        _GalleryItem(
          title: '01 Post-Scan Viewer - 05 More Options',
          subtitle: '7 action rows: rename, move, favorites, reorder, delete',
          route: '${AppRoutes.postScanViewer}?panel=more',
          badge: 'Sheet',
        ),
        _GalleryItem(
          title: '02 Saved Viewer - 1 Default',
          subtitle: 'Light theme canvas (#F4F6FA), 6-tool bar, 1/5 page pill',
          route: '${AppRoutes.savedViewer}?frame=1',
          badge: 'Default',
        ),
        _GalleryItem(
          title: '02 Saved Viewer - 2 Edit Choice Dialog',
          subtitle: 'Modal: Original document vs Last edited document',
          route: '${AppRoutes.savedViewer}?frame=2',
          badge: 'Dialog',
        ),
        _GalleryItem(
          title: '02 Saved Viewer - 3 Edit Sub-Row',
          subtitle: 'Sub-tool row: Crop, Color, Rotate, Erase, Sign, Watermark',
          route: '${AppRoutes.savedViewer}?frame=3',
          badge: 'Sub-Row',
        ),
        _GalleryItem(
          title: '02 Saved Viewer - 4 Crop Nested Sub-Row',
          subtitle: '3-tier toolbar stack with interactive quad crop handles',
          route: '${AppRoutes.savedViewer}?frame=4',
          badge: 'Crop',
        ),
        _GalleryItem(
          title: '02 Saved Viewer - 5 PDF Sub-Row & More',
          subtitle: 'PDF sub-row & More PDF Options bottom sheet',
          route: '${AppRoutes.savedViewer}?frame=5',
          badge: 'PDF',
        ),
        _GalleryItem(
          title: '03 Page Manager - 1 Default Grid',
          subtitle: '2-column page grid, Cloud Synced status & Dual Pill FAB',
          route: '${AppRoutes.pageManager}?state=grid',
          badge: 'Grid',
        ),
        _GalleryItem(
          title: '03 Page Manager - 2 Action Drawer',
          subtitle: '3x2 action matrix, Move, Copy, Collage PRO & DPI info',
          route: '${AppRoutes.pageManager}?state=drawer',
          badge: 'Drawer',
        ),
        _GalleryItem(
          title: '03 Page Manager - 3 Search & Instant PDF',
          subtitle: 'In-doc search "Invoice", 2 occurrences & instant jump',
          route: '${AppRoutes.pageManager}?state=search&q=Invoice',
          badge: 'Search',
        ),
      ],
    ),
    _GallerySection(
      number: '06',
      title: '06_pdf_tools',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 PDF Viewer Default',
          subtitle: 'Resting viewer, 6 pages, 68px bottom dock & page pill',
          route: '${AppRoutes.pdfViewer}?state=default',
          badge: 'Default',
        ),
        _GalleryItem(
          title: '02 PDF Toolkit Drawer Open',
          subtitle: '14 tools categorized, 9 document actions, conversions',
          route: '${AppRoutes.pdfViewer}?state=toolkit',
          badge: 'Toolkit',
        ),
        _GalleryItem(
          title: '03 In-Document Search',
          subtitle: 'Lexical search "Financial", 1/3 match counter & jump card',
          route: '${AppRoutes.pdfViewer}?state=search&q=Financial',
          badge: 'Search',
        ),
        _GalleryItem(
          title: '04 Contextual Help Modal',
          subtitle: 'How to Use PDF Tools, 5 numbered tips & Got It CTA',
          route: '${AppRoutes.pdfViewer}?state=help',
          badge: 'Help',
        ),
        _GalleryItem(
          title: '05 Add Password Dialog',
          subtitle: 'AES-256 encryption password dialog with visibility toggle',
          route: '${AppRoutes.pdfViewer}?state=password',
          badge: 'Dialog',
        ),
      ],
    ),
    _GallerySection(
      number: '07',
      title: '07_ocr',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 OCR Result Default',
          subtitle: '99.4% accuracy badge, consulting agreement, Copy/Share bar',
          route: '${AppRoutes.ocrResult}?state=default',
          badge: 'Default',
        ),
        _GalleryItem(
          title: '02 OCR Editing Text',
          subtitle: 'Inline multiline text editor with Done action',
          route: '${AppRoutes.ocrResult}?state=editing',
          badge: 'Edit',
        ),
        _GalleryItem(
          title: '03 OCR Original Preview Expanded',
          subtitle: 'Thumbnail expand toggle showing original document',
          route: '${AppRoutes.ocrResult}?state=preview',
          badge: 'Preview',
        ),
      ],
    ),
    _GallerySection(
      number: '08',
      title: '08_trash',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Trash - List Default',
          subtitle: 'Info banner, Folders (1), Documents (6), Days-left chips',
          route: '${AppRoutes.trash}?state=list',
          badge: 'List',
        ),
        _GalleryItem(
          title: '02 Trash - Empty State',
          subtitle: 'Trash is empty illustration, disabled 3-dot action',
          route: '${AppRoutes.trash}?state=empty',
          badge: 'Empty',
        ),
        _GalleryItem(
          title: '03 Top Bar Menu Open',
          subtitle: 'Anchored popup with Select, Restore all, Empty trash',
          route: '${AppRoutes.trash}?state=menu',
          badge: 'Menu',
        ),
        _GalleryItem(
          title: '04 Selection Mode (2 Selected)',
          subtitle: 'Round checkboxes, selection counter and bottom action bar',
          route: '${AppRoutes.trash}?state=selecting',
          badge: 'Select',
        ),
        _GalleryItem(
          title: '05A Item Options Sheet',
          subtitle: 'Item Options sheet with Restore and Delete forever',
          route: '${AppRoutes.trash}?state=options',
          badge: 'Options',
        ),
        _GalleryItem(
          title: '05B Delete Forever Dialog',
          subtitle: 'Destructive confirmation modal for permanent deletion',
          route: '${AppRoutes.trash}?state=deleteDialog',
          badge: 'Dialog',
        ),
        _GalleryItem(
          title: '05C Restored Toast with Undo',
          subtitle: 'Restored to Home toast notification with Undo action',
          route: '${AppRoutes.trash}?state=toast',
          badge: 'Toast',
        ),
      ],
    ),
    _GallerySection(
      number: '09',
      title: '09_settings',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Settings: Top (Backup & Appearance)',
          subtitle: 'Backup & Sync, Appearance & Home with theme, format, shortcuts',
          route: '${AppRoutes.settings}?scroll=top',
          badge: 'Top',
        ),
        _GalleryItem(
          title: '02 Settings: Middle (PDF & Document)',
          subtitle: 'PDF settings, name format, scan quality, color filter',
          route: '${AppRoutes.settings}?scroll=middle',
          badge: 'Middle',
        ),
        _GalleryItem(
          title: '03 Settings: Bottom (Camera & App)',
          subtitle: 'Camera toggles, sound, app options, reset button, version',
          route: '${AppRoutes.settings}?scroll=bottom',
          badge: 'Bottom',
        ),
        _GalleryItem(
          title: '04 Theme Dialog',
          subtitle: 'RadioDialog with System default, Light, and Dark',
          route: '${AppRoutes.settings}?dialog=theme',
          badge: 'Modal',
        ),
        _GalleryItem(
          title: '05 Scan Quality Dialog',
          subtitle: 'RadioDialog with Standard, High, and Original presets',
          route: '${AppRoutes.settings}?dialog=quality',
          badge: 'Modal',
        ),
        _GalleryItem(
          title: '06 Recent Documents Count Picker',
          subtitle: 'Count picker with 10, 25, 50, and 100 options',
          route: '${AppRoutes.settings}?dialog=count',
          badge: 'Picker',
        ),
        _GalleryItem(
          title: '07 Date and Time Format Picker',
          subtitle: 'Date format picker with 4 standard presentation patterns',
          route: '${AppRoutes.settings}?dialog=format',
          badge: 'Picker',
        ),
        _GalleryItem(
          title: '08 Reset Settings Confirmation',
          subtitle: 'Destructive modal confirm dialog with red button',
          route: '${AppRoutes.settings}?dialog=reset',
          badge: 'Destructive',
        ),
        _GalleryItem(
          title: '09 Hint Toast Notification',
          subtitle: 'Capsule toast: "Turn on Tags to use Favourite Documents"',
          route: '${AppRoutes.settings}?hint=true',
          badge: 'Toast',
        ),
      ],
    ),
    _GallerySection(
      number: '10',
      title: '10_premium',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Premium Paywall',
          subtitle: 'Crown hero, 8-feature checklist, plan picker, 3-day trial',
          route: AppRoutes.premium,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const Scaffold(
        body: Center(
          child: Text('UI Gallery is only available in debug mode.'),
        ),
      );
    }

    final DocColors docColors = context.docColors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Gallery'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.screenMargin),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: docColors.primaryTint,
                borderRadius: AppRadii.roundedPill,
              ),
              child: Text(
                'DEBUG ONLY',
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: AppSpacing.screenListPadding,
        itemCount: _sections.length,
        itemBuilder: (BuildContext context, int sectionIndex) {
          final _GallerySection section = _sections[sectionIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.md,
                  bottom: AppSpacing.sm,
                  left: AppSpacing.xs,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: section.number == '00'
                            ? AppColors.gold
                            : AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        section.number,
                        style: AppTypography.labelSm.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      section.title,
                      style: AppTypography.headlineSm.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Theme.of(context).cardTheme.color,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadii.roundedCard,
                  side: BorderSide(color: docColors.hairline),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: section.items.length,
                  separatorBuilder: (BuildContext context, int i) => Divider(
                    color: docColors.hairline,
                    height: 1,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    final _GalleryItem item = section.items[itemIndex];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      title: Text(
                        item.title,
                        style: AppTypography.labelMd.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        item.subtitle,
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (item.badge != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: docColors.primaryTint,
                                borderRadius: AppRadii.roundedPill,
                              ),
                              child: Text(
                                item.badge!,
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          const Icon(
                            Symbols.chevron_right_rounded,
                            size: 20,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                      onTap: () {
                        context.push(item.route);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          );
        },
      ),
    );
  }
}
