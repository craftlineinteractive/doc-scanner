import 'package:flutter/material.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Semantic pastel category folder tile displaying an icon badge, title, and item count.
class FolderTile extends StatelessWidget {
  const FolderTile({
    super.key,
    required this.title,
    required this.itemCountText,
    required this.icon,
    required this.accentColor,
    required this.pastelBackgroundColor,
    this.onTap,
  });

  final String title;
  final String itemCountText;
  final Widget icon;
  final Color accentColor;
  final Color pastelBackgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: AppRadii.roundedCard,
        border: Border.all(color: docColors.hairline),
        boxShadow: AppShadows.level1,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadii.roundedCard,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: pastelBackgroundColor,
                    borderRadius: AppRadii.roundedInput,
                  ),
                  alignment: Alignment.center,
                  child: IconTheme(
                    data: IconThemeData(color: accentColor, size: 22),
                    child: icon,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  title,
                  style: AppTypography.labelMd.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  itemCountText,
                  style: AppTypography.bodySm.copyWith(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
