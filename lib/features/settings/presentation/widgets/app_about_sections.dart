import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/dialogs/confirm_dialog.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/inputs/settings_section.dart';
import '../../../../core/widgets/inputs/settings_tile.dart';
import '../../application/settings_provider.dart';
import '../../domain/app_settings.dart';

/// Renders APP, ABOUT settings sections and the application version caption.
class AppAboutSections extends ConsumerWidget {
  const AppAboutSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppSettings settings = ref.watch(settingsProvider);
    final SettingsNotifier notifier = ref.read(settingsProvider.notifier);

    return Column(
      children: <Widget>[
        SettingsSection(
          title: 'APP',
          children: <Widget>[
            SettingsTile(
              title: 'Language',
              subtitle: 'App language',
              icon: const Icon(Symbols.language_rounded),
              valueText: settings.appLanguage,
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Language is coming later',
              ),
            ),
            SettingsTile(
              title: 'Analytics',
              subtitle: 'Help improve Doc Scanner with anonymous usage data',
              icon: const Icon(Symbols.analytics_rounded),
              trailing: Switch.adaptive(
                value: settings.analytics,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setAnalytics,
              ),
            ),
            SettingsTile(
              title: 'Send to Email',
              subtitle: 'Add or delete saved email addresses',
              icon: const Icon(Symbols.mail_rounded),
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Send to Email is coming later',
              ),
            ),
            SettingsTile(
              title: 'Enable System Gallery',
              subtitle: 'Use the system gallery as default picker',
              icon: const Icon(Symbols.photo_library_rounded),
              trailing: Switch.adaptive(
                value: settings.enableSystemGallery,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setEnableSystemGallery,
              ),
            ),
            SettingsTile(
              title: 'Folder Navigation Path',
              subtitle: 'Show the folder path in the app',
              icon: const Icon(Symbols.folder_open_rounded),
              trailing: Switch.adaptive(
                value: settings.folderNavigationPath,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setFolderNavigationPath,
              ),
            ),
            SettingsTile(
              title: 'Reset Settings',
              subtitle: 'Reset all saved settings. Documents are not deleted.',
              icon: const Icon(Symbols.delete_outline_rounded),
              isDestructive: true,
              onTap: () async {
                final bool? confirmed = await ConfirmDialog.show(
                  context: context,
                  title: 'Reset all settings?',
                  message: 'Your documents will not be deleted.',
                  confirmLabel: 'Reset',
                  cancelLabel: 'Cancel',
                  isDestructive: true,
                );
                if (confirmed == true) {
                  notifier.resetSettings();
                  if (context.mounted) {
                    showAppSnackbar(
                      context: context,
                      message: 'Settings reset',
                    );
                  }
                }
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'ABOUT',
          children: <Widget>[
            SettingsTile(
              title: 'Send Feedback by Email',
              subtitle: 'Help us improve Doc Scanner',
              icon: const Icon(Symbols.feedback_rounded),
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Send Feedback is coming later',
              ),
            ),
            SettingsTile(
              title: 'Privacy Policy',
              subtitle: 'Read our privacy terms',
              icon: const Icon(Symbols.policy_rounded),
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Privacy Policy is coming later',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxl),
        Center(
          child: Text(
            'Doc Scanner version 1.0.0',
            style: AppTypography.labelMd.copyWith(
              color: AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}
