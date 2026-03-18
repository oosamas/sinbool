import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sinbool/features/settings/domain/entities/settings_entity.dart';

void main() {
  group('AppSettingsEntity', () {
    test('should have correct default settings', () {
      const settings = AppSettingsEntity.defaultSettings;

      expect(settings.themeMode, equals(ThemeMode.system));
      expect(settings.language, equals('en'));
      expect(settings.fontSize, equals(FontSize.medium));
      expect(settings.parentalPinEnabled, isFalse);
      expect(settings.timeLimitEnabled, isFalse);
      expect(settings.dailyTimeLimitMinutes, equals(30));
      expect(settings.onboardingCompleted, isFalse);
      expect(settings.audioAutoPlay, isTrue);
      expect(settings.allowPremiumContent, isTrue);
      expect(settings.allowAudioPlayback, isTrue);
    });

    test('should return correct language display name for English', () {
      const settings = AppSettingsEntity.defaultSettings;
      expect(settings.languageDisplayName, equals('English'));
    });

    test('should return correct language display name for Arabic', () {
      final settings = AppSettingsEntity.defaultSettings.copyWith(language: 'ar');
      expect(settings.languageDisplayName, equals('العربية'));
    });

    test('should return correct theme mode display name for system', () {
      const settings = AppSettingsEntity.defaultSettings;
      expect(settings.themeModeDisplayName, equals('System default'));
    });

    test('should return correct theme mode display name for light', () {
      final settings = AppSettingsEntity.defaultSettings.copyWith(
        themeMode: ThemeMode.light,
      );
      expect(settings.themeModeDisplayName, equals('Light'));
    });

    test('should return correct theme mode display name for dark', () {
      final settings = AppSettingsEntity.defaultSettings.copyWith(
        themeMode: ThemeMode.dark,
      );
      expect(settings.themeModeDisplayName, equals('Dark'));
    });

    test('should return correct font size display name', () {
      const settings = AppSettingsEntity.defaultSettings;
      expect(settings.fontSizeDisplayName, equals('Medium'));

      final smallSettings = settings.copyWith(fontSize: FontSize.small);
      expect(smallSettings.fontSizeDisplayName, equals('Small'));

      final largeSettings = settings.copyWith(fontSize: FontSize.large);
      expect(largeSettings.fontSizeDisplayName, equals('Large'));
    });

    test('copyWith should update specified values', () {
      const settings = AppSettingsEntity.defaultSettings;
      final updated = settings.copyWith(
        language: 'ar',
        parentalPinEnabled: true,
        dailyTimeLimitMinutes: 60,
      );

      expect(updated.language, equals('ar'));
      expect(updated.parentalPinEnabled, isTrue);
      expect(updated.dailyTimeLimitMinutes, equals(60));
      expect(updated.themeMode, equals(ThemeMode.system)); // unchanged
    });
  });

  group('SupportedLanguages', () {
    test('should have 6 supported languages', () {
      expect(SupportedLanguages.all.length, equals(6));
    });

    test('should include required languages', () {
      final codes = SupportedLanguages.all.map((l) => l.code).toList();
      expect(codes, contains('en'));
      expect(codes, contains('ar'));
      expect(codes, contains('ur'));
      expect(codes, contains('id'));
      expect(codes, contains('es'));
      expect(codes, contains('fr'));
    });

    test('should mark RTL languages correctly', () {
      final arabic = SupportedLanguages.getByCode('ar');
      final urdu = SupportedLanguages.getByCode('ur');
      final english = SupportedLanguages.getByCode('en');

      expect(arabic?.isRtl, isTrue);
      expect(urdu?.isRtl, isTrue);
      expect(english?.isRtl, isFalse);
    });

    test('should return null for unknown language code', () {
      final unknown = SupportedLanguages.getByCode('unknown');
      expect(unknown, isNull);
    });

    test('should return correct language by code', () {
      final english = SupportedLanguages.getByCode('en');
      expect(english?.name, equals('English'));
      expect(english?.nativeName, equals('English'));
    });
  });

  group('LanguageOption', () {
    test('should create language option correctly', () {
      const option = LanguageOption(
        code: 'ar',
        name: 'Arabic',
        nativeName: 'العربية',
        isRtl: true,
      );

      expect(option.code, equals('ar'));
      expect(option.name, equals('Arabic'));
      expect(option.nativeName, equals('العربية'));
      expect(option.isRtl, isTrue);
    });

    test('should default isRtl to false', () {
      const option = LanguageOption(
        code: 'en',
        name: 'English',
        nativeName: 'English',
      );

      expect(option.isRtl, isFalse);
    });
  });
}
