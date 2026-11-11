import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/doc_colors.dart';
import '../../../../core/widgets/chips/status_chip.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/inputs/segmented_pill.dart';
import '../../application/home_providers.dart';

/// Floating overflow menu anchored from the top-right more actions button.
class HomeOverflowMenu extends ConsumerStatefulWidget {
  const HomeOverflowMenu({super.key, this.initialImportExpanded = false});

  final bool initialImportExpanded;

  static Future<void> show({
    required BuildContext context,
    bool initialImportExpanded = false,
  }) {
    final double topOffset = MediaQuery.paddingOf(context).top + 52.0;

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.2),
      transitionDuration: const Duration(milliseconds: 180),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1.0).animate(
              CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic),
            ),
            alignment: Alignment.topRight,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, _) {
        return SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: topOffset,
                right: AppSpacing.screenMargin,
                width: 288,
                child: Material(
                  color: Colors.transparent,
                  child: HomeOverflowMenu(
                    initialImportExpanded: initialImportExpanded,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  ConsumerState<HomeOverflowMenu> createState() => _HomeOverflowMenuState();
}

class _HomeOverflowMenuState extends ConsumerState<HomeOverflowMenu> {
  String _selectedFormat = 'PDF';
  late bool _isImportExpanded;

  @override
  void initState() {
    super.initState();
    _isImportExpanded = widget.initialImportExpanded;
  }

  void _closeAndNotify(String message) {
    Navigator.of(context).pop();
    showAppSnackbar(context: context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;
    final HomeViewMode viewMode = ref.watch(homeViewModeProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: AppRadii.roundedCard,
        boxShadow: AppShadows.level3,
        border: Border.all(color: docColors.hairline),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Export Preset row
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Symbols.picture_as_pdf_rounded,
                        size: 20,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Flexible(
                        child: Text(
                          'Export Preset',
                          style: AppTypography.labelMd.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SegmentedPill<String>(
                  items: const <String>['PDF', 'JPG'],
                  selectedItem: _selectedFormat,
                  onSelected: (String val) =>
                      setState(() => _selectedFormat = val),
                ),
              ],
            ),
          ),
          _buildDivider(),

          // Import expandable row
          InkWell(
            onTap: () => setState(() => _isImportExpanded = !_isImportExpanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Symbols.drive_folder_upload_rounded,
                        size: 20,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Import',
                        style: AppTypography.labelMd.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    _isImportExpanded
                        ? Symbols.expand_more_rounded
                        : Symbols.chevron_right_rounded,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ),
          if (_isImportExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.xs,
              ),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: <Widget>[
                  _buildImportChip('Files (PDF, Doc)', isPrimary: true),
                  _buildImportChip('Gallery'),
                  _buildImportChip('ID Badge'),
                  _buildImportChip('Passport'),
                ],
              ),
            ),

          // PDF Tools
          _buildMenuItem(
            icon: Symbols.build_rounded,
            label: 'PDF Tools',
            trailing: const StatusChip(
              label: 'OCR Ready',
              variant: StatusChipVariant.success,
            ),
            onTap: () {
              Navigator.of(context).pop();
              context.push(AppRoutes.pdfViewer);
            },
          ),
          _buildDivider(),

          // Sort By
          _buildMenuItem(
            icon: Symbols.swap_vert_rounded,
            label: 'Sort By',
            trailing: Text(
              'Modified',
              style: AppTypography.bodySm.copyWith(color: AppColors.textMuted),
            ),
            onTap: () => _closeAndNotify('Sort options are coming later'),
          ),

          // Select Items
          _buildMenuItem(
            icon: Symbols.check_box_rounded,
            label: 'Select Items',
            onTap: () => _closeAndNotify('Select Items is coming later'),
          ),

          // Create Folder
          _buildMenuItem(
            icon: Symbols.create_new_folder_rounded,
            label: 'Create Folder',
            onTap: () => _closeAndNotify('New folder sheet is coming later'),
          ),
          _buildDivider(),

          // Sync Now
          _buildMenuItem(
            icon: Symbols.sync_rounded,
            label: 'Sync Now',
            trailing: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: docColors.success,
                shape: BoxShape.circle,
              ),
            ),
            onTap: () => _closeAndNotify('Syncing documents...'),
          ),

          // View Mode
          _buildMenuItem(
            icon: viewMode == HomeViewMode.list
                ? Symbols.grid_view_rounded
                : Symbols.view_list_rounded,
            label: 'View Mode',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: docColors.hairline,
                borderRadius: AppRadii.roundedPill,
              ),
              child: Text(
                viewMode == HomeViewMode.list ? 'Grid' : 'List',
                style: AppTypography.labelSm.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            onTap: () {
              ref.read(homeViewModeProvider.notifier).toggle();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 9,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(icon, size: 20, color: AppColors.textMuted),
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(
                    child: Text(
                      label,
                      style: AppTypography.labelMd.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildImportChip(String label, {bool isPrimary = false}) {
    final DocColors docColors = context.docColors;
    return InkWell(
      onTap: () => _closeAndNotify('$label import is coming later'),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isPrimary ? docColors.primaryTint : docColors.hairline,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: AppTypography.labelSm.copyWith(
            fontWeight: FontWeight.w500,
            color: isPrimary
                ? AppColors.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 3),
      child: Divider(color: AppColors.hairline, height: 1),
    );
  }
}
