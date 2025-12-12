import 'package:drift/drift.dart';

import 'chapters_table.dart';

/// Bookmarks table for user's saved content
/// From Issue #4 - Database Setup
class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonId => integer().references(Lessons, #id)();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {lessonId}
      ];
}
