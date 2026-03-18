import 'package:flutter_test/flutter_test.dart';
import 'package:sinbool/features/progress/domain/entities/user_progress_entity.dart';

void main() {
  group('UserProgressEntity', () {
    test('should create empty progress correctly', () {
      const progress = UserProgressEntity.empty;

      expect(progress.totalLessonsCompleted, equals(0));
      expect(progress.totalQuizzesPassed, equals(0));
      expect(progress.currentStreak, equals(0));
      expect(progress.longestStreak, equals(0));
      expect(progress.totalTimeMinutes, equals(0));
      expect(progress.lastActivityDate, isNull);
    });

    test('should format time spent in minutes', () {
      const progress = UserProgressEntity(
        totalLessonsCompleted: 0,
        totalQuizzesPassed: 0,
        currentStreak: 0,
        longestStreak: 0,
        totalTimeMinutes: 45,
      );

      expect(progress.formattedTimeSpent, equals('45 min'));
    });

    test('should format time spent in hours', () {
      const progress = UserProgressEntity(
        totalLessonsCompleted: 0,
        totalQuizzesPassed: 0,
        currentStreak: 0,
        longestStreak: 0,
        totalTimeMinutes: 120,
      );

      expect(progress.formattedTimeSpent, equals('2 hr'));
    });

    test('should format time spent in hours and minutes', () {
      const progress = UserProgressEntity(
        totalLessonsCompleted: 0,
        totalQuizzesPassed: 0,
        currentStreak: 0,
        longestStreak: 0,
        totalTimeMinutes: 150,
      );

      expect(progress.formattedTimeSpent, equals('2 hr 30 min'));
    });

    test('should identify activity today correctly', () {
      final today = DateTime.now();
      final progress = UserProgressEntity(
        totalLessonsCompleted: 0,
        totalQuizzesPassed: 0,
        currentStreak: 0,
        longestStreak: 0,
        totalTimeMinutes: 0,
        lastActivityDate: today,
      );

      expect(progress.wasActiveToday, isTrue);
    });

    test('should return false for wasActiveToday when no activity', () {
      const progress = UserProgressEntity(
        totalLessonsCompleted: 0,
        totalQuizzesPassed: 0,
        currentStreak: 0,
        longestStreak: 0,
        totalTimeMinutes: 0,
      );

      expect(progress.wasActiveToday, isFalse);
    });

    test('should calculate days since last activity', () {
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
      final progress = UserProgressEntity(
        totalLessonsCompleted: 0,
        totalQuizzesPassed: 0,
        currentStreak: 0,
        longestStreak: 0,
        totalTimeMinutes: 0,
        lastActivityDate: twoDaysAgo,
      );

      expect(progress.daysSinceLastActivity, equals(2));
    });

    test('should return -1 for days since last activity when no date', () {
      const progress = UserProgressEntity.empty;

      expect(progress.daysSinceLastActivity, equals(-1));
    });

    test('copyWith should update specified values', () {
      const progress = UserProgressEntity.empty;
      final updated = progress.copyWith(
        totalLessonsCompleted: 10,
        currentStreak: 5,
      );

      expect(updated.totalLessonsCompleted, equals(10));
      expect(updated.currentStreak, equals(5));
      expect(updated.totalQuizzesPassed, equals(0));
    });
  });

  group('LessonProgressEntity', () {
    test('should create empty progress for lesson', () {
      final progress = LessonProgressEntity.empty(1);

      expect(progress.lessonId, equals(1));
      expect(progress.isCompleted, isFalse);
      expect(progress.lastPageViewed, equals(0));
      expect(progress.quizScore, isNull);
      expect(progress.status, equals(LessonStatus.notStarted));
    });

    test('should identify quiz passed correctly', () {
      const progress = LessonProgressEntity(
        lessonId: 1,
        isCompleted: true,
        lastPageViewed: 5,
        quizScore: 80,
        quizAttempts: 1,
        timeSpentMinutes: 10,
      );

      expect(progress.quizPassed, isTrue);
    });

    test('should identify quiz failed correctly', () {
      const progress = LessonProgressEntity(
        lessonId: 1,
        isCompleted: true,
        lastPageViewed: 5,
        quizScore: 60,
        quizAttempts: 1,
        timeSpentMinutes: 10,
      );

      expect(progress.quizPassed, isFalse);
    });

    test('should return false for quizPassed when no score', () {
      const progress = LessonProgressEntity(
        lessonId: 1,
        isCompleted: true,
        lastPageViewed: 5,
        quizAttempts: 0,
        timeSpentMinutes: 10,
      );

      expect(progress.quizPassed, isFalse);
    });

    test('should return correct status for in progress', () {
      final progress = LessonProgressEntity(
        lessonId: 1,
        isCompleted: false,
        lastPageViewed: 3,
        quizAttempts: 0,
        timeSpentMinutes: 5,
        startedAt: DateTime.now(),
      );

      expect(progress.status, equals(LessonStatus.inProgress));
    });

    test('should return correct status for completed', () {
      final progress = LessonProgressEntity(
        lessonId: 1,
        isCompleted: true,
        lastPageViewed: 5,
        quizAttempts: 1,
        timeSpentMinutes: 10,
        startedAt: DateTime.now(),
        completedAt: DateTime.now(),
      );

      expect(progress.status, equals(LessonStatus.completed));
    });
  });
}
