import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Modal option selection card with leading icon tile, title, badge tag, subtitle, and trailing chevron.
class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.tag,
    this.tagColor,
    this.iconColor,
    this.iconBackgroundColor,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final Widget icon;
  final String? tag;
  final Color? tagColor;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;
    final Color effectiveIconColor = iconColor ?? AppColors.primary;
    final Color effectiveIconBg = iconBackgroundColor ?? docColors.primaryTint;

    return Material(
      color: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.roundedCard,
        side: BorderSide(color: docColors.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: effectiveIconBg,
                  borderRadius: AppRadii.roundedInput,
                ),
                alignment: Alignment.center,
                child: IconTheme(
                  data: IconThemeData(color: effectiveIconColor, size: 22),
                  child: icon,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            title,
                            style: AppTypography.labelMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (tag != null) ...<Widget>[
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: (tagColor ?? docColors.success).withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: AppRadii.roundedPill,
                            ),
                            child: Text(
                              tag!,
                              style: AppTypography.labelSm.copyWith(
                                color: tagColor ?? docColors.success,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
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
              const Icon(
                Symbols.chevron_right_rounded,
                color: AppColors.textMuted,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
