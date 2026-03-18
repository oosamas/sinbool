import 'package:flutter/material.dart';

/// Achievement entity for gamification
/// From Issue #7 - User Progress & Analytics
class AchievementEntity {
  const AchievementEntity({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.description,
    required this.descriptionArabic,
    required this.icon,
    required this.requirement,
    required this.isUnlocked,
    this.unlockedAt,
    this.progress = 0,
  });

  final String id;
  final String title;
  final String titleArabic;
  final String description;
  final String descriptionArabic;
  final IconData icon;
  final int requirement;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int progress;

  /// Get localized title
  String getTitle(String locale) {
    if (locale.startsWith('ar')) return titleArabic;
    return title;
  }

  /// Get localized description
  String getDescription(String locale) {
    if (locale.startsWith('ar')) return descriptionArabic;
    return description;
  }

  /// Progress percentage (0.0 - 1.0)
  double get progressPercentage {
    if (isUnlocked) return 1.0;
    if (requirement == 0) return 0.0;
    return (progress / requirement).clamp(0.0, 1.0);
  }

  AchievementEntity copyWith({
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? progress,
  }) {
    return AchievementEntity(
      id: id,
      title: title,
      titleArabic: titleArabic,
      description: description,
      descriptionArabic: descriptionArabic,
      icon: icon,
      requirement: requirement,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      progress: progress ?? this.progress,
    );
  }
}

/// Achievement type for categorization
enum AchievementType {
  lesson,    // Lesson completion achievements
  quiz,      // Quiz-related achievements
  streak,    // Daily streak achievements
  time,      // Time spent achievements
  special,   // Special/seasonal achievements
}

/// Predefined achievements
class Achievements {
  Achievements._();

  // Lesson achievements
  static const firstLesson = AchievementEntity(
    id: 'first_lesson',
    title: 'First Step',
    titleArabic: 'الخطوة الأولى',
    description: 'Complete your first lesson',
    descriptionArabic: 'أكمل درسك الأول',
    icon: Icons.star,
    requirement: 1,
    isUnlocked: false,
  );

  static const fiveLessons = AchievementEntity(
    id: 'five_lessons',
    title: 'Eager Learner',
    titleArabic: 'متعلم متحمس',
    description: 'Complete 5 lessons',
    descriptionArabic: 'أكمل 5 دروس',
    icon: Icons.auto_stories,
    requirement: 5,
    isUnlocked: false,
  );

  static const tenLessons = AchievementEntity(
    id: 'ten_lessons',
    title: 'Story Explorer',
    titleArabic: 'مستكشف القصص',
    description: 'Complete 10 lessons',
    descriptionArabic: 'أكمل 10 دروس',
    icon: Icons.explore,
    requirement: 10,
    isUnlocked: false,
  );

  static const twentyLessons = AchievementEntity(
    id: 'twenty_lessons',
    title: 'Knowledge Seeker',
    titleArabic: 'طالب العلم',
    description: 'Complete 20 lessons',
    descriptionArabic: 'أكمل 20 درساً',
    icon: Icons.school,
    requirement: 20,
    isUnlocked: false,
  );

  // Quiz achievements
  static const firstQuiz = AchievementEntity(
    id: 'first_quiz',
    title: 'Quiz Taker',
    titleArabic: 'مجيب الأسئلة',
    description: 'Pass your first quiz',
    descriptionArabic: 'اجتز اختبارك الأول',
    icon: Icons.quiz,
    requirement: 1,
    isUnlocked: false,
  );

  static const fiveQuizzes = AchievementEntity(
    id: 'five_quizzes',
    title: 'Quiz Master',
    titleArabic: 'سيد الاختبارات',
    description: 'Pass 5 quizzes',
    descriptionArabic: 'اجتز 5 اختبارات',
    icon: Icons.emoji_events,
    requirement: 5,
    isUnlocked: false,
  );

  static const perfectQuiz = AchievementEntity(
    id: 'perfect_quiz',
    title: 'Perfect Score',
    titleArabic: 'درجة كاملة',
    description: 'Get 100% on a quiz',
    descriptionArabic: 'احصل على 100% في اختبار',
    icon: Icons.workspace_premium,
    requirement: 1,
    isUnlocked: false,
  );

  // Streak achievements
  static const threeDayStreak = AchievementEntity(
    id: 'three_day_streak',
    title: 'Getting Started',
    titleArabic: 'البداية',
    description: 'Maintain a 3 day streak',
    descriptionArabic: 'حافظ على سلسلة 3 أيام',
    icon: Icons.local_fire_department,
    requirement: 3,
    isUnlocked: false,
  );

  static const sevenDayStreak = AchievementEntity(
    id: 'seven_day_streak',
    title: 'Week Warrior',
    titleArabic: 'محارب الأسبوع',
    description: 'Maintain a 7 day streak',
    descriptionArabic: 'حافظ على سلسلة 7 أيام',
    icon: Icons.whatshot,
    requirement: 7,
    isUnlocked: false,
  );

  static const thirtyDayStreak = AchievementEntity(
    id: 'thirty_day_streak',
    title: 'Dedication',
    titleArabic: 'التفاني',
    description: 'Maintain a 30 day streak',
    descriptionArabic: 'حافظ على سلسلة 30 يوماً',
    icon: Icons.military_tech,
    requirement: 30,
    isUnlocked: false,
  );

  /// All achievements
  static const List<AchievementEntity> all = [
    firstLesson,
    fiveLessons,
    tenLessons,
    twentyLessons,
    firstQuiz,
    fiveQuizzes,
    perfectQuiz,
    threeDayStreak,
    sevenDayStreak,
    thirtyDayStreak,
  ];
}
