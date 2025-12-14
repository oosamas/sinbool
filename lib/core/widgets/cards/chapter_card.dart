import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';

/// Card for displaying a chapter in the chapter list
/// From Issue #2 - Design System
class ChapterCard extends StatelessWidget {
  const ChapterCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    super.key,
    this.lessonCount = 0,
    this.completedCount = 0,
    this.color,
    this.isPremium = false,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  final int lessonCount;
  final int completedCount;
  final Color? color;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primary;
    final progress =
        lessonCount > 0 ? completedCount / lessonCount : 0.0;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: cardColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  icon,
                  size: IconSizes.lg,
                  color: cardColor,
                ),
              ),
              const SizedBox(width: Spacing.md),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isPremium)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Spacing.sm,
                              vertical: Spacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: const Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.textOnSecondary,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: Spacing.xs),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Spacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: cardColor.withValues(alpha: 0.2),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(cardColor),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: Spacing.sm),
                        Text(
                          '$completedCount/$lessonCount',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow
              const SizedBox(width: Spacing.sm),
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
