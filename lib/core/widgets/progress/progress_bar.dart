import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';

/// Linear progress bar for lesson/chapter progress
/// From Issue #2 - Design System
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    required this.progress,
    super.key,
    this.height = 8,
    this.backgroundColor,
    this.progressColor,
    this.showPercentage = false,
    this.label,
  });

  /// Progress value between 0.0 and 1.0
  final double progress;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final bool showPercentage;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.surfaceVariant;
    final fgColor = progressColor ?? AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showPercentage)
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                if (showPercentage)
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: fgColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: bgColor,
            valueColor: AlwaysStoppedAnimation<Color>(fgColor),
            minHeight: height,
          ),
        ),
      ],
    );
  }
}

/// Circular progress indicator for achievements/stats
class CircularProgress extends StatelessWidget {
  const CircularProgress({
    required this.progress,
    super.key,
    this.size = 80,
    this.strokeWidth = 8,
    this.backgroundColor,
    this.progressColor,
    this.child,
  });

  final double progress;
  final double size;
  final double strokeWidth;
  final Color? backgroundColor;
  final Color? progressColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.surfaceVariant;
    final fgColor = progressColor ?? AppColors.primary;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: bgColor,
              valueColor: AlwaysStoppedAnimation<Color>(fgColor),
              strokeWidth: strokeWidth,
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

/// Progress bar with steps (for multi-step flows)
class StepProgressBar extends StatelessWidget {
  const StepProgressBar({
    required this.totalSteps,
    required this.currentStep,
    super.key,
    this.activeColor,
    this.inactiveColor,
  });

  final int totalSteps;
  final int currentStep;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final active = activeColor ?? AppColors.primary;
    final inactive = inactiveColor ?? AppColors.surfaceVariant;

    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index < currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index < totalSteps - 1 ? Spacing.xs : 0,
            ),
            height: 4,
            decoration: BoxDecoration(
              color: isActive || isCurrent ? active : inactive,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}

/// Lesson completion stats display
class LessonStats extends StatelessWidget {
  const LessonStats({
    required this.completedLessons,
    required this.totalLessons,
    super.key,
    this.streakDays = 0,
  });

  final int completedLessons;
  final int totalLessons;
  final int streakDays;

  @override
  Widget build(BuildContext context) {
    final progress =
        totalLessons > 0 ? completedLessons / totalLessons : 0.0;

    return Row(
      children: [
        Expanded(
          child: _StatItem(
            icon: Icons.menu_book,
            value: '$completedLessons/$totalLessons',
            label: 'Lessons',
          ),
        ),
        const SizedBox(width: Spacing.md),
        Expanded(
          child: _StatItem(
            icon: Icons.local_fire_department,
            value: '$streakDays',
            label: 'Day Streak',
            valueColor: streakDays > 0 ? AppColors.secondary : null,
          ),
        ),
        const SizedBox(width: Spacing.md),
        Expanded(
          child: CircularProgress(
            progress: progress,
            size: 56,
            strokeWidth: 6,
            child: Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    this.valueColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: IconSizes.md,
          color: valueColor ?? AppColors.primary,
        ),
        const SizedBox(height: Spacing.xs),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
