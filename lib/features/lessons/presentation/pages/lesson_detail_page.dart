import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../bookmarks/data/repositories/bookmark_repository.dart';

/// Lesson detail page with content options
/// From Issue #3 - Navigation & Routing
/// Updated in Issue #8 - Bookmarks Feature
class LessonDetailPage extends ConsumerWidget {
  const LessonDetailPage({
    required this.chapterId,
    required this.lessonId,
    super.key,
  });

  final String chapterId;
  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Parse lesson ID for bookmark functionality
    final parsedLessonId = int.tryParse(lessonId) ?? 0;

    // Watch bookmark state
    final isBookmarkedAsync = ref.watch(isLessonBookmarkedProvider(parsedLessonId));
    final isBookmarked = isBookmarkedAsync.valueOrNull ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? AppColors.secondary : null,
            ),
            onPressed: () async {
              final repo = ref.read(bookmarkRepositoryProvider);
              final wasBookmarked = await repo.toggleBookmark(parsedLessonId);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wasBookmarked
                          ? 'Added to bookmarks'
                          : 'Removed from bookmarks',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson header image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: const Center(
                child: Icon(
                  Icons.auto_stories,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),

            // Lesson title
            Text(
              'Part 1: The Beginning',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: Spacing.sm),

            // Lesson meta info
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  '8 minutes',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(width: Spacing.md),
                const Icon(
                  Icons.headphones,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Audio available',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.lg),

            // Lesson description
            Text(
              'In this lesson, we will learn about the beginning of this '
              'beautiful story. You will discover important events and '
              'understand the context of what is to come.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: Spacing.xl),

            // Action buttons
            Text(
              'Choose how to learn',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: Spacing.md),

            // Read story button
            _LessonOptionCard(
              icon: Icons.menu_book,
              title: 'Read Story',
              subtitle: 'Read the story with illustrations',
              color: AppColors.primary,
              onTap: () => context.push(
                AppRoutes.storyViewerPath(chapterId, lessonId),
              ),
            ),
            const SizedBox(height: Spacing.md),

            // Listen button
            _LessonOptionCard(
              icon: Icons.headphones,
              title: 'Listen to Audio',
              subtitle: 'Listen to the narration',
              color: AppColors.secondary,
              onTap: () {
                // TODO: Open audio player
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Audio player coming soon!')),
                );
              },
            ),
            const SizedBox(height: Spacing.md),

            // Quiz button
            _LessonOptionCard(
              icon: Icons.quiz,
              title: 'Take Quiz',
              subtitle: 'Test your knowledge',
              color: AppColors.success,
              onTap: () => context.push(
                AppRoutes.quizScreenPath(chapterId, lessonId),
              ),
            ),
            const SizedBox(height: Spacing.xl),

            // Continue button
            AppButton(
              text: 'Start Reading',
              onPressed: () => context.push(
                AppRoutes.storyViewerPath(chapterId, lessonId),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonOptionCard extends StatelessWidget {
  const _LessonOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
