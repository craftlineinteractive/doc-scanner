import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../buttons/icon_circle_button.dart';

/// Standard top bar featuring a back button, title, and optional trailing action buttons.
class BackTitleBar extends StatelessWidget implements PreferredSizeWidget {
  const BackTitleBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final Color fg = foregroundColor ?? Theme.of(context).colorScheme.onSurface;
    final Color bg = backgroundColor ?? Theme.of(context).cardTheme.color!;

    return Container(
      color: bg,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: <Widget>[
              IconCircleButton(
                icon: const Icon(Symbols.arrow_back_rounded),
                iconColor: fg,
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                tooltip: 'Back',
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.headlineMd.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ...?actions,
              const SizedBox(width: AppSpacing.xs),
            ],
          ),
        ),
      ),
    );
  }
}
