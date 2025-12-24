import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/cards/lesson_card.dart';
import '../../../../core/widgets/progress/progress_bar.dart';
import '../../../lessons/data/repositories/lesson_repository.dart';
import '../../../lessons/domain/entities/lesson_entity.dart';
import '../../data/repositories/chapter_repository.dart';
import '../../domain/entities/chapter_entity.dart';

/// Chapter detail page showing lessons
/// From Issue #3 - Navigation & Routing
class ChapterDetailPage extends ConsumerWidget {
  const ChapterDetailPage({required this.chapterId, super.key});

  final String chapterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapterAsync = ref.watch(chapterProvider(chapterId));

    return chapterAsync.when(
      data: (chapter) {
        if (chapter == null) {
          return _buildNotFound(context);
        }
        return _ChapterDetailContent(chapter: chapter);
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: Spacing.md),
              const Text('Failed to load chapter'),
              const SizedBox(height: Spacing.md),
              ElevatedButton(
                onPressed: () => ref.invalidate(chapterProvider(chapterId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: AppColors.textHint),
            const SizedBox(height: Spacing.md),
            Text(
              'Chapter not found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: Spacing.md),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChapterDetailContent extends ConsumerWidget {
  const _ChapterDetailContent({required this.chapter});

  final ChapterEntity chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsAsync = ref.watch(lessonsForChapterProvider(chapter.id));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with chapter info
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                chapter.title,
                style: const TextStyle(
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [chapter.color, chapter.color.withValues(alpha: 0.8)],
                  ),
                ),
                child: Center(
                  child: Icon(
                    chapter.icon,
                    size: 64,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                tooltip: 'Bookmark lessons',
                onPressed: () => _showBookmarkInfo(context),
              ),
              IconButton(
                icon: const Icon(Icons.share),
                tooltip: 'Share chapter',
                onPressed: () => _shareChapter(context),
              ),
            ],
          ),

          // Chapter description and progress
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About this Chapter',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: Spacing.sm),
                  Text(
                    chapter.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  if (chapter.isPremium) ...[
                    const SizedBox(height: Spacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.md,
                        vertical: Spacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(
                          color: AppColors.secondary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, color: AppColors.secondary, size: 20),
                          SizedBox(width: Spacing.sm),
                          Text(
                            'Premium Content',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: Spacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progress',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: Spacing.xs),
                            AppProgressBar(progress: chapter.progress),
                          ],
                        ),
                      ),
                      const SizedBox(width: Spacing.lg),
                      LessonStats(
                        completedLessons: chapter.completedCount,
                        totalLessons: chapter.lessonCount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Lessons header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              child: Text(
                'Lessons',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // Lesson list
          lessonsAsync.when(
            data: (lessons) => _buildLessonList(context, lessons),
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(Spacing.xl),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            error: (error, stack) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.error),
                      const SizedBox(height: Spacing.sm),
                      const Text('Failed to load lessons'),
                      TextButton(
                        onPressed: () => ref.invalidate(
                          lessonsForChapterProvider(chapter.id),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonList(BuildContext context, List<LessonEntity> lessons) {
    if (lessons.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.menu_book_outlined,
                  size: 48,
                  color: AppColors.textHint,
                ),
                const SizedBox(height: Spacing.md),
                Text(
                  'No lessons available yet',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(Spacing.lg),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final lesson = lessons[index];
            final isFirstLesson = index == 0;

            return Padding(
              padding: const EdgeInsets.only(bottom: Spacing.md),
              child: LessonCard(
                title: lesson.title,
                subtitle: lesson.subtitle,
                duration: lesson.duration,
                isCompleted: lesson.isCompleted,
                isLocked: lesson.isLocked,
                hasAudio: lesson.hasAudio,
                hasQuiz: lesson.hasQuiz,
                isPremium: lesson.isPremium && !isFirstLesson,
                isFree: lesson.isPremium && isFirstLesson,
                onTap: () => context.push(
                  AppRoutes.lessonDetailPath(chapter.serverId, lesson.serverId),
                ),
              ),
            );
          },
          childCount: lessons.length,
        ),
      ),
    );
  }

  void _showBookmarkInfo(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tap on individual lessons to bookmark them'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareChapter(BuildContext context) {
    final shareText = 'Check out "${chapter.title}" on Sinbool - '
        'Islamic Stories for Kids!\n\n'
        '${chapter.description}\n\n'
        'Download the app to learn more!';

    // Copy to clipboard and show confirmation
    Clipboard.setData(ClipboardData(text: shareText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: Spacing.sm),
            Text('Chapter info copied to clipboard!'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Widget to display lesson completion stats
class LessonStats extends StatelessWidget {
  const LessonStats({
    required this.completedLessons,
    required this.totalLessons,
    super.key,
  });

  final int completedLessons;
  final int totalLessons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          Text(
            '$completedLessons/$totalLessons',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
          Text(
            'lessons',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
