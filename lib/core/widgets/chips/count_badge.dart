import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Small circular or pill count indicator accompanying section headings.
class CountBadge extends StatelessWidget {
  const CountBadge({
    super.key,
    required this.count,
    this.backgroundColor,
    this.textColor,
  });

  final int count;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? docColors.surfaceSubdued,
        borderRadius: AppRadii.roundedPill,
      ),
      child: Text(
        count.toString(),
        style: AppTypography.labelSm.copyWith(
          color: textColor ?? AppColors.textMuted,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}

