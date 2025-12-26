import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/chapters_table.dart';
import '../tables/progress_table.dart';

part 'progress_dao.g.dart';

/// DAO for user progress operations
/// From Issue #4 - Database Setup
@DriftAccessor(tables: [UserProgress, LessonProgress, Lessons, Chapters])
class ProgressDao extends DatabaseAccessor<AppDatabase>
    with _$ProgressDaoMixin {
  ProgressDao(super.db);

  // User Progress

  /// Get or create user progress
  Future<UserProgressData> getUserProgress() async {
    final existing = await select(userProgress).getSingleOrNull();
    if (existing != null) return existing;

    // Create initial progress record
    await into(userProgress).insert(UserProgressCompanion.insert());
    return (await select(userProgress).getSingle());
  }

  /// Watch user progress
  Stream<UserProgressData?> watchUserProgress() {
    return select(userProgress).watchSingleOrNull();
  }

  /// Update user progress
  Future<void> updateUserProgress(UserProgressCompanion progress) async {
    final existing = await getUserProgress();
    await (update(userProgress)..where((t) => t.id.equals(existing.id)))
        .write(progress);
  }

  /// Increment lessons completed
  Future<void> incrementLessonsCompleted() async {
    final current = await getUserProgress();
    await updateUserProgress(UserProgressCompanion(
      totalLessonsCompleted: Value(current.totalLessonsCompleted + 1),
      lastActivityDate: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ));
    await _updateStreak();
  }

  /// Increment quizzes passed
  Future<void> incrementQuizzesPassed() async {
    final current = await getUserProgress();
    await updateUserProgress(UserProgressCompanion(
      totalQuizzesPassed: Value(current.totalQuizzesPassed + 1),
      updatedAt: Value(DateTime.now()),
    ));
  }

  /// Add time spent
  Future<void> addTimeSpent(int minutes) async {
    final current = await getUserProgress();
    await updateUserProgress(UserProgressCompanion(
      totalTimeMinutes: Value(current.totalTimeMinutes + minutes),
      lastActivityDate: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ));
  }

  /// Update streak
  Future<void> _updateStreak() async {
    final current = await getUserProgress();
    final lastActivity = current.lastActivityDate;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    int newStreak = current.currentStreak;

    if (lastActivity == null) {
      newStreak = 1;
    } else {
      final lastDate = DateTime(
        lastActivity.year,
        lastActivity.month,
        lastActivity.day,
      );
      final difference = today.difference(lastDate).inDays;

      if (difference == 0) {
        // Same day, streak unchanged
      } else if (difference == 1) {
        // Consecutive day
        newStreak = current.currentStreak + 1;
      } else {
        // Streak broken
        newStreak = 1;
      }
    }

    final longestStreak =
        newStreak > current.longestStreak ? newStreak : current.longestStreak;

    await updateUserProgress(UserProgressCompanion(
      currentStreak: Value(newStreak),
      longestStreak: Value(longestStreak),
    ));
  }

  // Lesson Progress

  /// Get progress for a lesson
  Future<LessonProgressData?> getLessonProgress(int lessonId) {
    return (select(lessonProgress)..where((t) => t.lessonId.equals(lessonId)))
        .getSingleOrNull();
  }

  /// Watch progress for a lesson
  Stream<LessonProgressData?> watchLessonProgress(int lessonId) {
    return (select(lessonProgress)..where((t) => t.lessonId.equals(lessonId)))
        .watchSingleOrNull();
  }

  /// Get or create lesson progress
  Future<LessonProgressData> getOrCreateLessonProgress(int lessonId) async {
    final existing = await getLessonProgress(lessonId);
    if (existing != null) return existing;

    await into(lessonProgress).insert(
      LessonProgressCompanion.insert(
        lessonId: lessonId,
        startedAt: Value(DateTime.now()),
      ),
    );
    return (await getLessonProgress(lessonId))!;
  }

  /// Update lesson progress
  Future<void> updateLessonProgress(
    int lessonId,
    LessonProgressCompanion progress,
  ) async {
    await getOrCreateLessonProgress(lessonId);
    await (update(lessonProgress)..where((t) => t.lessonId.equals(lessonId)))
        .write(progress);
  }

  /// Mark lesson as started
  Future<void> markLessonStarted(int lessonId) async {
    await getOrCreateLessonProgress(lessonId);
  }

  /// Update last page viewed
  Future<void> updateLastPageViewed(int lessonId, int pageNumber) async {
    await updateLessonProgress(
      lessonId,
      LessonProgressCompanion(
        lastPageViewed: Value(pageNumber),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Mark lesson as completed
  Future<void> markLessonCompleted(int lessonId) async {
    await updateLessonProgress(
      lessonId,
      LessonProgressCompanion(
        isCompleted: const Value(true),
        completedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await incrementLessonsCompleted();
  }

  /// Record quiz score
  Future<void> recordQuizScore(int lessonId, int score, int total) async {
    final progress = await getOrCreateLessonProgress(lessonId);
    final percentage = (score / total * 100).round();
    final passed = percentage >= 70;

    await updateLessonProgress(
      lessonId,
      LessonProgressCompanion(
        quizScore: Value(percentage),
        quizAttempts: Value(progress.quizAttempts + 1),
        updatedAt: Value(DateTime.now()),
      ),
    );

    if (passed) {
      await incrementQuizzesPassed();
    }
  }

  /// Get completed lessons count for a chapter
  Future<int> getCompletedCountForChapter(int chapterId) async {
    final query = select(lessonProgress).join([
      innerJoin(lessons, lessons.id.equalsExp(lessonProgress.lessonId)),
    ])
      ..where(lessons.chapterId.equals(chapterId))
      ..where(lessonProgress.isCompleted.equals(true));

    final results = await query.get();
    return results.length;
  }

  /// Check if lesson is completed
  Future<bool> isLessonCompleted(int lessonId) async {
    final progress = await getLessonProgress(lessonId);
    return progress?.isCompleted ?? false;
  }

  /// Get total lessons count in the app
  Future<int> getTotalLessonsCount() async {
    final count = countAll();
    final query = selectOnly(lessons)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Watch total lessons count
  Stream<int> watchTotalLessonsCount() {
    final count = countAll();
    final query = selectOnly(lessons)..addColumns([count]);
    return query.watchSingle().map((row) => row.read(count) ?? 0);
  }
}
