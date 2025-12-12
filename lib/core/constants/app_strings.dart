/// Static string constants that don't need localization
/// For user-facing strings, use the l10n system instead
class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Sinbool';
  static const String appVersion = '1.0.0';

  // Route Names
  static const String routeHome = 'home';
  static const String routeChapters = 'chapters';
  static const String routeLesson = 'lesson';
  static const String routeQuiz = 'quiz';
  static const String routeProfile = 'profile';
  static const String routeSettings = 'settings';
  static const String routeLogin = 'login';
  static const String routeRegister = 'register';
  static const String routeOnboarding = 'onboarding';

  // Storage Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keySelectedChildId = 'selected_child_id';
  static const String keyLanguage = 'language';
  static const String keyThemeMode = 'theme_mode';
  static const String keyOnboardingComplete = 'onboarding_complete';

  // API Endpoints (base paths)
  static const String apiVersion = 'v1';
}
