import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';

/// Card for displaying a lesson in a list
/// From Issue #2 - Design System
class LessonCard extends StatelessWidget {
  const LessonCard({
    required this.title,
    required this.onTap,
    super.key,
    this.subtitle,
    this.duration,
    this.isCompleted = false,
    this.isLocked = false,
    this.hasAudio = false,
    this.hasQuiz = false,
    this.thumbnailUrl,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final String? duration;
  final VoidCallback onTap;
  final bool isCompleted;
  final bool isLocked;
  final bool hasAudio;
  final bool hasQuiz;
  final String? thumbnailUrl;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: isLocked ? null : onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              // Thumbnail or placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  image: thumbnailUrl != null
                      ? DecorationImage(
                          image: NetworkImage(thumbnailUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: thumbnailUrl == null
                    ? const Icon(
                        Icons.menu_book,
                        size: IconSizes.lg,
                        color: AppColors.textHint,
                      )
                    : null,
              ),
              const SizedBox(width: Spacing.md),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: Spacing.xs),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: Spacing.sm),
                    Row(
                      children: [
                        if (duration != null) ...[
                          const Icon(
                            Icons.schedule,
                            size: 14,
                            color: AppColors.textHint,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            duration!,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(width: Spacing.md),
                        ],
                        if (hasAudio)
                          const _FeatureChip(
                            icon: Icons.headphones,
                            label: 'Audio',
                          ),
                        if (hasQuiz) ...[
                          const SizedBox(width: Spacing.xs),
                          const _FeatureChip(
                            icon: Icons.quiz,
                            label: 'Quiz',
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Status icon or trailing widget
              const SizedBox(width: Spacing.sm),
              trailing ?? _buildStatusIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    if (isLocked) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.lock,
          size: 16,
          color: AppColors.textHint,
        ),
      );
    }

    if (isCompleted) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          size: 18,
          color: Colors.white,
        ),
      );
    }

    return const Icon(Icons.chevron_right, color: AppColors.textHint);
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: AppColors.primary,
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
