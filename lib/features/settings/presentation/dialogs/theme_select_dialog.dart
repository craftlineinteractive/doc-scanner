import 'package:flutter/material.dart';
import '../../../../core/widgets/dialogs/radio_dialog.dart';
import '../../domain/app_settings.dart';

/// Selection dialog for choosing the application theme mode.
class ThemeSelectDialog {
  const ThemeSelectDialog._();

  static Future<ThemeChoice?> show(
    BuildContext context,
    ThemeChoice initialValue,
  ) {
    return RadioDialog.show<ThemeChoice>(
      context: context,
      title: 'Theme',
      options: ThemeChoice.values,
      initialValue: initialValue,
      optionLabels: <ThemeChoice, String>{
        for (final ThemeChoice choice in ThemeChoice.values) choice: choice.label,
      },
      confirmLabel: 'OK',
      cancelLabel: 'Cancel',
    );
  }
}
