import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/daos/settings_dao.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/database/tables/settings_table.dart';
import '../../domain/entities/settings_entity.dart';

part 'settings_repository.g.dart';

/// Repository for app settings
/// From Issue #9 - Parental Controls & Settings
class SettingsRepository {
  SettingsRepository(this._dao);

  final SettingsDao _dao;

  /// Get all settings
  Future<AppSettingsEntity> getSettings() async {
    final themeMode = await _dao.getThemeMode();
    final language = await _dao.getLanguage();
    final fontSize = await _dao.getFontSize();
    final pinEnabled = await _dao.isParentalPinEnabled();
    final timeLimitEnabled = await _dao.isTimeLimitEnabled();
    final dailyLimit = await _dao.getDailyTimeLimit();
    final onboardingCompleted = await _dao.isOnboardingCompleted();

    // Additional settings
    final audioAutoPlay = await _dao.getSetting(SettingsKeys.audioAutoPlay) == 'true' ||
        await _dao.getSetting(SettingsKeys.audioAutoPlay) == null;
    final allowPremium = await _dao.getSetting(SettingsKeys.allowPremiumContent) == 'true' ||
        await _dao.getSetting(SettingsKeys.allowPremiumContent) == null;
    final allowAudio = await _dao.getSetting(SettingsKeys.allowAudioPlayback) == 'true' ||
        await _dao.getSetting(SettingsKeys.allowAudioPlayback) == null;

    return AppSettingsEntity(
      themeMode: _parseThemeMode(themeMode),
      language: language,
      fontSize: _parseFontSize(fontSize),
      parentalPinEnabled: pinEnabled,
      timeLimitEnabled: timeLimitEnabled,
      dailyTimeLimitMinutes: dailyLimit,
      onboardingCompleted: onboardingCompleted,
      audioAutoPlay: audioAutoPlay,
      allowPremiumContent: allowPremium,
      allowAudioPlayback: allowAudio,
    );
  }

  /// Watch theme mode
  Stream<ThemeMode> watchThemeMode() {
    return _dao.watchSetting(SettingsKeys.themeMode).map(
          (value) => _parseThemeMode(value ?? 'system'),
        );
  }

  /// Watch language
  Stream<String> watchLanguage() {
    return _dao.watchSetting(SettingsKeys.language).map(
          (value) => value ?? 'en',
        );
  }

  /// Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    await _dao.setThemeMode(_themeModeToString(mode));
  }

  /// Set language
  Future<void> setLanguage(String language) async {
    await _dao.setLanguage(language);
  }

  /// Set font size
  Future<void> setFontSize(FontSize size) async {
    await _dao.setFontSize(_fontSizeToString(size));
  }

  /// Set parental PIN
  Future<void> setParentalPin(String pin) async {
    final hashedPin = _hashPin(pin);
    await _dao.setParentalPin(hashedPin);
    await _dao.setParentalPinEnabled(true);
  }

  /// Verify parental PIN
  Future<bool> verifyParentalPin(String pin) async {
    final storedHash = await _dao.getParentalPin();
    if (storedHash == null) return false;
    return _hashPin(pin) == storedHash;
  }

  /// Remove parental PIN
  Future<void> removeParentalPin() async {
    await _dao.deleteSetting(SettingsKeys.parentalPin);
    await _dao.setParentalPinEnabled(false);
  }

  /// Set parental PIN enabled
  Future<void> setParentalPinEnabled(bool enabled) async {
    await _dao.setParentalPinEnabled(enabled);
  }

  /// Set time limit enabled
  Future<void> setTimeLimitEnabled(bool enabled) async {
    await _dao.setTimeLimitEnabled(enabled);
  }

  /// Set daily time limit
  Future<void> setDailyTimeLimit(int minutes) async {
    await _dao.setDailyTimeLimit(minutes);
  }

  /// Set onboarding completed
  Future<void> setOnboardingCompleted(bool completed) async {
    await _dao.setOnboardingCompleted(completed);
  }

  /// Set audio auto play
  Future<void> setAudioAutoPlay(bool enabled) async {
    await _dao.setSetting(SettingsKeys.audioAutoPlay, enabled.toString());
  }

  /// Set allow premium content
  Future<void> setAllowPremiumContent(bool enabled) async {
    await _dao.setSetting(SettingsKeys.allowPremiumContent, enabled.toString());
  }

  /// Set allow audio playback
  Future<void> setAllowAudioPlayback(bool enabled) async {
    await _dao.setSetting(SettingsKeys.allowAudioPlayback, enabled.toString());
  }

  /// Hash PIN for secure storage
  String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  ThemeMode _parseThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  FontSize _parseFontSize(String value) {
    switch (value) {
      case 'small':
        return FontSize.small;
      case 'large':
        return FontSize.large;
      default:
        return FontSize.medium;
    }
  }

  String _fontSizeToString(FontSize size) {
    switch (size) {
      case FontSize.small:
        return 'small';
      case FontSize.large:
        return 'large';
      case FontSize.medium:
        return 'medium';
    }
  }
}

/// Settings keys extension
extension SettingsKeysExt on SettingsKeys {
  static const audioAutoPlay = 'audio_auto_play';
  static const allowPremiumContent = 'allow_premium_content';
  static const allowAudioPlayback = 'allow_audio_playback';
}

/// Settings repository provider
@riverpod
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  final dao = ref.watch(settingsDaoProvider);
  return SettingsRepository(dao);
}

/// App settings provider
@riverpod
Future<AppSettingsEntity> appSettings(AppSettingsRef ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.getSettings();
}

/// Theme mode stream provider
@riverpod
Stream<ThemeMode> themeModeStream(ThemeModeStreamRef ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchThemeMode();
}

/// Language stream provider
@riverpod
Stream<String> languageStream(LanguageStreamRef ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchLanguage();
}
