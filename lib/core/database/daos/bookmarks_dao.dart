import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/bookmarks_table.dart';
import '../tables/chapters_table.dart';

part 'bookmarks_dao.g.dart';

/// DAO for bookmarks operations
/// From Issue #4 - Database Setup
@DriftAccessor(tables: [Bookmarks, Lessons, Chapters])
class BookmarksDao extends DatabaseAccessor<AppDatabase>
    with _$BookmarksDaoMixin {
  BookmarksDao(super.db);

  /// Get all bookmarks with lesson info
  Future<List<BookmarkWithLesson>> getAllBookmarks() async {
    final query = select(bookmarks).join([
      innerJoin(lessons, lessons.id.equalsExp(bookmarks.lessonId)),
      innerJoin(chapters, chapters.id.equalsExp(lessons.chapterId)),
    ])
      ..orderBy([OrderingTerm.desc(bookmarks.createdAt)]);

    final results = await query.get();
    return results.map((row) {
      return BookmarkWithLesson(
        bookmark: row.readTable(bookmarks),
        lesson: row.readTable(lessons),
        chapter: row.readTable(chapters),
      );
    }).toList();
  }

  /// Watch all bookmarks
  Stream<List<BookmarkWithLesson>> watchAllBookmarks() {
    final query = select(bookmarks).join([
      innerJoin(lessons, lessons.id.equalsExp(bookmarks.lessonId)),
      innerJoin(chapters, chapters.id.equalsExp(lessons.chapterId)),
    ])
      ..orderBy([OrderingTerm.desc(bookmarks.createdAt)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return BookmarkWithLesson(
          bookmark: row.readTable(bookmarks),
          lesson: row.readTable(lessons),
          chapter: row.readTable(chapters),
        );
      }).toList();
    });
  }

  /// Check if lesson is bookmarked
  Future<bool> isLessonBookmarked(int lessonId) async {
    final bookmark = await (select(bookmarks)
          ..where((t) => t.lessonId.equals(lessonId)))
        .getSingleOrNull();
    return bookmark != null;
  }

  /// Watch if lesson is bookmarked
  Stream<bool> watchIsLessonBookmarked(int lessonId) {
    return (select(bookmarks)..where((t) => t.lessonId.equals(lessonId)))
        .watchSingleOrNull()
        .map((bookmark) => bookmark != null);
  }

  /// Add bookmark
  Future<int> addBookmark(int lessonId, {String? note}) {
    return into(bookmarks).insert(
      BookmarksCompanion.insert(
        lessonId: lessonId,
        note: Value(note),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  /// Remove bookmark
  Future<int> removeBookmark(int lessonId) {
    return (delete(bookmarks)..where((t) => t.lessonId.equals(lessonId))).go();
  }

  /// Toggle bookmark
  Future<bool> toggleBookmark(int lessonId) async {
    final isBookmarked = await isLessonBookmarked(lessonId);
    if (isBookmarked) {
      await removeBookmark(lessonId);
      return false;
    } else {
      await addBookmark(lessonId);
      return true;
    }
  }

  /// Get bookmarks count
  Future<int> getBookmarksCount() async {
    final count = countAll();
    final query = selectOnly(bookmarks)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }
}

/// Bookmark with associated lesson and chapter info
class BookmarkWithLesson {
  final Bookmark bookmark;
  final Lesson lesson;
  final Chapter chapter;

  BookmarkWithLesson({
    required this.bookmark,
    required this.lesson,
    required this.chapter,
  });
}
