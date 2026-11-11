import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Gold card affordance promoting PRO membership upgrades with crown iconography.
class PremiumUpsellCard extends StatelessWidget {
  const PremiumUpsellCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: Material(
        color: docColors.goldTint,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.roundedCard,
          side: BorderSide(
            color: docColors.gold.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: docColors.gold.withValues(alpha: 0.2),
                    borderRadius: AppRadii.roundedInput,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Symbols.workspace_premium_rounded,
                    color: docColors.gold,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppStrings.upgradeToPremium,
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.goldDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppStrings.unlockAllFeatures,
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.goldMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Symbols.chevron_right_rounded,
                  color: AppColors.goldMuted,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
