/// Route path constants for the app
/// From Issue #3 - Navigation & Routing
class AppRoutes {
  AppRoutes._();

  // Root routes
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // Main shell routes (bottom navigation)
  static const String home = '/';
  static const String chapters = '/chapters';
  static const String bookmarks = '/bookmarks';
  static const String profile = '/profile';

  // Chapter routes
  static const String chapterDetail = '/chapters/:chapterId';
  static const String lessonDetail = '/chapters/:chapterId/lessons/:lessonId';
  static const String storyViewer = '/chapters/:chapterId/lessons/:lessonId/story';
  static const String quizScreen = '/chapters/:chapterId/lessons/:lessonId/quiz';

  // Audio routes
  static const String audioPlayer = '/audio/:contentId';

  // Settings & Parental
  static const String settings = '/settings';
  static const String parentalControls = '/settings/parental';
  static const String parentalPin = '/settings/parental/pin';
  static const String languageSettings = '/settings/language';
  static const String themeSettings = '/settings/theme';

  // About & Legal
  static const String about = '/about';
  static const String privacyPolicy = '/privacy';
  static const String termsOfService = '/terms';

  // Helper methods for parameterized routes
  static String chapterDetailPath(String chapterId) => '/chapters/$chapterId';

  static String lessonDetailPath(String chapterId, String lessonId) =>
      '/chapters/$chapterId/lessons/$lessonId';

  static String storyViewerPath(String chapterId, String lessonId) =>
      '/chapters/$chapterId/lessons/$lessonId/story';

  static String quizScreenPath(String chapterId, String lessonId) =>
      '/chapters/$chapterId/lessons/$lessonId/quiz';

  static String audioPlayerPath(String contentId) => '/audio/$contentId';
}

/// Route names for named navigation
class RouteNames {
  RouteNames._();

  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String home = 'home';
  static const String chapters = 'chapters';
  static const String chapterDetail = 'chapterDetail';
  static const String lessonDetail = 'lessonDetail';
  static const String storyViewer = 'storyViewer';
  static const String quizScreen = 'quizScreen';
  static const String bookmarks = 'bookmarks';
  static const String profile = 'profile';
  static const String audioPlayer = 'audioPlayer';
  static const String settings = 'settings';
  static const String parentalControls = 'parentalControls';
  static const String parentalPin = 'parentalPin';
  static const String languageSettings = 'languageSettings';
  static const String themeSettings = 'themeSettings';
  static const String about = 'about';
  static const String privacyPolicy = 'privacyPolicy';
  static const String termsOfService = 'termsOfService';
}
