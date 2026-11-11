import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Semantic status variant defining the visual tone of a StatusChip.
enum StatusChipVariant {
  success,
  warning,
  neutral,
  primary,
}

/// Compact pill status badge used for sync status, on-device tags, and feature flags.
class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    this.variant = StatusChipVariant.success,
  });

  final String label;
  final StatusChipVariant variant;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    Color bg;
    Color fg;

    switch (variant) {
      case StatusChipVariant.success:
        bg = docColors.successTint;
        fg = docColors.success;
        break;
      case StatusChipVariant.warning:
        bg = docColors.goldTint;
        fg = AppColors.goldDark;
        break;
      case StatusChipVariant.primary:
        bg = docColors.primaryTint;
        fg = AppColors.primary;
        break;
      case StatusChipVariant.neutral:
        bg = docColors.surfaceSubdued;
        fg = AppColors.textMuted;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadii.roundedPill,
      ),
      child: Text(
        label,
        style: AppTypography.labelSm.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}

