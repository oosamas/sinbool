import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/cards/chapter_card.dart';
import '../../../../core/widgets/cards/story_card.dart';
import '../../../../core/widgets/progress/progress_bar.dart';

/// Home page - main landing screen
/// From Issue #3 - Navigation & Routing
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                          const LessonStats(
                            completedLessons: 12,
                            totalLessons: 40,
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.sm),
                      const AppProgressBar(
                        progress: 0.3,
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

          // Continue learning cards
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                children: [
                  StoryCardHorizontal(
                    title: 'Prophet Yusuf (AS)',
                    subtitle: 'Chapter 3 - The Dream',
                    imageUrl: null,
                    progress: 0.6,
                    onTap: () => context.push(
                      AppRoutes.chapterDetailPath('prophet-yusuf'),
                    ),
                  ),
                  const SizedBox(width: Spacing.md),
                  StoryCardHorizontal(
                    title: 'Prophet Musa (AS)',
                    subtitle: 'Chapter 1 - The Beginning',
                    imageUrl: null,
                    progress: 0.2,
                    onTap: () => context.push(
                      AppRoutes.chapterDetailPath('prophet-musa'),
                    ),
                  ),
                ],
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

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ChapterCard(
                  title: 'Stories of the Prophets',
                  description:
                      'Learn about the great Prophets and their teachings',
                  icon: Icons.auto_stories,
                  lessonCount: 25,
                  completedCount: 8,
                  color: AppColors.primary,
                  onTap: () => context.push(
                    AppRoutes.chapterDetailPath('prophets'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                ChapterCard(
                  title: 'Tales from the Quran',
                  description: 'Beautiful stories mentioned in the Holy Quran',
                  icon: Icons.menu_book,
                  lessonCount: 15,
                  completedCount: 4,
                  color: AppColors.secondary,
                  onTap: () => context.push(
                    AppRoutes.chapterDetailPath('quran-tales'),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                ChapterCard(
                  title: 'Islamic Values',
                  description: 'Stories teaching honesty, kindness, and faith',
                  icon: Icons.favorite,
                  lessonCount: 10,
                  completedCount: 0,
                  color: AppColors.success,
                  isPremium: true,
                  onTap: () => context.push(
                    AppRoutes.chapterDetailPath('islamic-values'),
                  ),
                ),
                const SizedBox(height: Spacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
