import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Single item row inside the navigation drawer with a rounded tinted icon box and label.
class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.backgroundColor,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;
    final Color fg = iconColor ?? AppColors.primary;
    final Color bg = backgroundColor ?? docColors.primaryTint;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.roundedInput,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: IconTheme(
                  data: IconThemeData(color: fg, size: 20),
                  child: icon,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.labelMd.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
