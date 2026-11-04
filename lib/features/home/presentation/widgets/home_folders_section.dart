import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/scan_folder.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/doc_colors.dart';
import '../../../../core/widgets/cards/folder_tile.dart';
import '../../../../core/widgets/chips/count_badge.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';

/// Folders section displaying folder count and category tiles on the Home screen.
class HomeFoldersSection extends StatelessWidget {
  const HomeFoldersSection({
    super.key,
    required this.folders,
  });

  final List<ScanFolder> folders;

  @override
  Widget build(BuildContext context) {
    if (folders.isEmpty) return const SizedBox.shrink();

    final DocColors docColors = context.docColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  AppStrings.folders,
                  style: AppTypography.headlineSm.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                CountBadge(count: folders.length),
              ],
            ),
            IconButton(
              icon: const Icon(Symbols.create_new_folder_rounded, size: 20),
              color: AppColors.primary,
              tooltip: 'New Folder',
              onPressed: () => showAppSnackbar(
                context: context,
                message: 'New folder sheet is coming later',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),

        // 3-column Folder tiles row
        Row(
          children: folders.asMap().entries.map((entry) {
            final int index = entry.key;
            final ScanFolder folder = entry.value;
            final (Color accent, Color pastel) =
                _resolveCategoryColors(folder.categoryColorKey, docColors);

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < folders.length - 1 ? AppSpacing.sm : 0,
                ),
                child: FolderTile(
                  title: folder.name,
                  itemCountText: folder.summaryText,
                  icon: Icon(folder.icon),
                  accentColor: accent,
                  pastelBackgroundColor: pastel,
                  onTap: () => showAppSnackbar(
                    context: context,
                    message: '${folder.name} is coming later',
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  (Color, Color) _resolveCategoryColors(String key, DocColors docColors) {
    switch (key) {
      case 'orange':
        return (docColors.categoryOrange, docColors.categoryOrangeTint);
      case 'emerald':
        return (docColors.categoryEmerald, docColors.categoryEmeraldTint);
      case 'rose':
        return (docColors.categoryRose, docColors.categoryRoseTint);
      case 'indigo':
      default:
        return (docColors.categoryIndigo, docColors.categoryIndigoTint);
    }
  }
}
