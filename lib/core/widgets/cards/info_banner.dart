import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Informational micro-banner featuring an icon container, title, subtitle, and trailing status chip.
class InfoBanner extends StatelessWidget {
  const InfoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailingChip,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final Widget icon;
  final Widget? trailingChip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Material(
      color: docColors.primaryTint.withValues(alpha: 0.6),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.roundedCard,
        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.12)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadii.roundedInput,
                ),
                alignment: Alignment.center,
                child: IconTheme(
                  data: const IconThemeData(color: Colors.white, size: 20),
                  child: icon,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTypography.labelMd.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.textMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (trailingChip != null) ...<Widget>[
                const SizedBox(width: AppSpacing.sm),
                trailingChip!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
