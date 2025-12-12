import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/chapters_table.dart';

part 'chapters_dao.g.dart';

/// DAO for chapters operations
/// From Issue #4 - Database Setup
@DriftAccessor(tables: [Chapters, Lessons])
class ChaptersDao extends DatabaseAccessor<AppDatabase>
    with _$ChaptersDaoMixin {
  ChaptersDao(super.db);

  /// Get all chapters ordered by sort order
  Future<List<Chapter>> getAllChapters() {
    return (select(chapters)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  /// Get chapter by ID
  Future<Chapter?> getChapterById(int id) {
    return (select(chapters)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Get chapter by server ID
  Future<Chapter?> getChapterByServerId(String serverId) {
    return (select(chapters)..where((t) => t.serverId.equals(serverId)))
        .getSingleOrNull();
  }

  /// Watch all chapters
  Stream<List<Chapter>> watchAllChapters() {
    return (select(chapters)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  /// Insert or update a chapter
  Future<int> upsertChapter(ChaptersCompanion chapter) {
    return into(chapters).insertOnConflictUpdate(chapter);
  }

  /// Insert multiple chapters
  Future<void> insertChapters(List<ChaptersCompanion> chaptersList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(chapters, chaptersList);
    });
  }

  /// Delete a chapter
  Future<int> deleteChapter(int id) {
    return (delete(chapters)..where((t) => t.id.equals(id))).go();
  }

  /// Get lessons count for a chapter
  Future<int> getLessonsCount(int chapterId) async {
    final count = countAll();
    final query = selectOnly(lessons)
      ..addColumns([count])
      ..where(lessons.chapterId.equals(chapterId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Update chapter lesson count
  Future<void> updateLessonCount(int chapterId) async {
    final count = await getLessonsCount(chapterId);
    await (update(chapters)..where((t) => t.id.equals(chapterId)))
        .write(ChaptersCompanion(lessonCount: Value(count)));
  }
}
