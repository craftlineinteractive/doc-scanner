import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../buttons/icon_circle_button.dart';

/// Standard modal bottom sheet container with drag handle, title row, subtitle, and 28px rounded top corners.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    required this.child,
    this.onClose,
    this.trailing,
    this.showDragHandle = true,
  });

  final String? title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onClose;
  final Widget? trailing;
  final bool showDragHandle;

  /// Helper to display this sheet using Flutter's showModalBottomSheet.
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? subtitle,
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppBottomSheet(
        title: title,
        subtitle: subtitle,
        onClose: () => Navigator.of(context).pop(),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: AppRadii.sheetRadius,
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        AppSpacing.sm,
        AppSpacing.screenMargin,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showDragHandle)
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.textMuted.withValues(alpha: 0.4),
                  borderRadius: AppRadii.roundedPill,
                ),
              ),
            ),
          if (title != null || onClose != null || trailing != null) ...<Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title!,
                          style: AppTypography.headlineSm.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (subtitle != null) ...<Widget>[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                else
                  const Spacer(),
                if (trailing != null) ...<Widget>[
                  trailing!,
                  const SizedBox(width: AppSpacing.xs),
                ],
                if (onClose != null)
                  IconCircleButton(
                    icon: const Icon(Symbols.close_rounded),
                    onPressed: onClose,
                    size: 36,
                    tooltip: 'Close',
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          Flexible(child: child),
        ],
      ),
    );
  }
}
