import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/daos/progress_dao.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/entities/achievement_entity.dart';
import '../../domain/entities/user_progress_entity.dart';

part 'progress_repository.g.dart';

/// Repository for user progress operations
/// From Issue #7 - User Progress & Analytics
class ProgressRepository {
  ProgressRepository(this._dao);

  final ProgressDao _dao;

  /// Get user progress
  Future<UserProgressEntity> getUserProgress() async {
    final data = await _dao.getUserProgress();
    return _mapToEntity(data);
  }

  /// Watch user progress
  Stream<UserProgressEntity> watchUserProgress() {
    return _dao.watchUserProgress().map(
          (data) => data != null ? _mapToEntity(data) : UserProgressEntity.empty,
        );
  }

  /// Get lesson progress
  Future<LessonProgressEntity?> getLessonProgress(int lessonId) async {
    final data = await _dao.getLessonProgress(lessonId);
    if (data == null) return null;
    return _mapLessonToEntity(data);
  }

  /// Watch lesson progress
  Stream<LessonProgressEntity?> watchLessonProgress(int lessonId) {
    return _dao.watchLessonProgress(lessonId).map(
          (data) => data != null ? _mapLessonToEntity(data) : null,
        );
  }

  /// Mark lesson as started
  Future<void> markLessonStarted(int lessonId) async {
    await _dao.markLessonStarted(lessonId);
  }

  /// Update last page viewed
  Future<void> updateLastPage(int lessonId, int pageNumber) async {
    await _dao.updateLastPageViewed(lessonId, pageNumber);
  }

  /// Mark lesson as completed
  Future<void> markLessonCompleted(int lessonId) async {
    await _dao.markLessonCompleted(lessonId);
  }

  /// Record quiz score
  Future<void> recordQuizScore(int lessonId, int score, int total) async {
    await _dao.recordQuizScore(lessonId, score, total);
  }

  /// Add time spent learning
  Future<void> addTimeSpent(int minutes) async {
    await _dao.addTimeSpent(minutes);
  }

  /// Get completed lessons count for a chapter
  Future<int> getCompletedCountForChapter(int chapterId) async {
    return _dao.getCompletedCountForChapter(chapterId);
  }

  /// Check if lesson is completed
  Future<bool> isLessonCompleted(int lessonId) async {
    return _dao.isLessonCompleted(lessonId);
  }

  /// Get total lessons count
  Future<int> getTotalLessonsCount() async {
    return _dao.getTotalLessonsCount();
  }

  /// Watch total lessons count
  Stream<int> watchTotalLessonsCount() {
    return _dao.watchTotalLessonsCount();
  }

  /// Get achievements with current progress
  Future<List<AchievementEntity>> getAchievements() async {
    final progress = await getUserProgress();
    return _calculateAchievements(progress);
  }

  /// Watch achievements with current progress
  Stream<List<AchievementEntity>> watchAchievements() {
    return watchUserProgress().map(_calculateAchievements);
  }

  List<AchievementEntity> _calculateAchievements(UserProgressEntity progress) {
    return Achievements.all.map((achievement) {
      int currentProgress;
      bool isUnlocked;

      switch (achievement.id) {
        // Lesson achievements
        case 'first_lesson':
        case 'five_lessons':
        case 'ten_lessons':
        case 'twenty_lessons':
          currentProgress = progress.totalLessonsCompleted;
          isUnlocked = currentProgress >= achievement.requirement;
          break;

        // Quiz achievements
        case 'first_quiz':
        case 'five_quizzes':
          currentProgress = progress.totalQuizzesPassed;
          isUnlocked = currentProgress >= achievement.requirement;
          break;

        case 'perfect_quiz':
          // Special case - tracked separately
          currentProgress = 0;
          isUnlocked = false;
          break;

        // Streak achievements
        case 'three_day_streak':
        case 'seven_day_streak':
        case 'thirty_day_streak':
          currentProgress = progress.longestStreak;
          isUnlocked = currentProgress >= achievement.requirement;
          break;

        default:
          currentProgress = 0;
          isUnlocked = false;
      }

      return achievement.copyWith(
        progress: currentProgress,
        isUnlocked: isUnlocked,
      );
    }).toList();
  }

  UserProgressEntity _mapToEntity(dynamic data) {
    return UserProgressEntity(
      totalLessonsCompleted: data.totalLessonsCompleted,
      totalQuizzesPassed: data.totalQuizzesPassed,
      currentStreak: data.currentStreak,
      longestStreak: data.longestStreak,
      totalTimeMinutes: data.totalTimeMinutes,
      lastActivityDate: data.lastActivityDate,
    );
  }

  LessonProgressEntity _mapLessonToEntity(dynamic data) {
    return LessonProgressEntity(
      lessonId: data.lessonId,
      isCompleted: data.isCompleted,
      lastPageViewed: data.lastPageViewed,
      quizScore: data.quizScore,
      quizAttempts: data.quizAttempts,
      timeSpentMinutes: data.timeSpentMinutes,
      startedAt: data.startedAt,
      completedAt: data.completedAt,
    );
  }
}

/// Progress repository provider
@riverpod
ProgressRepository progressRepository(ProgressRepositoryRef ref) {
  final dao = ref.watch(progressDaoProvider);
  return ProgressRepository(dao);
}

/// User progress provider
@riverpod
Stream<UserProgressEntity> userProgress(UserProgressRef ref) {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.watchUserProgress();
}

/// Lesson progress provider
@riverpod
Stream<LessonProgressEntity?> lessonProgress(
  LessonProgressRef ref,
  int lessonId,
) {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.watchLessonProgress(lessonId);
}

/// Achievements provider
@riverpod
Stream<List<AchievementEntity>> achievements(AchievementsRef ref) {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.watchAchievements();
}

/// Total lessons count provider
@riverpod
Stream<int> totalLessonsCount(TotalLessonsCountRef ref) {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.watchTotalLessonsCount();
}
