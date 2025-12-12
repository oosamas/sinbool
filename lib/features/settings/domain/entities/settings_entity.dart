import 'package:flutter/material.dart';

/// App settings entity
/// From Issue #9 - Parental Controls & Settings
class AppSettingsEntity {
  const AppSettingsEntity({
    required this.themeMode,
    required this.language,
    required this.fontSize,
    required this.parentalPinEnabled,
    required this.timeLimitEnabled,
    required this.dailyTimeLimitMinutes,
    required this.onboardingCompleted,
    required this.audioAutoPlay,
    required this.allowPremiumContent,
    required this.allowAudioPlayback,
  });

  final ThemeMode themeMode;
  final String language;
  final FontSize fontSize;
  final bool parentalPinEnabled;
  final bool timeLimitEnabled;
  final int dailyTimeLimitMinutes;
  final bool onboardingCompleted;
  final bool audioAutoPlay;
  final bool allowPremiumContent;
  final bool allowAudioPlayback;

  /// Get language display name
  String get languageDisplayName {
    return _languageNames[language] ?? language;
  }

  /// Get theme mode display name
  String get themeModeDisplayName {
    switch (themeMode) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  /// Get font size display name
  String get fontSizeDisplayName {
    switch (fontSize) {
      case FontSize.small:
        return 'Small';
      case FontSize.medium:
        return 'Medium';
      case FontSize.large:
        return 'Large';
    }
  }

  /// Default settings
  static const defaultSettings = AppSettingsEntity(
    themeMode: ThemeMode.system,
    language: 'en',
    fontSize: FontSize.medium,
    parentalPinEnabled: false,
    timeLimitEnabled: false,
    dailyTimeLimitMinutes: 30,
    onboardingCompleted: false,
    audioAutoPlay: true,
    allowPremiumContent: true,
    allowAudioPlayback: true,
  );

  AppSettingsEntity copyWith({
    ThemeMode? themeMode,
    String? language,
    FontSize? fontSize,
    bool? parentalPinEnabled,
    bool? timeLimitEnabled,
    int? dailyTimeLimitMinutes,
    bool? onboardingCompleted,
    bool? audioAutoPlay,
    bool? allowPremiumContent,
    bool? allowAudioPlayback,
  }) {
    return AppSettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      fontSize: fontSize ?? this.fontSize,
      parentalPinEnabled: parentalPinEnabled ?? this.parentalPinEnabled,
      timeLimitEnabled: timeLimitEnabled ?? this.timeLimitEnabled,
      dailyTimeLimitMinutes: dailyTimeLimitMinutes ?? this.dailyTimeLimitMinutes,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      audioAutoPlay: audioAutoPlay ?? this.audioAutoPlay,
      allowPremiumContent: allowPremiumContent ?? this.allowPremiumContent,
      allowAudioPlayback: allowAudioPlayback ?? this.allowAudioPlayback,
    );
  }

  static const Map<String, String> _languageNames = {
    'en': 'English',
    'ar': 'العربية',
    'ur': 'اردو',
    'id': 'Bahasa Indonesia',
    'es': 'Español',
    'fr': 'Français',
  };
}

/// Font size enum
enum FontSize {
  small,
  medium,
  large,
}

/// Supported languages
class SupportedLanguages {
  SupportedLanguages._();

  static const List<LanguageOption> all = [
    LanguageOption(code: 'en', name: 'English', nativeName: 'English'),
    LanguageOption(code: 'ar', name: 'Arabic', nativeName: 'العربية', isRtl: true),
    LanguageOption(code: 'ur', name: 'Urdu', nativeName: 'اردو', isRtl: true),
    LanguageOption(code: 'id', name: 'Indonesian', nativeName: 'Bahasa Indonesia'),
    LanguageOption(code: 'es', name: 'Spanish', nativeName: 'Español'),
    LanguageOption(code: 'fr', name: 'French', nativeName: 'Français'),
  ];

  static LanguageOption? getByCode(String code) {
    try {
      return all.firstWhere((l) => l.code == code);
    } catch (_) {
      return null;
    }
  }
}

/// Language option
class LanguageOption {
  const LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
    this.isRtl = false,
  });

  final String code;
  final String name;
  final String nativeName;
  final bool isRtl;
}
