import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/daos/bookmarks_dao.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/entities/bookmark_entity.dart';

part 'bookmark_repository.g.dart';

/// Repository for bookmark operations
/// From Issue #8 - Bookmarks Feature
class BookmarkRepository {
  BookmarkRepository(this._dao);

  final BookmarksDao _dao;

  /// Get all bookmarks
  Future<List<BookmarkEntity>> getAllBookmarks() async {
    final data = await _dao.getAllBookmarks();
    return data.map(_mapToEntity).toList();
  }

  /// Watch all bookmarks
  Stream<List<BookmarkEntity>> watchAllBookmarks() {
    return _dao.watchAllBookmarks().map(
          (data) => data.map(_mapToEntity).toList(),
        );
  }

  /// Check if lesson is bookmarked
  Future<bool> isLessonBookmarked(int lessonId) {
    return _dao.isLessonBookmarked(lessonId);
  }

  /// Watch if lesson is bookmarked
  Stream<bool> watchIsLessonBookmarked(int lessonId) {
    return _dao.watchIsLessonBookmarked(lessonId);
  }

  /// Add bookmark
  Future<int> addBookmark(int lessonId, {String? note}) {
    return _dao.addBookmark(lessonId, note: note);
  }

  /// Remove bookmark
  Future<void> removeBookmark(int lessonId) async {
    await _dao.removeBookmark(lessonId);
  }

  /// Toggle bookmark
  Future<bool> toggleBookmark(int lessonId) {
    return _dao.toggleBookmark(lessonId);
  }

  /// Get bookmarks count
  Future<int> getBookmarksCount() {
    return _dao.getBookmarksCount();
  }

  BookmarkEntity _mapToEntity(BookmarkWithLesson data) {
    return BookmarkEntity(
      id: data.bookmark.id,
      lessonId: data.lesson.id,
      lessonTitle: data.lesson.title,
      lessonTitleArabic: data.lesson.titleArabic,
      chapterTitle: data.chapter.title,
      chapterTitleArabic: data.chapter.titleArabic,
      lessonDurationMinutes: data.lesson.durationMinutes,
      hasAudio: data.lesson.hasAudio,
      hasQuiz: data.lesson.hasQuiz,
      isCompleted: data.progress?.isCompleted ?? false,
      note: data.bookmark.note,
      createdAt: data.bookmark.createdAt,
    );
  }
}

/// Bookmark repository provider
@riverpod
BookmarkRepository bookmarkRepository(BookmarkRepositoryRef ref) {
  final dao = ref.watch(bookmarksDaoProvider);
  return BookmarkRepository(dao);
}

/// All bookmarks provider
@riverpod
Stream<List<BookmarkEntity>> allBookmarks(AllBookmarksRef ref) {
  final repo = ref.watch(bookmarkRepositoryProvider);
  return repo.watchAllBookmarks();
}

/// Is lesson bookmarked provider
@riverpod
Stream<bool> isLessonBookmarked(IsLessonBookmarkedRef ref, int lessonId) {
  final repo = ref.watch(bookmarkRepositoryProvider);
  return repo.watchIsLessonBookmarked(lessonId);
}

/// Bookmarks count provider
@riverpod
Future<int> bookmarksCount(BookmarksCountRef ref) {
  final repo = ref.watch(bookmarkRepositoryProvider);
  return repo.getBookmarksCount();
}
