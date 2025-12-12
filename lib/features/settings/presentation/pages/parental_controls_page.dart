import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';

/// Parental controls page
/// From Issue #3 - Navigation & Routing
class ParentalControlsPage extends StatefulWidget {
  const ParentalControlsPage({super.key});

  @override
  State<ParentalControlsPage> createState() => _ParentalControlsPageState();
}

class _ParentalControlsPageState extends State<ParentalControlsPage> {
  bool _pinEnabled = true;
  bool _timeLimitsEnabled = false;
  int _dailyLimit = 30; // minutes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parental Controls'),
      ),
      body: ListView(
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
                  value: _pinEnabled,
                  onChanged: (value) {
                    setState(() => _pinEnabled = value);
                  },
                ),
                if (_pinEnabled)
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
                  value: _timeLimitsEnabled,
                  onChanged: (value) {
                    setState(() => _timeLimitsEnabled = value);
                  },
                ),
                if (_timeLimitsEnabled) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily limit: $_dailyLimit minutes',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Slider(
                          value: _dailyLimit.toDouble(),
                          min: 15,
                          max: 120,
                          divisions: 7,
                          label: '$_dailyLimit min',
                          onChanged: (value) {
                            setState(() => _dailyLimit = value.round());
                          },
                        ),
                      ],
                    ),
                  ),
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
                  value: true,
                  onChanged: (value) {
                    // TODO: Implement
                  },
                ),
                SwitchListTile(
                  title: const Text('Allow Audio Playback'),
                  value: true,
                  onChanged: (value) {
                    // TODO: Implement
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
            child: ListTile(
              title: const Text('View Statistics'),
              subtitle: const Text('Lessons completed, time spent, etc.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to statistics
              },
            ),
          ),
          const SizedBox(height: Spacing.xl),
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
