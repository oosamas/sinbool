import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/cards/lesson_card.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../domain/entities/bookmark_entity.dart';
import '../controllers/bookmark_controller.dart';

/// Bookmarks page showing saved lessons
/// From Issue #3 - Navigation & Routing
/// Updated in Issue #8 - Bookmarks Feature
class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkState = ref.watch(bookmarkControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        actions: [
          if (bookmarkState.hasBookmarks)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showClearAllDialog(context, ref),
            ),
        ],
      ),
      body: bookmarkState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookmarkState.hasBookmarks
              ? _buildBookmarksList(context, ref, bookmarkState)
              : _buildEmptyState(),
    );
  }

  Widget _buildEmptyState() {
    return const EmptyView(
      icon: Icons.bookmark_border,
      title: 'No Bookmarks Yet',
      message: 'Save your favorite lessons here for quick access. '
          'Tap the bookmark icon on any lesson to add it.',
    );
  }

  Widget _buildBookmarksList(
    BuildContext context,
    WidgetRef ref,
    BookmarkState state,
  ) {
    final recentBookmarks = state.recentBookmarks;
    final olderBookmarks = state.olderBookmarks;

    return ListView(
      padding: const EdgeInsets.all(Spacing.md),
      children: [
        if (recentBookmarks.isNotEmpty) ...[
          _buildSectionHeader(context, 'Recently Added'),
          const SizedBox(height: Spacing.md),
          ...recentBookmarks.map((bookmark) => Padding(
                padding: const EdgeInsets.only(bottom: Spacing.md),
                child: _BookmarkCard(
                  bookmark: bookmark,
                  onTap: () => _navigateToLesson(context, bookmark),
                  onRemove: () => _removeBookmark(context, ref, bookmark),
                ),
              )),
          const SizedBox(height: Spacing.lg),
        ],
        if (olderBookmarks.isNotEmpty) ...[
          _buildSectionHeader(context, 'Older Bookmarks'),
          const SizedBox(height: Spacing.md),
          ...olderBookmarks.map((bookmark) => Padding(
                padding: const EdgeInsets.only(bottom: Spacing.md),
                child: _BookmarkCard(
                  bookmark: bookmark,
                  onTap: () => _navigateToLesson(context, bookmark),
                  onRemove: () => _removeBookmark(context, ref, bookmark),
                ),
              )),
        ],
        if (recentBookmarks.isEmpty && olderBookmarks.isEmpty)
          ...state.bookmarks.map((bookmark) => Padding(
                padding: const EdgeInsets.only(bottom: Spacing.md),
                child: _BookmarkCard(
                  bookmark: bookmark,
                  onTap: () => _navigateToLesson(context, bookmark),
                  onRemove: () => _removeBookmark(context, ref, bookmark),
                ),
              )),
        const SizedBox(height: Spacing.xl),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  void _navigateToLesson(BuildContext context, BookmarkEntity bookmark) {
    context.push(
      AppRoutes.lessonDetailPath(
        bookmark.lessonId.toString(),
        bookmark.lessonId.toString(),
      ),
    );
  }

  void _removeBookmark(
    BuildContext context,
    WidgetRef ref,
    BookmarkEntity bookmark,
  ) {
    ref.read(bookmarkControllerProvider.notifier).removeBookmark(bookmark.lessonId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed "${bookmark.lessonTitle}" from bookmarks'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ref
                .read(bookmarkControllerProvider.notifier)
                .addBookmark(bookmark.lessonId);
          },
        ),
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Bookmarks?'),
        content: const Text(
          'This will remove all your saved bookmarks. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(bookmarkControllerProvider.notifier).clearAllBookmarks();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All bookmarks cleared')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

/// Bookmark card widget with swipe to delete
class _BookmarkCard extends StatelessWidget {
  const _BookmarkCard({
    required this.bookmark,
    required this.onTap,
    required this.onRemove,
  });

  final BookmarkEntity bookmark;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('bookmark_${bookmark.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: Spacing.lg),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onRemove(),
      child: LessonCard(
        title: bookmark.lessonTitle,
        subtitle: bookmark.chapterTitle,
        duration: bookmark.formattedDuration,
        hasAudio: bookmark.hasAudio,
        hasQuiz: bookmark.hasQuiz,
        isCompleted: bookmark.isCompleted,
        onTap: onTap,
        trailing: IconButton(
          icon: const Icon(
            Icons.bookmark,
            color: AppColors.secondary,
          ),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
