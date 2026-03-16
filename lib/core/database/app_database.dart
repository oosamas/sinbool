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
import 'tables/audio_cache_table.dart';
import 'tables/subscription_table.dart';

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
    Subscriptions,
    PromoCodes,
    AudioCache,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migration from version 1 to 2: Add subscription tables
        if (from < 2) {
          await m.createTable(subscriptions);
          await m.createTable(promoCodes);
        }
        // Migration from version 2 to 3: Add audio cache table
        if (from < 3) {
          await m.createTable(audioCache);
        }
        // Migration from version 3 to 4: Recreate audio cache with composite unique key
        if (from == 3) {
          await m.deleteTable('audio_cache');
          await m.createTable(audioCache);
        }
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
