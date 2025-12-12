import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/progress/progress_bar.dart';

/// Profile page showing user stats and settings
/// From Issue #3 - Navigation & Routing
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
              'Learning since September 2024',
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
                    value: '12',
                    label: 'Lessons\nCompleted',
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: _StatCard(
                    icon: Icons.quiz,
                    value: '8',
                    label: 'Quizzes\nPassed',
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: _StatCard(
                    icon: Icons.local_fire_department,
                    value: '5',
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
                          '30%',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    const AppProgressBar(progress: 0.30, height: 12),
                    const SizedBox(height: Spacing.sm),
                    Text(
                      '12 of 40 lessons completed',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
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
                            // TODO: Show all achievements
                          },
                          child: const Text('See All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _AchievementBadge(
                          icon: Icons.star,
                          label: 'First Lesson',
                          isUnlocked: true,
                        ),
                        _AchievementBadge(
                          icon: Icons.local_fire_department,
                          label: '3 Day Streak',
                          isUnlocked: true,
                        ),
                        _AchievementBadge(
                          icon: Icons.quiz,
                          label: 'Quiz Master',
                          isUnlocked: true,
                        ),
                        _AchievementBadge(
                          icon: Icons.emoji_events,
                          label: 'Complete 10',
                          isUnlocked: false,
                        ),
                      ],
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
                      // TODO: Show history
                    },
                  ),
                  const Divider(height: 1),
                  _ProfileMenuItem(
                    icon: Icons.emoji_events,
                    title: 'All Achievements',
                    onTap: () {
                      // TODO: Show achievements
                    },
                  ),
                  const Divider(height: 1),
                  _ProfileMenuItem(
                    icon: Icons.share,
                    title: 'Share Progress',
                    onTap: () {
                      // TODO: Share
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
  });

  final IconData icon;
  final String label;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        const SizedBox(height: Spacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color:
                    isUnlocked ? AppColors.textPrimary : AppColors.textHint,
              ),
          textAlign: TextAlign.center,
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
