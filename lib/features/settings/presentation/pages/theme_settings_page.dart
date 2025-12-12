import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Theme settings page
/// From Issue #3 - Navigation & Routing
class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  ThemeMode _selectedTheme = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Spacing.md),
        children: [
          // Theme options
          Card(
            child: Column(
              children: [
                _ThemeOption(
                  icon: Icons.brightness_auto,
                  title: 'System Default',
                  subtitle: 'Follow device settings',
                  isSelected: _selectedTheme == ThemeMode.system,
                  onTap: () => setState(() => _selectedTheme = ThemeMode.system),
                ),
                const Divider(height: 1),
                _ThemeOption(
                  icon: Icons.light_mode,
                  title: 'Light Mode',
                  subtitle: 'Always use light theme',
                  isSelected: _selectedTheme == ThemeMode.light,
                  onTap: () => setState(() => _selectedTheme = ThemeMode.light),
                ),
                const Divider(height: 1),
                _ThemeOption(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Always use dark theme',
                  isSelected: _selectedTheme == ThemeMode.dark,
                  onTap: () => setState(() => _selectedTheme = ThemeMode.dark),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Preview section
          Text(
            'Preview',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: Spacing.md),

          // Theme preview cards
          Row(
            children: [
              Expanded(
                child: _ThemePreviewCard(
                  title: 'Light',
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                  accentColor: AppColors.primary,
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: _ThemePreviewCard(
                  title: 'Dark',
                  backgroundColor: const Color(0xFF1E1E1E),
                  textColor: Colors.white,
                  accentColor: AppColors.primaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(Radius.md),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.textSecondary),
      ),
      trailing:
          isSelected ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
      onTap: onTap,
    );
  }
}

class _ThemePreviewCard extends StatelessWidget {
  const _ThemePreviewCard({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.accentColor,
  });

  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Radius.lg),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      padding: const EdgeInsets.all(Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            height: 24,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(Radius.sm),
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Content preview
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: textColor.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: Spacing.sm),
          Container(
            height: 12,
            width: 100,
            decoration: BoxDecoration(
              color: textColor.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Spacer(),

          // Label
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
