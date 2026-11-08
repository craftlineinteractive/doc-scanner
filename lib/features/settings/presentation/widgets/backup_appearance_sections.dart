import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/inputs/settings_section.dart';
import '../../../../core/widgets/inputs/settings_tile.dart';
import '../../application/settings_provider.dart';
import '../../domain/app_settings.dart';
import '../dialogs/date_format_dialog.dart';
import '../dialogs/recent_count_dialog.dart';
import '../dialogs/theme_select_dialog.dart';

/// Renders BACKUP & SYNC and APPEARANCE & HOME settings sections.
class BackupAppearanceSections extends ConsumerWidget {
  const BackupAppearanceSections({
    super.key,
    required this.onShowHintToast,
  });

  final VoidCallback onShowHintToast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppSettings settings = ref.watch(settingsProvider);
    final SettingsNotifier notifier = ref.read(settingsProvider.notifier);

    return Column(
      children: <Widget>[
        SettingsSection(
          title: 'BACKUP & SYNC',
          children: <Widget>[
            SettingsTile(
              title: 'Auto Local Backup and Restore',
              subtitle: 'Protect your data from accidental loss',
              icon: const Icon(Symbols.shield_rounded),
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Auto Local Backup and Restore is coming later',
              ),
            ),
            SettingsTile(
              title: 'Cloud Sync',
              subtitle: 'Back up documents to Google Drive',
              icon: const Icon(Symbols.cloud_sync_rounded),
              valueText: settings.cloudSyncOn ? 'On' : 'Off',
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Cloud Sync is coming later',
              ),
            ),
          ],
        ),
        SettingsSection(
          title: 'APPEARANCE & HOME',
          children: <Widget>[
            SettingsTile(
              title: 'Theme',
              subtitle: 'Choose how Doc Scanner looks',
              icon: const Icon(Symbols.light_mode_rounded),
              valueText: settings.themeChoice.label,
              onTap: () async {
                final ThemeChoice? choice = await ThemeSelectDialog.show(
                  context,
                  settings.themeChoice,
                );
                if (choice != null) {
                  notifier.setThemeChoice(choice);
                }
              },
            ),
            SettingsTile(
              title: 'Date and Time Format',
              subtitle: 'Used for folders, documents and images',
              icon: const Icon(Symbols.calendar_today_rounded),
              valueText: settings.dateTimeFormat.label,
              onTap: () async {
                final SettingsDateTimeFormat? format =
                    await DateFormatDialog.show(
                  context,
                  settings.dateTimeFormat,
                );
                if (format != null) {
                  notifier.setDateTimeFormat(format);
                }
              },
            ),
            SettingsTile(
              title: 'Tools Shortcut',
              subtitle: 'Show tools on home screen',
              icon: const Icon(Symbols.widgets_rounded),
              trailing: Switch.adaptive(
                value: settings.toolsShortcut,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setToolsShortcut,
              ),
            ),
            SettingsTile(
              title: 'Tags',
              subtitle: 'Show tags on home screen',
              icon: const Icon(Symbols.label_rounded),
              trailing: Switch.adaptive(
                value: settings.tags,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setTags,
              ),
            ),
            SettingsTile(
              title: 'Favourite Documents',
              subtitle: 'Show favourites on home screen',
              icon: const Icon(Symbols.favorite_rounded),
              isEnabled: settings.tags,
              onDisabledTap: onShowHintToast,
              onTap: settings.tags
                  ? () => notifier.setFavouriteDocuments(
                        !settings.favouriteDocuments,
                      )
                  : onShowHintToast,
              trailing: Switch.adaptive(
                value: settings.favouriteDocuments,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: settings.tags
                    ? notifier.setFavouriteDocuments
                    : (_) => onShowHintToast(),
              ),
            ),
            SettingsTile(
              title: 'Recent Documents',
              subtitle: 'Show recent documents on home screen',
              icon: const Icon(Symbols.history_rounded),
              trailing: Switch.adaptive(
                value: settings.recentDocuments,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primary,
                onChanged: notifier.setRecentDocuments,
              ),
            ),
            SettingsTile(
              title: 'Recent Documents on Home',
              subtitle: 'How many to show',
              icon: const Icon(Symbols.view_list_rounded),
              valueText: settings.recentOnHomeCount.toString(),
              onTap: () async {
                final int? count = await RecentCountDialog.show(
                  context,
                  settings.recentOnHomeCount,
                );
                if (count != null) {
                  notifier.setRecentOnHomeCount(count);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
