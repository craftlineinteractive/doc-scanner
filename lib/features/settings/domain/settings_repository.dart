import 'app_settings.dart';

/// Repository interface for saving and loading application settings.
abstract class SettingsRepository {
  Future<AppSettings> loadSettings();
  Future<void> saveSettings(AppSettings settings);
  Future<AppSettings> resetSettings();
}
