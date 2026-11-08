/// Available app themes.
enum ThemeChoice {
  system('System default'),
  light('Light'),
  dark('Dark');

  const ThemeChoice(this.label);
  final String label;
}

/// Available date and time display formats.
enum SettingsDateTimeFormat {
  format1('10 Oct 2026, 12-hr'),
  format2('10/10/2026, 24-hr'),
  format3('2026-10-10, 24-hr'),
  format4('Oct 10, 2026, 12-hr');

  const SettingsDateTimeFormat(this.label);
  final String label;
}

/// Document scan quality options.
enum SettingsScanQuality {
  standard('Standard', 'Smaller files'),
  high('High', 'Recommended'),
  original('Original', 'Largest files');

  const SettingsScanQuality(this.label, this.subtitle);
  final String label;
  final String subtitle;
}

/// Immutable configuration model storing all application preferences.
class AppSettings {
  const AppSettings({
    this.themeChoice = ThemeChoice.light,
    this.cloudSyncOn = false,
    this.dateTimeFormat = SettingsDateTimeFormat.format1,
    this.toolsShortcut = true,
    this.tags = false,
    this.favouriteDocuments = false,
    this.recentDocuments = true,
    this.recentOnHomeCount = 50,
    this.newDocNameFormat = 'Doc Scanner {date} {time}',
    this.scanQuality = SettingsScanQuality.high,
    this.defaultColorFilter = 'Vivid Light',
    this.autoSaveToGallery = false,
    this.systemCamera = false,
    this.cameraAsHome = false,
    this.captureSound = true,
    this.volumeButtonsCapture = false,
    this.appLanguage = 'Auto select',
    this.analytics = false,
    this.enableSystemGallery = false,
    this.folderNavigationPath = true,
    this.ocrLanguage = 'English',
  });

  final ThemeChoice themeChoice;
  final bool cloudSyncOn;
  final SettingsDateTimeFormat dateTimeFormat;
  final bool toolsShortcut;
  final bool tags;
  final bool favouriteDocuments;
  final bool recentDocuments;
  final int recentOnHomeCount;
  final String newDocNameFormat;
  final SettingsScanQuality scanQuality;
  final String defaultColorFilter;
  final bool autoSaveToGallery;
  final bool systemCamera;
  final bool cameraAsHome;
  final bool captureSound;
  final bool volumeButtonsCapture;
  final String appLanguage;
  final bool analytics;
  final bool enableSystemGallery;
  final bool folderNavigationPath;
  final String ocrLanguage;

  factory AppSettings.defaults() => const AppSettings();

  AppSettings resetToDefaults() => AppSettings.defaults();

  AppSettings copyWith({
    ThemeChoice? themeChoice,
    bool? cloudSyncOn,
    SettingsDateTimeFormat? dateTimeFormat,
    bool? toolsShortcut,
    bool? tags,
    bool? favouriteDocuments,
    bool? recentDocuments,
    int? recentOnHomeCount,
    String? newDocNameFormat,
    SettingsScanQuality? scanQuality,
    String? defaultColorFilter,
    bool? autoSaveToGallery,
    bool? systemCamera,
    bool? cameraAsHome,
    bool? captureSound,
    bool? volumeButtonsCapture,
    String? appLanguage,
    bool? analytics,
    bool? enableSystemGallery,
    bool? folderNavigationPath,
    String? ocrLanguage,
  }) {
    return AppSettings(
      themeChoice: themeChoice ?? this.themeChoice,
      cloudSyncOn: cloudSyncOn ?? this.cloudSyncOn,
      dateTimeFormat: dateTimeFormat ?? this.dateTimeFormat,
      toolsShortcut: toolsShortcut ?? this.toolsShortcut,
      tags: tags ?? this.tags,
      favouriteDocuments: favouriteDocuments ?? this.favouriteDocuments,
      recentDocuments: recentDocuments ?? this.recentDocuments,
      recentOnHomeCount: recentOnHomeCount ?? this.recentOnHomeCount,
      newDocNameFormat: newDocNameFormat ?? this.newDocNameFormat,
      scanQuality: scanQuality ?? this.scanQuality,
      defaultColorFilter: defaultColorFilter ?? this.defaultColorFilter,
      autoSaveToGallery: autoSaveToGallery ?? this.autoSaveToGallery,
      systemCamera: systemCamera ?? this.systemCamera,
      cameraAsHome: cameraAsHome ?? this.cameraAsHome,
      captureSound: captureSound ?? this.captureSound,
      volumeButtonsCapture:
          volumeButtonsCapture ?? this.volumeButtonsCapture,
      appLanguage: appLanguage ?? this.appLanguage,
      analytics: analytics ?? this.analytics,
      enableSystemGallery: enableSystemGallery ?? this.enableSystemGallery,
      folderNavigationPath:
          folderNavigationPath ?? this.folderNavigationPath,
      ocrLanguage: ocrLanguage ?? this.ocrLanguage,
    );
  }
}
