import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';

/// Settings page
/// From Issue #3 - Navigation & Routing
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: Spacing.md),

          // App Settings section
          _SectionHeader(title: 'App Settings'),
          _SettingsItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English',
            onTap: () => context.push(AppRoutes.languageSettings),
          ),
          _SettingsItem(
            icon: Icons.palette,
            title: 'Theme',
            subtitle: 'System default',
            onTap: () => context.push(AppRoutes.themeSettings),
          ),
          _SettingsItem(
            icon: Icons.text_fields,
            title: 'Text Size',
            subtitle: 'Medium',
            onTap: () {
              // TODO: Text size settings
            },
          ),
          _SettingsItem(
            icon: Icons.volume_up,
            title: 'Audio Settings',
            subtitle: 'Auto-play enabled',
            onTap: () {
              // TODO: Audio settings
            },
          ),

          const SizedBox(height: Spacing.lg),

          // Parental Controls section
          _SectionHeader(title: 'Parental Controls'),
          _SettingsItem(
            icon: Icons.lock,
            title: 'Parental Controls',
            subtitle: 'Manage access and time limits',
            onTap: () => context.push(AppRoutes.parentalControls),
          ),

          const SizedBox(height: Spacing.lg),

          // Data section
          _SectionHeader(title: 'Data'),
          _SettingsItem(
            icon: Icons.download,
            title: 'Downloads',
            subtitle: 'Manage offline content',
            onTap: () {
              // TODO: Downloads management
            },
          ),
          _SettingsItem(
            icon: Icons.delete_outline,
            title: 'Clear Cache',
            subtitle: '45 MB used',
            onTap: () {
              // TODO: Clear cache
            },
          ),

          const SizedBox(height: Spacing.lg),

          // About section
          _SectionHeader(title: 'About'),
          _SettingsItem(
            icon: Icons.info_outline,
            title: 'About Sinbool',
            onTap: () => context.push(AppRoutes.about),
          ),
          _SettingsItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () => context.push(AppRoutes.privacyPolicy),
          ),
          _SettingsItem(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => context.push(AppRoutes.termsOfService),
          ),
          _SettingsItem(
            icon: Icons.star_outline,
            title: 'Rate the App',
            onTap: () {
              // TODO: Open app store
            },
          ),
          _SettingsItem(
            icon: Icons.feedback_outlined,
            title: 'Send Feedback',
            onTap: () {
              // TODO: Feedback form
            },
          ),

          const SizedBox(height: Spacing.lg),

          // Version info
          Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: Text(
              'Sinbool v1.0.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
              textAlign: TextAlign.center,
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
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.lg,
        vertical: Spacing.sm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Radius.md),
        ),
        child: Icon(icon, color: AppColors.primary, size: 22),
      ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
      onTap: onTap,
    );
  }
}
