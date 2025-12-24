import 'package:drift/drift.dart';

/// App settings table for user preferences
/// From Issue #4 - Database Setup
class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Settings keys constants
class SettingsKeys {
  SettingsKeys._();

  // Theme
  static const String themeMode = 'theme_mode'; // 'system', 'light', 'dark'

  // Language
  static const String language = 'language'; // 'en', 'ar', etc.
  static const String contentLanguage = 'content_language';

  // Audio
  static const String audioAutoPlay = 'audio_auto_play';
  static const String audioPlaybackSpeed = 'audio_playback_speed';

  // Reading
  static const String fontSize = 'font_size'; // 'small', 'medium', 'large'
  static const String readingMode = 'reading_mode'; // 'paginated', 'scroll'

  // Parental Controls
  static const String parentalPinEnabled = 'parental_pin_enabled';
  static const String parentalPin = 'parental_pin'; // Hashed
  static const String timeLimitEnabled = 'time_limit_enabled';
  static const String dailyTimeLimitMinutes = 'daily_time_limit_minutes';
  static const String allowPremiumContent = 'allow_premium_content';
  static const String allowAudioPlayback = 'allow_audio_playback';

  // Onboarding
  static const String onboardingCompleted = 'onboarding_completed';
  static const String firstLaunchDate = 'first_launch_date';

  // Sync
  static const String lastSyncDate = 'last_sync_date';

  // Subscription
  static const String subscriptionStatus = 'subscription_status'; // 'none', 'monthly', 'promo_code'
  static const String subscriptionExpiry = 'subscription_expiry'; // ISO8601 date string
  static const String activePromoCode = 'active_promo_code'; // The redeemed promo code
}
