import 'package:drift/drift.dart';

import 'chapters_table.dart';

/// User progress table for overall app progress
/// From Issue #4 - Database Setup
class UserProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get totalLessonsCompleted => integer().withDefault(const Constant(0))();
  IntColumn get totalQuizzesPassed => integer().withDefault(const Constant(0))();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  IntColumn get totalTimeMinutes => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastActivityDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Lesson progress table for individual lesson tracking
class LessonProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonId => integer().references(Lessons, #id)();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get lastPageViewed => integer().withDefault(const Constant(0))();
  IntColumn get quizScore => integer().nullable()();
  IntColumn get quizAttempts => integer().withDefault(const Constant(0))();
  IntColumn get timeSpentMinutes => integer().withDefault(const Constant(0))();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {lessonId}
      ];
}
