import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/inputs/settings_section.dart';
import '../../../../core/widgets/inputs/settings_tile.dart';
import '../../application/settings_provider.dart';
import '../../domain/app_settings.dart';
import '../dialogs/color_filter_dialog.dart';
import '../dialogs/name_format_dialog.dart';
import '../dialogs/scan_quality_dialog.dart';

/// Renders PDF, DOCUMENT, OCR, and CAMERA settings sections.
class DocumentCameraSections extends ConsumerWidget {
  const DocumentCameraSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppSettings settings = ref.watch(settingsProvider);
    final SettingsNotifier notifier = ref.read(settingsProvider.notifier);

    return Column(
      children: <Widget>[
        SettingsSection(
          title: 'PDF',
          children: <Widget>[
            SettingsTile(
              title: 'PDF Settings',
              subtitle: 'Page size, orientation, margins',
              icon: const Icon(Symbols.picture_as_pdf_rounded),
              onTap: () => showAppSnackbar(
                context: context,
                message: 'PDF Settings is coming later',
              ),
            ),
          ],
        ),
        SettingsSection(
          title: 'DOCUMENT',
          children: <Widget>[
            SettingsTile(
              title: 'Document Import and Export',
              subtitle: 'Import and export documents to local storage',
              icon: const Icon(Symbols.import_export_rounded),
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Document Import and Export is coming later',
              ),
            ),
            SettingsTile(
              title: 'New Document Name Format',
              subtitle: 'Template for auto-naming new documents',
              icon: const Icon(Symbols.edit_note_rounded),
              valueText: settings.newDocNameFormat,
              onTap: () async {
                final String? format = await NameFormatDialog.show(
                  context,
                  settings.newDocNameFormat,
                );
                if (format != null) {
                  notifier.setNewDocNameFormat(format);
                }
              },
            ),
            SettingsTile(
              title: 'Scan Quality',
              subtitle: 'Export quality',
              icon: const Icon(Symbols.auto_awesome_rounded),
              valueText: settings.scanQuality.label,
              onTap: () async {
                final SettingsScanQuality? quality =
                    await ScanQualityDialog.show(
                  context,
                  settings.scanQuality,
                );
                if (quality != null) {
                  notifier.setScanQuality(quality);
                }
              },
            ),
            SettingsTile(
              title: 'Default Color Filter',
              subtitle: 'Applied to new scans',
              icon: const Icon(Symbols.filter_b_and_w_rounded),
              valueText: settings.defaultColorFilter,
              onTap: () async {
                final String? filter = await ColorFilterDialog.show(
                  context,
                  settings.defaultColorFilter,
                );
                if (filter != null) {
                  notifier.setDefaultColorFilter(filter);
                }
              },
            ),
            SettingsTile(
              title: 'Protect Document',
              subtitle: 'App lock with PIN or fingerprint',
              icon: const Icon(Symbols.lock_rounded),
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Protect Document is coming later',
              ),
            ),
            SettingsTile(
              title: 'Auto Save to Gallery',
              subtitle: 'Save new scans into your gallery',
              icon: const Icon(Symbols.image_rounded),
              onTap: () => notifier.setAutoSaveToGallery(!settings.autoSaveToGallery),
              trailing: Switch.adaptive(
                value: settings.autoSaveToGallery,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setAutoSaveToGallery,
              ),
            ),
          ],
        ),
        SettingsSection(
          title: 'OCR',
          children: <Widget>[
            SettingsTile(
              title: 'OCR Settings',
              subtitle: 'Language and text recognition',
              icon: const Icon(Symbols.document_scanner_rounded),
              valueText: settings.ocrLanguage,
              onTap: () => showAppSnackbar(
                context: context,
                message: 'OCR Settings is coming later',
              ),
            ),
          ],
        ),
        SettingsSection(
          title: 'CAMERA',
          children: <Widget>[
            SettingsTile(
              title: 'System Camera',
              subtitle: 'Capture a single document only',
              icon: const Icon(Symbols.photo_camera_rounded),
              onTap: () => notifier.setSystemCamera(!settings.systemCamera),
              trailing: Switch.adaptive(
                value: settings.systemCamera,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setSystemCamera,
              ),
            ),
            SettingsTile(
              title: 'Set Camera as Home',
              subtitle: 'Open the camera on launch',
              icon: const Icon(Symbols.home_rounded),
              onTap: () => notifier.setCameraAsHome(!settings.cameraAsHome),
              trailing: Switch.adaptive(
                value: settings.cameraAsHome,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setCameraAsHome,
              ),
            ),
            SettingsTile(
              title: 'Capture Sound',
              subtitle: 'Play a sound when capturing',
              icon: const Icon(Symbols.volume_up_rounded),
              onTap: () => notifier.setCaptureSound(!settings.captureSound),
              trailing: Switch.adaptive(
                value: settings.captureSound,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setCaptureSound,
              ),
            ),
            SettingsTile(
              title: 'Volume Buttons to Capture',
              subtitle: 'Use volume keys as the shutter',
              icon: const Icon(Symbols.camera_rounded),
              onTap: () => notifier.setVolumeButtonsCapture(!settings.volumeButtonsCapture),
              trailing: Switch.adaptive(
                value: settings.volumeButtonsCapture,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setVolumeButtonsCapture,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
