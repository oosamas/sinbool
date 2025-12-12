import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/cards/chapter_card.dart';

/// Chapters listing page
/// From Issue #3 - Navigation & Routing
class ChaptersPage extends StatelessWidget {
  const ChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Spacing.md),
        children: [
          // Category chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _CategoryChip(
                  label: 'All',
                  isSelected: true,
                  onTap: () {},
                ),
                _CategoryChip(
                  label: 'Prophets',
                  isSelected: false,
                  onTap: () {},
                ),
                _CategoryChip(
                  label: 'Quran Stories',
                  isSelected: false,
                  onTap: () {},
                ),
                _CategoryChip(
                  label: 'Values',
                  isSelected: false,
                  onTap: () {},
                ),
                _CategoryChip(
                  label: 'History',
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Chapter cards
          ChapterCard(
            title: 'Prophet Adam (AS)',
            description: 'The story of the first human and Prophet',
            icon: Icons.park,
            lessonCount: 5,
            completedCount: 5,
            color: AppColors.success,
            onTap: () => context.push(
              AppRoutes.chapterDetailPath('prophet-adam'),
            ),
          ),
          const SizedBox(height: Spacing.md),
          ChapterCard(
            title: 'Prophet Nuh (AS)',
            description: 'The great flood and the ark',
            icon: Icons.sailing,
            lessonCount: 6,
            completedCount: 3,
            color: AppColors.info,
            onTap: () => context.push(
              AppRoutes.chapterDetailPath('prophet-nuh'),
            ),
          ),
          const SizedBox(height: Spacing.md),
          ChapterCard(
            title: 'Prophet Ibrahim (AS)',
            description: 'The father of Prophets and his trials',
            icon: Icons.local_fire_department,
            lessonCount: 8,
            completedCount: 0,
            color: AppColors.warning,
            onTap: () => context.push(
              AppRoutes.chapterDetailPath('prophet-ibrahim'),
            ),
          ),
          const SizedBox(height: Spacing.md),
          ChapterCard(
            title: 'Prophet Yusuf (AS)',
            description: 'The beautiful story of patience and forgiveness',
            icon: Icons.star,
            lessonCount: 10,
            completedCount: 6,
            color: AppColors.secondary,
            onTap: () => context.push(
              AppRoutes.chapterDetailPath('prophet-yusuf'),
            ),
          ),
          const SizedBox(height: Spacing.md),
          ChapterCard(
            title: 'Prophet Musa (AS)',
            description: 'The story of the staff and the sea',
            icon: Icons.water,
            lessonCount: 12,
            completedCount: 2,
            color: AppColors.primary,
            onTap: () => context.push(
              AppRoutes.chapterDetailPath('prophet-musa'),
            ),
          ),
          const SizedBox(height: Spacing.md),
          ChapterCard(
            title: 'Prophet Isa (AS)',
            description: 'The miraculous birth and teachings',
            icon: Icons.wb_sunny,
            lessonCount: 7,
            completedCount: 0,
            color: AppColors.info,
            isPremium: true,
            onTap: () => context.push(
              AppRoutes.chapterDetailPath('prophet-isa'),
            ),
          ),
          const SizedBox(height: Spacing.md),
          ChapterCard(
            title: 'Prophet Muhammad (SAW)',
            description: 'The life of the final Messenger',
            icon: Icons.mosque,
            lessonCount: 20,
            completedCount: 0,
            color: AppColors.primary,
            isPremium: true,
            onTap: () => context.push(
              AppRoutes.chapterDetailPath('prophet-muhammad'),
            ),
          ),
          const SizedBox(height: Spacing.xl),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Spacing.sm),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        checkmarkColor: AppColors.primary,
      ),
    );
  }
}
