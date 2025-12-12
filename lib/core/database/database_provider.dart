import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';
import 'daos/bookmarks_dao.dart';
import 'daos/chapters_dao.dart';
import 'daos/lessons_dao.dart';
import 'daos/progress_dao.dart';
import 'daos/settings_dao.dart';

part 'database_provider.g.dart';

/// Database instance provider
/// From Issue #4 - Database Setup
@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

/// Chapters DAO provider
@riverpod
ChaptersDao chaptersDao(ChaptersDaoRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return ChaptersDao(db);
}

/// Lessons DAO provider
@riverpod
LessonsDao lessonsDao(LessonsDaoRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return LessonsDao(db);
}

/// Bookmarks DAO provider
@riverpod
BookmarksDao bookmarksDao(BookmarksDaoRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return BookmarksDao(db);
}

/// Progress DAO provider
@riverpod
ProgressDao progressDao(ProgressDaoRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProgressDao(db);
}

/// Settings DAO provider
@riverpod
SettingsDao settingsDao(SettingsDaoRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return SettingsDao(db);
}
