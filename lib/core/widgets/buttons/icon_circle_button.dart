import 'package:flutter/material.dart';

/// Circular icon button with guaranteed 48x48 touch target and subtle hover/active states.
class IconCircleButton extends StatelessWidget {
  const IconCircleButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 44.0,
    this.tooltip,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final Color fg = iconColor ?? Theme.of(context).colorScheme.onSurface;

    final Widget button = Material(
      color: backgroundColor ?? Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: IconTheme(
            data: IconThemeData(color: fg, size: 22),
            child: icon,
          ),
        ),
      ),
    );

    final Widget paddedButton = ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Center(child: button),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: paddedButton);
    }
    return paddedButton;
  }
}
