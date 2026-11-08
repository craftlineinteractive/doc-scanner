import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/app.dart';
import '../../camera/application/camera_settings_provider.dart';
import '../data/mock_settings_repository.dart';
import '../domain/app_settings.dart';
import '../domain/settings_repository.dart';

/// Provider exposing the active [SettingsRepository].
final Provider<SettingsRepository> settingsRepositoryProvider =
    Provider<SettingsRepository>((ref) => MockSettingsRepository());

/// StateNotifier managing global app settings and syncing theme and camera sound.
class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    return AppSettings.defaults();
  }

  void setThemeChoice(ThemeChoice choice) {
    state = state.copyWith(themeChoice: choice);
    final ThemeMode mode = switch (choice) {
      ThemeChoice.system => ThemeMode.system,
      ThemeChoice.light => ThemeMode.light,
      ThemeChoice.dark => ThemeMode.dark,
    };
    ref.read(themeModeProvider.notifier).setThemeMode(mode);
  }

  void setCloudSync(bool value) {
    state = state.copyWith(cloudSyncOn: value);
  }

  void setDateTimeFormat(SettingsDateTimeFormat format) {
    state = state.copyWith(dateTimeFormat: format);
  }

  void setToolsShortcut(bool value) {
    state = state.copyWith(toolsShortcut: value);
  }

  void setTags(bool value) {
    if (!value) {
      // Dependency rule: turning tags off turns favouriteDocuments off
      state = state.copyWith(tags: false, favouriteDocuments: false);
    } else {
      state = state.copyWith(tags: true);
    }
  }

  void setFavouriteDocuments(bool value) {
    // Only changeable if tags is enabled
    if (state.tags) {
      state = state.copyWith(favouriteDocuments: value);
    }
  }

  void setRecentDocuments(bool value) {
    state = state.copyWith(recentDocuments: value);
  }

  void setRecentOnHomeCount(int count) {
    state = state.copyWith(recentOnHomeCount: count);
  }

  void setNewDocNameFormat(String format) {
    state = state.copyWith(newDocNameFormat: format);
  }

  void setScanQuality(SettingsScanQuality quality) {
    state = state.copyWith(scanQuality: quality);
  }

  void setDefaultColorFilter(String filter) {
    state = state.copyWith(defaultColorFilter: filter);
  }

  void setAutoSaveToGallery(bool value) {
    state = state.copyWith(autoSaveToGallery: value);
  }

  void setSystemCamera(bool value) {
    state = state.copyWith(systemCamera: value);
  }

  void setCameraAsHome(bool value) {
    state = state.copyWith(cameraAsHome: value);
  }

  void setCaptureSound(bool value) {
    state = state.copyWith(captureSound: value);
    ref.read(cameraSettingsProvider.notifier).setCaptureSound(value);
  }

  void setVolumeButtonsCapture(bool value) {
    state = state.copyWith(volumeButtonsCapture: value);
  }

  void setAppLanguage(String language) {
    state = state.copyWith(appLanguage: language);
  }

  void setAnalytics(bool value) {
    state = state.copyWith(analytics: value);
  }

  void setEnableSystemGallery(bool value) {
    state = state.copyWith(enableSystemGallery: value);
  }

  void setFolderNavigationPath(bool value) {
    state = state.copyWith(folderNavigationPath: value);
  }

  void setOcrLanguage(String language) {
    state = state.copyWith(ocrLanguage: language);
  }

  void resetSettings() {
    state = AppSettings.defaults();
    ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light);
    ref.read(cameraSettingsProvider.notifier).setCaptureSound(true);
  }
}

/// Main provider for [AppSettings].
final NotifierProvider<SettingsNotifier, AppSettings> settingsProvider =
    NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
