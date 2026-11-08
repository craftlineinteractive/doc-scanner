import 'package:flutter/material.dart';
import '../../../../core/widgets/dialogs/radio_dialog.dart';
import '../../domain/app_settings.dart';

/// Selection dialog for choosing the document export quality preset.
class ScanQualityDialog {
  const ScanQualityDialog._();

  static Future<SettingsScanQuality?> show(
    BuildContext context,
    SettingsScanQuality initialValue,
  ) {
    return RadioDialog.show<SettingsScanQuality>(
      context: context,
      title: 'Scan quality',
      options: SettingsScanQuality.values,
      initialValue: initialValue,
      optionLabels: <SettingsScanQuality, String>{
        for (final SettingsScanQuality q in SettingsScanQuality.values)
          q: q.label,
      },
      optionSubtitles: <SettingsScanQuality, String>{
        for (final SettingsScanQuality q in SettingsScanQuality.values)
          q: q.subtitle,
      },
      confirmLabel: 'OK',
      cancelLabel: 'Cancel',
    );
  }
}
