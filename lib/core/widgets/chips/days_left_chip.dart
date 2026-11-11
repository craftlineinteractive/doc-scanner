import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Trash retention chip indicating remaining days, dynamically alerting red when under 3 days.
class DaysLeftChip extends StatelessWidget {
  const DaysLeftChip({super.key, required this.daysRemaining});

  final int daysRemaining;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;
    final bool isCritical = daysRemaining <= 3;

    final Color bg = isCritical
        ? docColors.destructiveTint
        : docColors.goldTint;
    final Color fg = isCritical ? docColors.destructive : AppColors.goldDark;

    final String label = daysRemaining == 1
        ? '1 day left'
        : '$daysRemaining days left';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: AppRadii.roundedPill),
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
