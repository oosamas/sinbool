/// API endpoint constants from Issue #95 - API Contracts
class ApiEndpoints {
  ApiEndpoints._();

  // Base URLs
  static const String production = 'https://api.sinbool.com/v1';
  static const String staging = 'https://staging-api.sinbool.com/v1';
  static const String local = 'http://localhost:3000/v1';

  // Auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';

  // Children
  static const String children = '/children';
  static String child(String id) => '/children/$id';

  // Content
  static const String chapters = '/chapters';
  static String chapterLessons(String id) => '/chapters/$id/lessons';
  static String lesson(String id) => '/lessons/$id';
  static String lessonQuiz(String id) => '/lessons/$id/quiz';

  // Progress
  static String progress(String childId) => '/progress/$childId';
  static String lessonProgress(String childId, String lessonId) =>
      '/progress/$childId/$lessonId';

  // Bookmarks
  static String bookmarks(String childId) => '/bookmarks/$childId';

  // Achievements
  static String achievements(String childId) => '/achievements/$childId';

  // Subscription
  static const String promoValidate = '/subscription/promo/validate';
}
