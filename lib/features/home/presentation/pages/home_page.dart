import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/cards/chapter_card.dart';
import '../../../../core/widgets/cards/story_card.dart';
import '../../../../core/widgets/progress/progress_bar.dart';
import '../../../chapters/data/repositories/chapter_repository.dart';
import '../../../progress/presentation/controllers/progress_controller.dart';

/// Home page - main landing screen
/// From Issue #3 - Navigation & Routing
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);
    final chaptersAsync = ref.watch(chaptersProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with greeting
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Assalamu Alaikum! ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: Spacing.xs),
                        Text(
                          'Continue your learning journey',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => context.push(AppRoutes.settings),
              ),
            ],
          ),

          // Overall progress
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Progress',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          LessonStats(
                            completedLessons:
                                progressState.userProgress.totalLessonsCompleted,
                            totalLessons: progressState.totalLessons,
                            streakDays:
                                progressState.userProgress.currentStreak,
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.sm),
                      AppProgressBar(
                        progress: progressState.overallProgress,
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Continue learning section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continue Learning',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.chapters),
                    child: const Text('See All'),
                  ),
                ],
              ),
            ),
          ),

          // Continue learning cards - show in-progress or first chapters
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: chaptersAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Center(child: Text('Could not load chapters')),
                data: (chapters) {
                  // Show in-progress chapters first, then first unstarted chapters
                  final inProgress = chapters.where((c) => c.isStarted && !c.isCompleted).toList();
                  final notStarted = chapters.where((c) => !c.isStarted).toList();
                  final displayChapters = [
                    ...inProgress,
                    ...notStarted,
                  ].take(5).toList();

                  if (displayChapters.isEmpty) {
                    return const Center(child: Text('All chapters completed!'));
                  }

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                    itemCount: displayChapters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: Spacing.md),
                    itemBuilder: (context, index) {
                      final chapter = displayChapters[index];
                      return StoryCardHorizontal(
                        title: chapter.title,
                        subtitle: '${chapter.completedCount}/${chapter.lessonCount} lessons',
                        imageUrl: null,
                        progress: chapter.progress,
                        onTap: () => context.push(
                          AppRoutes.chapterDetailPath(chapter.serverId),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // Featured chapters
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Text(
                'Featured Chapters',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // Featured chapter cards from real data
          chaptersAsync.when(
            loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SliverToBoxAdapter(
              child: Center(child: Text('Could not load chapters')),
            ),
            data: (chapters) {
              // Show first 3 chapters as featured
              final featured = chapters.take(3).toList();
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= featured.length) return null;
                      final chapter = featured[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index < featured.length - 1 ? Spacing.md : Spacing.xl,
                        ),
                        child: ChapterCard(
                          title: chapter.title,
                          description: chapter.description,
                          icon: chapter.icon,
                          lessonCount: chapter.lessonCount,
                          completedCount: chapter.completedCount,
                          color: chapter.color,
                          isPremium: chapter.isPremium,
                          onTap: () => context.push(
                            AppRoutes.chapterDetailPath(chapter.serverId),
                          ),
                        ),
                      );
                    },
                    childCount: featured.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
