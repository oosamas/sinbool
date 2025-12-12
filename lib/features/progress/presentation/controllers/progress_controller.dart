import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/progress_repository.dart';
import '../../domain/entities/achievement_entity.dart';
import '../../domain/entities/user_progress_entity.dart';

part 'progress_controller.g.dart';

/// Progress controller state
class ProgressState {
  const ProgressState({
    required this.userProgress,
    required this.achievements,
    this.totalLessons = 40, // Default total lessons in app
    this.isLoading = false,
    this.error,
  });

  final UserProgressEntity userProgress;
  final List<AchievementEntity> achievements;
  final int totalLessons;
  final bool isLoading;
  final String? error;

  /// Overall progress percentage
  double get overallProgress {
    if (totalLessons == 0) return 0.0;
    return userProgress.totalLessonsCompleted / totalLessons;
  }

  /// Number of unlocked achievements
  int get unlockedAchievementsCount {
    return achievements.where((a) => a.isUnlocked).length;
  }

  /// Recently unlocked achievements (last 3)
  List<AchievementEntity> get recentAchievements {
    return achievements.where((a) => a.isUnlocked).take(4).toList();
  }

  /// Locked achievements for display
  List<AchievementEntity> get lockedAchievements {
    return achievements.where((a) => !a.isUnlocked).toList();
  }

  ProgressState copyWith({
    UserProgressEntity? userProgress,
    List<AchievementEntity>? achievements,
    int? totalLessons,
    bool? isLoading,
    String? error,
  }) {
    return ProgressState(
      userProgress: userProgress ?? this.userProgress,
      achievements: achievements ?? this.achievements,
      totalLessons: totalLessons ?? this.totalLessons,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  /// Initial state
  static const initial = ProgressState(
    userProgress: UserProgressEntity.empty,
    achievements: [],
    isLoading: true,
  );
}

/// Progress controller for managing user progress state
@riverpod
class ProgressController extends _$ProgressController {
  @override
  ProgressState build() {
    _loadProgress();
    return ProgressState.initial;
  }

  ProgressRepository get _repository => ref.read(progressRepositoryProvider);

  /// Load progress data
  Future<void> _loadProgress() async {
    try {
      state = state.copyWith(isLoading: true);

      // Watch user progress stream
      ref.listen(userProgressProvider, (previous, next) {
        next.when(
          data: (progress) {
            state = state.copyWith(
              userProgress: progress,
              isLoading: false,
            );
          },
          loading: () {},
          error: (e, _) {
            state = state.copyWith(error: e.toString(), isLoading: false);
          },
        );
      });

      // Watch achievements stream
      ref.listen(achievementsProvider, (previous, next) {
        next.when(
          data: (achievements) {
            state = state.copyWith(achievements: achievements);
          },
          loading: () {},
          error: (e, _) {},
        );
      });
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Mark a lesson as started
  Future<void> startLesson(int lessonId) async {
    try {
      await _repository.markLessonStarted(lessonId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Update reading progress (page number)
  Future<void> updateReadingProgress(int lessonId, int pageNumber) async {
    try {
      await _repository.updateLastPage(lessonId, pageNumber);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Complete a lesson
  Future<void> completeLesson(int lessonId) async {
    try {
      await _repository.markLessonCompleted(lessonId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Submit quiz results
  Future<void> submitQuizResults(int lessonId, int score, int total) async {
    try {
      await _repository.recordQuizScore(lessonId, score, total);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Add time spent learning
  Future<void> trackTimeSpent(int minutes) async {
    try {
      await _repository.addTimeSpent(minutes);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Refresh progress data
  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadProgress();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
