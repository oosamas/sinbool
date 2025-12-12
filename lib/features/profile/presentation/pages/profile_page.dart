import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/progress/progress_bar.dart';
import '../../../progress/domain/entities/achievement_entity.dart';
import '../../../progress/presentation/controllers/progress_controller.dart';

/// Profile page showing user stats and settings
/// From Issue #3 - Navigation & Routing
/// Updated in Issue #7 - User Progress & Analytics
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: progressState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Column(
                children: [
                  // Profile avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: Spacing.md),

                  // User name
                  Text(
                    'Little Learner',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: Spacing.xs),
                  Text(
                    _getActivityText(progressState.userProgress.lastActivityDate),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: Spacing.xl),

                  // Stats cards
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.menu_book,
                          value: '${progressState.userProgress.totalLessonsCompleted}',
                          label: 'Lessons\nCompleted',
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: Spacing.md),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.quiz,
                          value: '${progressState.userProgress.totalQuizzesPassed}',
                          label: 'Quizzes\nPassed',
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: Spacing.md),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.local_fire_department,
                          value: '${progressState.userProgress.currentStreak}',
                          label: 'Day\nStreak',
                          color: AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.xl),

                  // Progress section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Overall Progress',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '${(progressState.overallProgress * 100).toInt()}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Spacing.md),
                          AppProgressBar(
                            progress: progressState.overallProgress,
                            height: 12,
                          ),
                          const SizedBox(height: Spacing.sm),
                          Text(
                            '${progressState.userProgress.totalLessonsCompleted} of ${progressState.totalLessons} lessons completed',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.lg),

                  // Time spent section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.md),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.info.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.timer,
                              color: AppColors.info,
                            ),
                          ),
                          const SizedBox(width: Spacing.md),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time Learning',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                              Text(
                                progressState.userProgress.formattedTimeSpent,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Best Streak',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                              Text(
                                '${progressState.userProgress.longestStreak} days',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.warning,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.lg),

                  // Achievements
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Achievements',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextButton(
                                onPressed: () {
                                  _showAllAchievements(context, progressState.achievements);
                                },
                                child: Text(
                                  '${progressState.unlockedAchievementsCount}/${progressState.achievements.length}',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Spacing.md),
                          if (progressState.achievements.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(Spacing.lg),
                                child: Text('Start learning to earn achievements!'),
                              ),
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: progressState.achievements.take(4).map((achievement) {
                                return _AchievementBadge(
                                  icon: achievement.icon,
                                  label: achievement.title,
                                  isUnlocked: achievement.isUnlocked,
                                  progress: achievement.progressPercentage,
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.lg),

                  // Quick actions
                  Card(
                    child: Column(
                      children: [
                        _ProfileMenuItem(
                          icon: Icons.history,
                          title: 'Learning History',
                          onTap: () {
                            _showLearningHistory(context);
                          },
                        ),
                        const Divider(height: 1),
                        _ProfileMenuItem(
                          icon: Icons.emoji_events,
                          title: 'All Achievements',
                          onTap: () {
                            _showAllAchievements(context, progressState.achievements);
                          },
                        ),
                        const Divider(height: 1),
                        _ProfileMenuItem(
                          icon: Icons.share,
                          title: 'Share Progress',
                          onTap: () {
                            _shareProgress(context, progressState);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.xl),
                ],
              ),
            ),
    );
  }

  String _getActivityText(DateTime? lastActivity) {
    if (lastActivity == null) return 'Start your learning journey!';
    final now = DateTime.now();
    final difference = now.difference(lastActivity).inDays;
    if (difference == 0) return 'Active today';
    if (difference == 1) return 'Last active yesterday';
    return 'Last active $difference days ago';
  }

  void _showAllAchievements(BuildContext context, List<AchievementEntity> achievements) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _AchievementsSheet(
          achievements: achievements,
          scrollController: scrollController,
        ),
      ),
    );
  }

  void _showLearningHistory(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Learning history coming soon!')),
    );
  }

  void _shareProgress(BuildContext context, ProgressState state) {
    final text = 'I have completed ${state.userProgress.totalLessonsCompleted} lessons '
        'and passed ${state.userProgress.totalQuizzesPassed} quizzes on Sinbool! '
        '🌟 Current streak: ${state.userProgress.currentStreak} days!';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share: $text')),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: Spacing.sm),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  const _AchievementBadge({
    required this.icon,
    required this.label,
    required this.isUnlocked,
    this.progress = 0.0,
  });

  final IconData icon;
  final String label;
  final bool isUnlocked;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (!isUnlocked && progress > 0)
              SizedBox(
                width: 52,
                height: 52,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                  backgroundColor: AppColors.surfaceVariant,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
                ),
              ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isUnlocked
                    ? AppColors.secondary.withValues(alpha: 0.15)
                    : AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isUnlocked ? AppColors.secondary : AppColors.textHint,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.xs),
        SizedBox(
          width: 64,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isUnlocked ? AppColors.textPrimary : AppColors.textHint,
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
      onTap: onTap,
    );
  }
}

class _AchievementsSheet extends StatelessWidget {
  const _AchievementsSheet({
    required this.achievements,
    required this.scrollController,
  });

  final List<AchievementEntity> achievements;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final unlocked = achievements.where((a) => a.isUnlocked).toList();
    final locked = achievements.where((a) => !a.isUnlocked).toList();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: Spacing.sm),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Row(
              children: [
                Text(
                  'Achievements',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.sm,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(Radius.sm),
                  ),
                  child: Text(
                    '${unlocked.length}/${achievements.length}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
              children: [
                if (unlocked.isNotEmpty) ...[
                  _SectionHeader(title: 'Unlocked (${unlocked.length})'),
                  ...unlocked.map((a) => _AchievementListTile(achievement: a)),
                  const SizedBox(height: Spacing.lg),
                ],
                if (locked.isNotEmpty) ...[
                  _SectionHeader(title: 'Locked (${locked.length})'),
                  ...locked.map((a) => _AchievementListTile(achievement: a)),
                ],
                const SizedBox(height: Spacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
    );
  }
}

class _AchievementListTile extends StatelessWidget {
  const _AchievementListTile({required this.achievement});

  final AchievementEntity achievement;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: Spacing.sm),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: achievement.isUnlocked
                ? AppColors.secondary.withValues(alpha: 0.15)
                : AppColors.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: Icon(
            achievement.icon,
            color: achievement.isUnlocked ? AppColors.secondary : AppColors.textHint,
          ),
        ),
        title: Text(
          achievement.title,
          style: TextStyle(
            color: achievement.isUnlocked ? null : AppColors.textHint,
          ),
        ),
        subtitle: Text(
          achievement.description,
          style: TextStyle(
            color: achievement.isUnlocked ? AppColors.textSecondary : AppColors.textHint,
          ),
        ),
        trailing: achievement.isUnlocked
            ? const Icon(Icons.check_circle, color: AppColors.success)
            : Text(
                '${achievement.progress}/${achievement.requirement}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textHint,
                    ),
              ),
      ),
    );
  }
}
