import 'package:drift/drift.dart';

import 'chapters_table.dart';

/// Lesson content table for storing story pages
/// From Issue #4 - Database Setup
class LessonContent extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonId => integer().references(Lessons, #id)();
  IntColumn get pageNumber => integer()();
  TextColumn get contentText => text()();
  TextColumn get contentTextArabic => text().nullable()();
  TextColumn get translation => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get imageDescription => text().nullable()();
  TextColumn get audioTimestamp => text().nullable()(); // JSON: {"start": 0, "end": 30}
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Quiz questions table
class QuizQuestions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonId => integer().references(Lessons, #id)();
  TextColumn get question => text()();
  TextColumn get questionArabic => text().nullable()();
  TextColumn get options => text()(); // JSON array: ["option1", "option2", ...]
  TextColumn get optionsArabic => text().nullable()(); // JSON array
  IntColumn get correctIndex => integer()();
  TextColumn get explanation => text().nullable()();
  TextColumn get explanationArabic => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
