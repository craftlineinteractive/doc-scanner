import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Vertical tool action button with an icon stacked above a label, supporting a selected state.
class ToolButton extends StatelessWidget {
  const ToolButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
    this.isSelected = false,
    this.color,
  });

  final Widget icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;
    final Color activeColor = color ?? AppColors.primary;
    final Color inactiveColor = Theme.of(context).colorScheme.onSurface;

    final Color fgColor = isSelected ? activeColor : inactiveColor;
    final Color bgTile = isSelected ? docColors.primaryTint : Colors.transparent;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 54, minHeight: 52),
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppRadii.roundedInput,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xs,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: bgTile,
                  borderRadius: AppRadii.roundedInput,
                ),
                alignment: Alignment.center,
                child: IconTheme(
                  data: IconThemeData(color: fgColor, size: 22),
                  child: icon,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTypography.labelSm.copyWith(
                  color: fgColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

