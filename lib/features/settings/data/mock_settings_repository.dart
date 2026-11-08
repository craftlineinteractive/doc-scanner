import '../domain/app_settings.dart';
import '../domain/settings_repository.dart';

/// In-memory mock repository implementing [SettingsRepository].
class MockSettingsRepository implements SettingsRepository {
  MockSettingsRepository({AppSettings? initialSettings})
      : _settings = initialSettings ?? AppSettings.defaults();

  AppSettings _settings;

  @override
  Future<AppSettings> loadSettings() async => _settings;

  @override
  Future<void> saveSettings(AppSettings settings) async {
    _settings = settings;
  }

  @override
  Future<AppSettings> resetSettings() async {
    _settings = AppSettings.defaults();
    return _settings;
  }
}
