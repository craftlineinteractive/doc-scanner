import 'package:flutter/material.dart';
import '../../../../core/widgets/dialogs/radio_dialog.dart';

/// Selection dialog for default color filter applied to new document scans.
class ColorFilterDialog {
  const ColorFilterDialog._();

  static const List<String> options = <String>[
    'Vivid Light',
    'Original',
    'Auto',
    'Grayscale',
    'B&W',
  ];

  static Future<String?> show(BuildContext context, String initialValue) {
    return RadioDialog.show<String>(
      context: context,
      title: 'Default Color Filter',
      options: options,
      initialValue: initialValue,
      confirmLabel: 'OK',
      cancelLabel: 'Cancel',
    );
  }
}
