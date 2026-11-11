import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Gold-accented PRO status pill for headers and subscription upsells.
class ProPill extends StatelessWidget {
  const ProPill({super.key, this.onTap, this.label = 'PRO'});

  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    final Widget pill = Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: docColors.goldTint,
        borderRadius: AppRadii.roundedPill,
        border: Border.all(
          color: docColors.gold.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Symbols.workspace_premium_rounded,
            color: docColors.gold,
            size: 16,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSm.copyWith(
              color: const Color(0xFF783200),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: AppRadii.roundedPill,
        child: pill,
      );
    }
    return pill;
  }
}
