import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Single interactive setting row supporting trailing chevrons, value labels, or switches.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
    this.trailing,
    this.valueText,
    this.isEnabled = true,
    this.onDisabledTap,
    this.isDestructive = false,
  });

  final String title;
  final String? subtitle;
  final Widget? icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final String? valueText;
  final bool isEnabled;
  final VoidCallback? onDisabledTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;
    final Color textColor = isDestructive
        ? AppColors.destructive
        : (isEnabled
            ? Theme.of(context).colorScheme.onSurface
            : AppColors.textMuted.withValues(alpha: 0.6));

    final Color iconBg = isDestructive
        ? AppColors.destructiveTint
        : (isEnabled
            ? docColors.primaryTint
            : docColors.surfaceSubdued);

    final Color iconColor = isDestructive
        ? AppColors.destructive
        : (isEnabled ? AppColors.primary : AppColors.textMuted);

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.6,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: InkWell(
          onTap: isEnabled ? onTap : onDisabledTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: IconTheme(
                      data: IconThemeData(
                        color: iconColor,
                        size: 20,
                      ),
                      child: icon!,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: AppTypography.labelMd.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      if (subtitle != null) ...<Widget>[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (valueText != null) ...<Widget>[
                  const SizedBox(width: AppSpacing.sm),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: Text(
                      valueText!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: AppTypography.labelMd.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                if (trailing != null) ...<Widget>[
                  const SizedBox(width: AppSpacing.sm),
                  trailing!,
                ] else if (onTap != null) ...<Widget>[
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Symbols.chevron_right_rounded,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
