import 'package:flutter/material.dart';
import '../../constants/app_durations.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Shows a standard floating feedback snackbar with an optional Undo action.
void showAppSnackbar({
  required BuildContext context,
  required String message,
  VoidCallback? onUndo,
  String undoLabel = AppStrings.undo,
  Duration duration = AppDurations.snackbarDuration,
}) {
  final DocColors docColors = context.docColors;

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: AppTypography.bodyMd.copyWith(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.textPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadii.roundedInput,
      ),
      duration: duration,
      action: onUndo != null
          ? SnackBarAction(
              label: undoLabel,
              textColor: docColors.gold,
              onPressed: onUndo,
            )
          : null,
    ),
  );
}

