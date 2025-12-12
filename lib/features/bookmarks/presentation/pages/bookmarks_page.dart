import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/cards/lesson_card.dart';
import '../../../../core/widgets/empty_view.dart';

/// Bookmarks page showing saved lessons
/// From Issue #3 - Navigation & Routing
class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Load bookmarks from database
    const hasBookmarks = true; // Simulated

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        actions: [
          if (hasBookmarks)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                // TODO: Clear all bookmarks
              },
            ),
        ],
      ),
      body: hasBookmarks ? _buildBookmarksList(context) : _buildEmptyState(),
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

  Widget _buildBookmarksList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.md),
      children: [
        // Recently added section
        Text(
          'Recently Added',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: Spacing.md),

        LessonCard(
          title: 'The Story of Prophet Yusuf (AS)',
          subtitle: 'Stories of the Prophets',
          duration: '15 min',
          hasAudio: true,
          isCompleted: true,
          onTap: () => context.push(
            AppRoutes.lessonDetailPath('prophet-yusuf', 'lesson-1'),
          ),
        ),
        const SizedBox(height: Spacing.md),

        LessonCard(
          title: 'The Night Journey',
          subtitle: 'Prophet Muhammad (SAW)',
          duration: '12 min',
          hasAudio: true,
          hasQuiz: true,
          isCompleted: false,
          onTap: () => context.push(
            AppRoutes.lessonDetailPath('prophet-muhammad', 'night-journey'),
          ),
        ),
        const SizedBox(height: Spacing.md),

        LessonCard(
          title: 'The Patience of Prophet Ayyub',
          subtitle: 'Islamic Values',
          duration: '10 min',
          hasAudio: true,
          isCompleted: false,
          onTap: () => context.push(
            AppRoutes.lessonDetailPath('islamic-values', 'patience'),
          ),
        ),
        const SizedBox(height: Spacing.xl),

        // Older bookmarks section
        Text(
          'Older Bookmarks',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: Spacing.md),

        LessonCard(
          title: 'The Story of Prophet Nuh (AS)',
          subtitle: 'Stories of the Prophets',
          duration: '8 min',
          hasAudio: true,
          isCompleted: true,
          onTap: () => context.push(
            AppRoutes.lessonDetailPath('prophet-nuh', 'lesson-1'),
          ),
        ),
        const SizedBox(height: Spacing.md),

        LessonCard(
          title: 'The Importance of Honesty',
          subtitle: 'Islamic Values',
          duration: '7 min',
          hasAudio: true,
          hasQuiz: true,
          isCompleted: true,
          onTap: () => context.push(
            AppRoutes.lessonDetailPath('islamic-values', 'honesty'),
          ),
        ),
        const SizedBox(height: Spacing.xl),
      ],
    );
  }
}
