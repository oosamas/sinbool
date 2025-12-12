import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/chapters_table.dart';
import 'tables/lessons_table.dart';
import 'tables/bookmarks_table.dart';
import 'tables/progress_table.dart';
import 'tables/settings_table.dart';

part 'app_database.g.dart';

/// Main application database using Drift
/// From Issue #4 - Database Setup
@DriftDatabase(
  tables: [
    Chapters,
    Lessons,
    LessonContent,
    QuizQuestions,
    Bookmarks,
    UserProgress,
    LessonProgress,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle migrations here when schema changes
      },
      beforeOpen: (details) async {
        // Enable foreign keys
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sinbool.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
