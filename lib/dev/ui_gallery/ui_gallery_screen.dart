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
          title: '01 Post-Scan Viewer Suite (5 Frames)',
          subtitle: 'Edit tools, OCR preview card, More Options sheet',
          route: AppRoutes.postScanViewer,
        ),
        _GalleryItem(
          title: '02 Saved Document Viewer Suite (5 Frames)',
          subtitle: 'Version selection dialog, 2-tier and 3-tier sub-rows',
          route: AppRoutes.savedViewer,
        ),
        _GalleryItem(
          title: '03 Multi-Page Manager Suite (3 Frames)',
          subtitle: '2-column page grid, action drawer sheet, in-doc search',
          route: AppRoutes.pageManager,
        ),
      ],
    ),
    _GallerySection(
      number: '06',
      title: '06_pdf_tools',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 PDF Tools Toolkit Suite (4 Frames)',
          subtitle: 'PDF viewer, 14-tool drawer, text search, help modal',
          route: AppRoutes.pdfViewer,
        ),
      ],
    ),
    _GallerySection(
      number: '07',
      title: '07_ocr',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 OCR Result Screen',
          subtitle: 'Accuracy badge, extracted text viewer, Copy & Share actions',
          route: AppRoutes.ocrResult,
        ),
      ],
    ),
    _GallerySection(
      number: '08',
      title: '08_trash',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Trash Suite (5 Frames)',
          subtitle: 'Retention info, days left chips, batch restore/delete',
          route: AppRoutes.trash,
        ),
      ],
    ),
    _GallerySection(
      number: '09',
      title: '09_settings',
      items: <_GalleryItem>[
        _GalleryItem(
          title: '01 Settings Suite (6 Frames)',
          subtitle: 'Backup, Document, Camera sections, radio and picker dialogs',
          route: AppRoutes.settings,
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
