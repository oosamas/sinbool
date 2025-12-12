import 'package:drift/drift.dart';

/// Chapters table for storing chapter metadata
/// From Issue #4 - Database Setup
class Chapters extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  TextColumn get title => text()();
  TextColumn get titleArabic => text().nullable()();
  TextColumn get description => text()();
  TextColumn get descriptionArabic => text().nullable()();
  TextColumn get iconName => text().withDefault(const Constant('menu_book'))();
  TextColumn get colorHex => text().withDefault(const Constant('#2E7D32'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get lessonCount => integer().withDefault(const Constant(0))();
  BoolColumn get isPremium => boolean().withDefault(const Constant(false))();
  BoolColumn get isDownloaded => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Lessons table for storing lesson metadata
class Lessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().unique()();
  IntColumn get chapterId => integer().references(Chapters, #id)();
  TextColumn get title => text()();
  TextColumn get titleArabic => text().nullable()();
  TextColumn get subtitle => text().nullable()();
  TextColumn get subtitleArabic => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get durationMinutes => integer().withDefault(const Constant(5))();
  BoolColumn get hasAudio => boolean().withDefault(const Constant(false))();
  BoolColumn get hasQuiz => boolean().withDefault(const Constant(false))();
  TextColumn get thumbnailUrl => text().nullable()();
  TextColumn get audioUrl => text().nullable()();
  BoolColumn get isPremium => boolean().withDefault(const Constant(false))();
  BoolColumn get isDownloaded => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
