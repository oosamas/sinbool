import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/cards/lesson_card.dart';
import '../../../../core/widgets/progress/progress_bar.dart';

/// Chapter detail page showing lessons
/// From Issue #3 - Navigation & Routing
class ChapterDetailPage extends StatelessWidget {
  const ChapterDetailPage({required this.chapterId, super.key});

  final String chapterId;

  @override
  Widget build(BuildContext context) {
    // TODO: Load chapter data based on chapterId
    final chapterTitle = _getChapterTitle(chapterId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with chapter info
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(chapterTitle),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.auto_stories,
                    size: 64,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  // TODO: Add to bookmarks
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // TODO: Share chapter
                },
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
                    _getChapterDescription(chapterId),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
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
                            const AppProgressBar(progress: 0.4),
                          ],
                        ),
                      ),
                      const SizedBox(width: Spacing.lg),
                      const LessonStats(
                        completedLessons: 4,
                        totalLessons: 10,
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
          SliverPadding(
            padding: const EdgeInsets.all(Spacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                LessonCard(
                  title: 'Introduction',
                  subtitle: 'Learn about the background',
                  duration: '5 min',
                  isCompleted: true,
                  hasAudio: true,
                  onTap: () => context.push(
                    AppRoutes.lessonDetailPath(chapterId, 'lesson-1'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                LessonCard(
                  title: 'Part 1: The Beginning',
                  subtitle: 'How the story starts',
                  duration: '8 min',
                  isCompleted: true,
                  hasAudio: true,
                  hasQuiz: true,
                  onTap: () => context.push(
                    AppRoutes.lessonDetailPath(chapterId, 'lesson-2'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                LessonCard(
                  title: 'Part 2: The Journey',
                  subtitle: 'Following the path',
                  duration: '10 min',
                  isCompleted: true,
                  hasAudio: true,
                  onTap: () => context.push(
                    AppRoutes.lessonDetailPath(chapterId, 'lesson-3'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                LessonCard(
                  title: 'Part 3: The Challenges',
                  subtitle: 'Overcoming difficulties',
                  duration: '12 min',
                  isCompleted: true,
                  hasAudio: true,
                  hasQuiz: true,
                  onTap: () => context.push(
                    AppRoutes.lessonDetailPath(chapterId, 'lesson-4'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                LessonCard(
                  title: 'Part 4: The Triumph',
                  subtitle: 'Success through faith',
                  duration: '10 min',
                  isCompleted: false,
                  hasAudio: true,
                  onTap: () => context.push(
                    AppRoutes.lessonDetailPath(chapterId, 'lesson-5'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                LessonCard(
                  title: 'Part 5: Lessons Learned',
                  subtitle: 'What we can learn',
                  duration: '7 min',
                  isCompleted: false,
                  hasAudio: true,
                  hasQuiz: true,
                  onTap: () => context.push(
                    AppRoutes.lessonDetailPath(chapterId, 'lesson-6'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                LessonCard(
                  title: 'Final Quiz',
                  subtitle: 'Test your knowledge',
                  duration: '10 min',
                  isCompleted: false,
                  isLocked: true,
                  hasQuiz: true,
                  onTap: () {},
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getChapterTitle(String id) {
    final titles = {
      'prophet-adam': 'Prophet Adam (AS)',
      'prophet-nuh': 'Prophet Nuh (AS)',
      'prophet-ibrahim': 'Prophet Ibrahim (AS)',
      'prophet-yusuf': 'Prophet Yusuf (AS)',
      'prophet-musa': 'Prophet Musa (AS)',
      'prophet-isa': 'Prophet Isa (AS)',
      'prophet-muhammad': 'Prophet Muhammad (SAW)',
      'prophets': 'Stories of the Prophets',
      'quran-tales': 'Tales from the Quran',
      'islamic-values': 'Islamic Values',
    };
    return titles[id] ?? 'Chapter';
  }

  String _getChapterDescription(String id) {
    return 'Discover the beautiful story and learn valuable lessons about '
        'faith, patience, and trust in Allah. This chapter contains multiple '
        'lessons with audio narration and interactive quizzes to help '
        'reinforce learning.';
  }
}
