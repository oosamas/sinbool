import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../progress/presentation/controllers/progress_controller.dart';
import '../controllers/settings_controller.dart';

/// Parental controls page
/// From Issue #3 - Navigation & Routing
/// Updated in Issue #9 - Parental Controls & Settings
class ParentalControlsPage extends ConsumerWidget {
  const ParentalControlsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final settings = settingsState.settings;
    final progressState = ref.watch(progressControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parental Controls'),
      ),
      body: settingsState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(Spacing.md),
              children: [
                // Info card
                Card(
                  color: AppColors.info.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.md),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.info),
                        const SizedBox(width: Spacing.md),
                        Expanded(
                          child: Text(
                            'These controls help you manage your child\'s app usage '
                            'and keep them safe.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.lg),

                // PIN Protection
                _ControlSection(
                  title: 'PIN Protection',
                  description: 'Require PIN to access parental controls and settings',
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Enable PIN'),
                        value: settings.parentalPinEnabled,
                        onChanged: (value) {
                          if (value) {
                            // Navigate to set PIN
                            context.push(AppRoutes.parentalPin);
                          } else {
                            // Show confirmation to disable
                            _showDisablePinDialog(context, ref);
                          }
                        },
                      ),
                      if (settings.parentalPinEnabled)
                        ListTile(
                          title: const Text('Change PIN'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push(AppRoutes.parentalPin),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.md),

                // Time Limits
                _ControlSection(
                  title: 'Time Limits',
                  description: 'Set daily usage limits for the app',
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Enable Time Limits'),
                        value: settings.timeLimitEnabled,
                        onChanged: (value) {
                          ref
                              .read(settingsControllerProvider.notifier)
                              .setTimeLimitEnabled(value);
                        },
                      ),
                      if (settings.timeLimitEnabled) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Daily limit: ${settings.dailyTimeLimitMinutes} minutes',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Slider(
                                value: settings.dailyTimeLimitMinutes.toDouble(),
                                min: 15,
                                max: 120,
                                divisions: 7,
                                label: '${settings.dailyTimeLimitMinutes} min',
                                onChanged: (value) {
                                  ref
                                      .read(settingsControllerProvider.notifier)
                                      .setDailyTimeLimit(value.round());
                                },
                              ),
                              const SizedBox(height: Spacing.sm),
                              Text(
                                _getTimeLimitDescription(settings.dailyTimeLimitMinutes),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Spacing.md),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.md),

                // Content Restrictions
                _ControlSection(
                  title: 'Content Restrictions',
                  description: 'Manage which content is accessible',
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Allow Premium Content'),
                        subtitle: const Text('If you have a subscription'),
                        value: settings.allowPremiumContent,
                        onChanged: (value) {
                          ref
                              .read(settingsControllerProvider.notifier)
                              .setAllowPremiumContent(value);
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Allow Audio Playback'),
                        value: settings.allowAudioPlayback,
                        onChanged: (value) {
                          ref
                              .read(settingsControllerProvider.notifier)
                              .setAllowAudioPlayback(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.md),

                // Usage Statistics
                _ControlSection(
                  title: 'Usage Statistics',
                  description: 'View your child\'s learning progress',
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Lessons Completed'),
                        trailing: Text(
                          '${progressState.userProgress.totalLessonsCompleted}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Quizzes Passed'),
                        trailing: Text(
                          '${progressState.userProgress.totalQuizzesPassed}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Time Learning'),
                        trailing: Text(
                          progressState.userProgress.formattedTimeSpent,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.info,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Current Streak'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${progressState.userProgress.currentStreak}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.warning,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.local_fire_department,
                              color: AppColors.warning,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.xl),
              ],
            ),
    );
  }

  String _getTimeLimitDescription(int minutes) {
    if (minutes <= 15) {
      return 'Very short - Best for younger children';
    } else if (minutes <= 30) {
      return 'Short - Good for focused learning sessions';
    } else if (minutes <= 60) {
      return 'Moderate - Balanced screen time';
    } else {
      return 'Extended - For older children';
    }
  }

  void _showDisablePinDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disable PIN?'),
        content: const Text(
          'This will allow anyone to access parental controls without a PIN. '
          'Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(settingsControllerProvider.notifier).removeParentalPin();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Disable'),
          ),
        ],
      ),
    );
  }
}

class _ControlSection extends StatelessWidget {
  const _ControlSection({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
