import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/settings_repository.dart';
import '../../domain/entities/settings_entity.dart';

part 'settings_controller.g.dart';

/// Settings controller state
class SettingsState {
  const SettingsState({
    required this.settings,
    this.isLoading = false,
    this.error,
    this.hasParentalPin = false,
  });

  final AppSettingsEntity settings;
  final bool isLoading;
  final String? error;
  final bool hasParentalPin;

  SettingsState copyWith({
    AppSettingsEntity? settings,
    bool? isLoading,
    String? error,
    bool? hasParentalPin,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasParentalPin: hasParentalPin ?? this.hasParentalPin,
    );
  }

  /// Initial state
  static const initial = SettingsState(
    settings: AppSettingsEntity.defaultSettings,
    isLoading: true,
  );
}

/// Settings controller for managing app settings
@riverpod
class SettingsController extends _$SettingsController {
  @override
  SettingsState build() {
    _loadSettings();
    return SettingsState.initial;
  }

  SettingsRepository get _repository => ref.read(settingsRepositoryProvider);

  /// Load settings
  Future<void> _loadSettings() async {
    try {
      // Don't set loading state here - initial state already has isLoading: true
      final settings = await _repository.getSettings();
      state = SettingsState(
        settings: settings,
        isLoading: false,
        hasParentalPin: settings.parentalPinEnabled,
      );
    } catch (e) {
      state = SettingsState(
        settings: AppSettingsEntity.defaultSettings,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Refresh settings
  Future<void> refresh() async {
    await _loadSettings();
  }

  /// Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      await _repository.setThemeMode(mode);
      state = state.copyWith(
        settings: state.settings.copyWith(themeMode: mode),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set language
  Future<void> setLanguage(String language) async {
    try {
      await _repository.setLanguage(language);
      state = state.copyWith(
        settings: state.settings.copyWith(language: language),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set font size
  Future<void> setFontSize(FontSize size) async {
    try {
      await _repository.setFontSize(size);
      state = state.copyWith(
        settings: state.settings.copyWith(fontSize: size),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set parental PIN
  Future<bool> setParentalPin(String pin) async {
    try {
      await _repository.setParentalPin(pin);
      state = state.copyWith(
        settings: state.settings.copyWith(parentalPinEnabled: true),
        hasParentalPin: true,
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Verify parental PIN
  Future<bool> verifyParentalPin(String pin) async {
    try {
      return await _repository.verifyParentalPin(pin);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Remove parental PIN
  Future<void> removeParentalPin() async {
    try {
      await _repository.removeParentalPin();
      state = state.copyWith(
        settings: state.settings.copyWith(parentalPinEnabled: false),
        hasParentalPin: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Toggle PIN enabled
  Future<void> togglePinEnabled(bool enabled) async {
    try {
      if (!enabled) {
        await _repository.removeParentalPin();
      }
      state = state.copyWith(
        settings: state.settings.copyWith(parentalPinEnabled: enabled),
        hasParentalPin: enabled,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set time limit enabled
  Future<void> setTimeLimitEnabled(bool enabled) async {
    try {
      await _repository.setTimeLimitEnabled(enabled);
      state = state.copyWith(
        settings: state.settings.copyWith(timeLimitEnabled: enabled),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set daily time limit
  Future<void> setDailyTimeLimit(int minutes) async {
    try {
      await _repository.setDailyTimeLimit(minutes);
      state = state.copyWith(
        settings: state.settings.copyWith(dailyTimeLimitMinutes: minutes),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set audio auto play
  Future<void> setAudioAutoPlay(bool enabled) async {
    try {
      await _repository.setAudioAutoPlay(enabled);
      state = state.copyWith(
        settings: state.settings.copyWith(audioAutoPlay: enabled),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set allow premium content
  Future<void> setAllowPremiumContent(bool enabled) async {
    try {
      await _repository.setAllowPremiumContent(enabled);
      state = state.copyWith(
        settings: state.settings.copyWith(allowPremiumContent: enabled),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Set allow audio playback
  Future<void> setAllowAudioPlayback(bool enabled) async {
    try {
      await _repository.setAllowAudioPlayback(enabled);
      state = state.copyWith(
        settings: state.settings.copyWith(allowAudioPlayback: enabled),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Mark onboarding completed
  Future<void> completeOnboarding() async {
    try {
      await _repository.setOnboardingCompleted(true);
      state = state.copyWith(
        settings: state.settings.copyWith(onboardingCompleted: true),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
