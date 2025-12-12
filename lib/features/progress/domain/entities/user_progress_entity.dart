/// User progress entity representing overall learning progress
/// From Issue #7 - User Progress & Analytics
class UserProgressEntity {
  const UserProgressEntity({
    required this.totalLessonsCompleted,
    required this.totalQuizzesPassed,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalTimeMinutes,
    this.lastActivityDate,
  });

  final int totalLessonsCompleted;
  final int totalQuizzesPassed;
  final int currentStreak;
  final int longestStreak;
  final int totalTimeMinutes;
  final DateTime? lastActivityDate;

  /// Get formatted time spent
  String get formattedTimeSpent {
    if (totalTimeMinutes < 60) {
      return '$totalTimeMinutes min';
    }
    final hours = totalTimeMinutes ~/ 60;
    final minutes = totalTimeMinutes % 60;
    if (minutes == 0) {
      return '$hours hr';
    }
    return '$hours hr $minutes min';
  }

  /// Check if user was active today
  bool get wasActiveToday {
    if (lastActivityDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(
      lastActivityDate!.year,
      lastActivityDate!.month,
      lastActivityDate!.day,
    );
    return today.isAtSameMomentAs(lastDate);
  }

  /// Get days since last activity
  int get daysSinceLastActivity {
    if (lastActivityDate == null) return -1;
    final now = DateTime.now();
    return now.difference(lastActivityDate!).inDays;
  }

  /// Empty progress
  static const empty = UserProgressEntity(
    totalLessonsCompleted: 0,
    totalQuizzesPassed: 0,
    currentStreak: 0,
    longestStreak: 0,
    totalTimeMinutes: 0,
  );

  UserProgressEntity copyWith({
    int? totalLessonsCompleted,
    int? totalQuizzesPassed,
    int? currentStreak,
    int? longestStreak,
    int? totalTimeMinutes,
    DateTime? lastActivityDate,
  }) {
    return UserProgressEntity(
      totalLessonsCompleted: totalLessonsCompleted ?? this.totalLessonsCompleted,
      totalQuizzesPassed: totalQuizzesPassed ?? this.totalQuizzesPassed,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalTimeMinutes: totalTimeMinutes ?? this.totalTimeMinutes,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
    );
  }
}

/// Lesson progress entity for individual lesson tracking
class LessonProgressEntity {
  const LessonProgressEntity({
    required this.lessonId,
    required this.isCompleted,
    required this.lastPageViewed,
    this.quizScore,
    required this.quizAttempts,
    required this.timeSpentMinutes,
    this.startedAt,
    this.completedAt,
  });

  final int lessonId;
  final bool isCompleted;
  final int lastPageViewed;
  final int? quizScore;
  final int quizAttempts;
  final int timeSpentMinutes;
  final DateTime? startedAt;
  final DateTime? completedAt;

  /// Check if quiz was passed (70% or higher)
  bool get quizPassed => quizScore != null && quizScore! >= 70;

  /// Get progress status
  LessonStatus get status {
    if (isCompleted) return LessonStatus.completed;
    if (startedAt != null) return LessonStatus.inProgress;
    return LessonStatus.notStarted;
  }

  /// Empty progress for a lesson
  factory LessonProgressEntity.empty(int lessonId) {
    return LessonProgressEntity(
      lessonId: lessonId,
      isCompleted: false,
      lastPageViewed: 0,
      quizAttempts: 0,
      timeSpentMinutes: 0,
    );
  }
}

/// Lesson completion status
enum LessonStatus {
  notStarted,
  inProgress,
  completed,
}
