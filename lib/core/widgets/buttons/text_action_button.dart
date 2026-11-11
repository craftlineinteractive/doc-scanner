import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Text-only or icon-text action button with guaranteed 48px touch target.
class TextActionButton extends StatelessWidget {
  const TextActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.color,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? color;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = isDestructive
        ? AppColors.destructive
        : (color ?? AppColors.primary);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: effectiveColor,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.roundedInput,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              IconTheme(
                data: IconThemeData(color: effectiveColor, size: 18),
                child: icon!,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(
              label,
              style: AppTypography.labelMd.copyWith(
                color: effectiveColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
