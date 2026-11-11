import 'package:flutter/material.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../buttons/text_action_button.dart';
import 'app_dialog.dart';

/// Confirmation modal dialog with support for destructive action styling.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = AppStrings.delete,
    this.cancelLabel = AppStrings.cancel,
    this.isDestructive = true,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = AppStrings.delete,
    String cancelLabel = AppStrings.cancel,
    bool isDestructive = true,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      content: Text(
        message,
        style: AppTypography.bodyMd.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      actions: <Widget>[
        TextActionButton(
          label: cancelLabel,
          color: AppColors.textMuted,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextActionButton(
          label: confirmLabel,
          isDestructive: isDestructive,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
