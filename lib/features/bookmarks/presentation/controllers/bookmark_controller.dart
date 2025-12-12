import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/bookmark_repository.dart';
import '../../domain/entities/bookmark_entity.dart';

part 'bookmark_controller.g.dart';

/// Bookmark controller state
class BookmarkState {
  const BookmarkState({
    required this.bookmarks,
    this.isLoading = false,
    this.error,
  });

  final List<BookmarkEntity> bookmarks;
  final bool isLoading;
  final String? error;

  /// Check if has bookmarks
  bool get hasBookmarks => bookmarks.isNotEmpty;

  /// Get count
  int get count => bookmarks.length;

  /// Get recent bookmarks (this week)
  List<BookmarkEntity> get recentBookmarks {
    return bookmarks.where((b) => b.isAddedThisWeek).toList();
  }

  /// Get older bookmarks
  List<BookmarkEntity> get olderBookmarks {
    return bookmarks.where((b) => !b.isAddedThisWeek).toList();
  }

  BookmarkState copyWith({
    List<BookmarkEntity>? bookmarks,
    bool? isLoading,
    String? error,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  /// Initial state
  static const initial = BookmarkState(
    bookmarks: [],
    isLoading: true,
  );
}

/// Bookmark controller for managing bookmarks
@riverpod
class BookmarkController extends _$BookmarkController {
  @override
  BookmarkState build() {
    _loadBookmarks();
    return BookmarkState.initial;
  }

  BookmarkRepository get _repository => ref.read(bookmarkRepositoryProvider);

  /// Load bookmarks
  void _loadBookmarks() {
    ref.listen(allBookmarksProvider, (previous, next) {
      next.when(
        data: (bookmarks) {
          state = state.copyWith(
            bookmarks: bookmarks,
            isLoading: false,
          );
        },
        loading: () {
          state = state.copyWith(isLoading: true);
        },
        error: (e, _) {
          state = state.copyWith(error: e.toString(), isLoading: false);
        },
      );
    });
  }

  /// Add bookmark
  Future<void> addBookmark(int lessonId, {String? note}) async {
    try {
      await _repository.addBookmark(lessonId, note: note);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Remove bookmark
  Future<void> removeBookmark(int lessonId) async {
    try {
      await _repository.removeBookmark(lessonId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Toggle bookmark
  Future<bool> toggleBookmark(int lessonId) async {
    try {
      return await _repository.toggleBookmark(lessonId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Clear all bookmarks
  Future<void> clearAllBookmarks() async {
    try {
      for (final bookmark in state.bookmarks) {
        await _repository.removeBookmark(bookmark.lessonId);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
