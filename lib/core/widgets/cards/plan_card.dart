import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Subscription tier selection card designed for the Premium Paywall screen.
class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.title,
    required this.priceText,
    this.periodText,
    this.secondaryPriceText,
    this.badgeText,
    this.isSelected = false,
    required this.onTap,
  });

  final String title;
  final String priceText;
  final String? periodText;
  final String? secondaryPriceText;
  final String? badgeText;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Material(
          color: isSelected
              ? docColors.primaryTint
              : Theme.of(context).cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadii.roundedCard,
            side: BorderSide(
              color: isSelected ? AppColors.primary : docColors.hairline,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: <Widget>[
                  // Radio circle indicator
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textMuted,
                        width: 2.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: isSelected
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: AppTypography.headlineSm.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (secondaryPriceText != null) ...<Widget>[
                          const SizedBox(height: 2),
                          Text(
                            secondaryPriceText!,
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        priceText,
                        style: AppTypography.headlineSm.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? AppColors.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      if (periodText != null)
                        Text(
                          periodText!,
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (badgeText != null)
          Positioned(
            top: -10,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: docColors.gold,
                borderRadius: AppRadii.roundedPill,
              ),
              child: Text(
                badgeText!,
                style: AppTypography.labelSm.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
