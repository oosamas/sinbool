import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/settings_table.dart';

part 'settings_dao.g.dart';

/// DAO for app settings operations
/// From Issue #4 - Database Setup
@DriftAccessor(tables: [AppSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  /// Get a setting value
  Future<String?> getSetting(String key) async {
    final setting = await (select(appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return setting?.value;
  }

  /// Watch a setting value
  Stream<String?> watchSetting(String key) {
    return (select(appSettings)..where((t) => t.key.equals(key)))
        .watchSingleOrNull()
        .map((setting) => setting?.value);
  }

  /// Set a setting value
  Future<void> setSetting(String key, String value) async {
    await into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion.insert(
        key: key,
        value: value,
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Delete a setting
  Future<int> deleteSetting(String key) {
    return (delete(appSettings)..where((t) => t.key.equals(key))).go();
  }

  /// Get all settings as a map
  Future<Map<String, String>> getAllSettings() async {
    final settings = await select(appSettings).get();
    return Map.fromEntries(
      settings.map((s) => MapEntry(s.key, s.value)),
    );
  }

  // Convenience methods for common settings

  /// Get theme mode
  Future<String> getThemeMode() async {
    return await getSetting(SettingsKeys.themeMode) ?? 'system';
  }

  /// Set theme mode
  Future<void> setThemeMode(String mode) async {
    await setSetting(SettingsKeys.themeMode, mode);
  }

  /// Get language
  Future<String> getLanguage() async {
    return await getSetting(SettingsKeys.language) ?? 'en';
  }

  /// Set language
  Future<void> setLanguage(String language) async {
    await setSetting(SettingsKeys.language, language);
  }

  /// Get font size
  Future<String> getFontSize() async {
    return await getSetting(SettingsKeys.fontSize) ?? 'medium';
  }

  /// Set font size
  Future<void> setFontSize(String size) async {
    await setSetting(SettingsKeys.fontSize, size);
  }

  /// Check if parental PIN is enabled
  Future<bool> isParentalPinEnabled() async {
    final value = await getSetting(SettingsKeys.parentalPinEnabled);
    return value == 'true';
  }

  /// Set parental PIN enabled
  Future<void> setParentalPinEnabled(bool enabled) async {
    await setSetting(SettingsKeys.parentalPinEnabled, enabled.toString());
  }

  /// Get parental PIN (hashed)
  Future<String?> getParentalPin() async {
    return await getSetting(SettingsKeys.parentalPin);
  }

  /// Set parental PIN (should be hashed before storing)
  Future<void> setParentalPin(String hashedPin) async {
    await setSetting(SettingsKeys.parentalPin, hashedPin);
  }

  /// Check if onboarding is completed
  Future<bool> isOnboardingCompleted() async {
    final value = await getSetting(SettingsKeys.onboardingCompleted);
    return value == 'true';
  }

  /// Set onboarding completed
  Future<void> setOnboardingCompleted(bool completed) async {
    await setSetting(SettingsKeys.onboardingCompleted, completed.toString());
  }

  /// Get daily time limit
  Future<int> getDailyTimeLimit() async {
    final value = await getSetting(SettingsKeys.dailyTimeLimitMinutes);
    return int.tryParse(value ?? '') ?? 30;
  }

  /// Set daily time limit
  Future<void> setDailyTimeLimit(int minutes) async {
    await setSetting(SettingsKeys.dailyTimeLimitMinutes, minutes.toString());
  }

  /// Check if time limit is enabled
  Future<bool> isTimeLimitEnabled() async {
    final value = await getSetting(SettingsKeys.timeLimitEnabled);
    return value == 'true';
  }

  /// Set time limit enabled
  Future<void> setTimeLimitEnabled(bool enabled) async {
    await setSetting(SettingsKeys.timeLimitEnabled, enabled.toString());
  }
}
