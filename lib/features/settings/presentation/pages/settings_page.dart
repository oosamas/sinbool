import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../subscription/data/repositories/subscription_repository.dart';
import '../../../subscription/domain/entities/subscription_status.dart';
import '../../domain/entities/settings_entity.dart';
import '../controllers/settings_controller.dart';

/// Settings page
/// From Issue #3 - Navigation & Routing
/// Updated in Issue #9 - Parental Controls & Settings
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final settings = settingsState.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: settingsState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: Spacing.md),

                // App Settings section
                const _SectionHeader(title: 'App Settings'),
                _SettingsItem(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: settings.languageDisplayName,
                  onTap: () => context.push(AppRoutes.languageSettings),
                ),
                _SettingsItem(
                  icon: Icons.palette,
                  title: 'Theme',
                  subtitle: settings.themeModeDisplayName,
                  onTap: () => context.push(AppRoutes.themeSettings),
                ),
                _SettingsItem(
                  icon: Icons.text_fields,
                  title: 'Text Size',
                  subtitle: settings.fontSizeDisplayName,
                  onTap: () => _showFontSizeDialog(context, ref),
                ),
                _SettingsItem(
                  icon: Icons.volume_up,
                  title: 'Audio Settings',
                  subtitle: settings.audioAutoPlay ? 'Auto-play enabled' : 'Auto-play disabled',
                  onTap: () => _showAudioSettingsDialog(context, ref),
                ),

                const SizedBox(height: Spacing.lg),

                // Subscription section
                _SectionHeader(title: AppLocalizations.of(context)!.subscription),
                _SubscriptionSection(),

                const SizedBox(height: Spacing.lg),

                // Parental Controls section
                const _SectionHeader(title: 'Parental Controls'),
                _SettingsItem(
                  icon: Icons.lock,
                  title: 'Parental Controls',
                  subtitle: settings.parentalPinEnabled
                      ? 'PIN enabled'
                      : 'Manage access and time limits',
                  onTap: () => context.push(AppRoutes.parentalControls),
                ),

                const SizedBox(height: Spacing.lg),

                // Data section
                const _SectionHeader(title: 'Data'),
                _SettingsItem(
                  icon: Icons.download,
                  title: 'Downloads',
                  subtitle: 'Manage offline content',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Downloads management coming soon!')),
                    );
                  },
                ),
                _SettingsItem(
                  icon: Icons.delete_outline,
                  title: 'Clear Cache',
                  subtitle: 'Free up storage space',
                  onTap: () => _showClearCacheDialog(context),
                ),

                const SizedBox(height: Spacing.lg),

                // About section
                const _SectionHeader(title: 'About'),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Opening app store...')),
                    );
                  },
                ),
                _SettingsItem(
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Feedback form coming soon!')),
                    );
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

  void _showFontSizeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _FontSizeDialog(),
    );
  }

  void _showAudioSettingsDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _AudioSettingsDialog(),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache?'),
        content: const Text(
          'This will remove temporary files to free up storage space. '
          'Your progress and bookmarks will be preserved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully!')),
              );
            },
            child: const Text('Clear'),
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
          borderRadius: BorderRadius.circular(AppRadius.md),
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

class _FontSizeDialog extends ConsumerWidget {
  const _FontSizeDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final currentSize = settingsState.settings.fontSize;

    return AlertDialog(
      title: const Text('Text Size'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FontSizeOption(
            label: 'Small',
            size: FontSize.small,
            isSelected: currentSize == FontSize.small,
            onTap: () {
              ref.read(settingsControllerProvider.notifier).setFontSize(FontSize.small);
              Navigator.of(context).pop();
            },
          ),
          _FontSizeOption(
            label: 'Medium',
            size: FontSize.medium,
            isSelected: currentSize == FontSize.medium,
            onTap: () {
              ref.read(settingsControllerProvider.notifier).setFontSize(FontSize.medium);
              Navigator.of(context).pop();
            },
          ),
          _FontSizeOption(
            label: 'Large',
            size: FontSize.large,
            isSelected: currentSize == FontSize.large,
            onTap: () {
              ref.read(settingsControllerProvider.notifier).setFontSize(FontSize.large);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _FontSizeOption extends StatelessWidget {
  const _FontSizeOption({
    required this.label,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final FontSize size;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontSize: size == FontSize.small ? 14 : size == FontSize.large ? 18 : 16,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: onTap,
    );
  }
}

class _AudioSettingsDialog extends ConsumerWidget {
  const _AudioSettingsDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final settings = settingsState.settings;

    return AlertDialog(
      title: const Text('Audio Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: const Text('Auto-play audio'),
            subtitle: const Text('Play audio automatically when available'),
            value: settings.audioAutoPlay,
            onChanged: (value) {
              ref.read(settingsControllerProvider.notifier).setAudioAutoPlay(value);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Done'),
        ),
      ],
    );
  }
}

class _SubscriptionSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionAsync = ref.watch(subscriptionStatusProvider);

    return subscriptionAsync.when(
      loading: () => const ListTile(
        leading: SizedBox(
          width: 40,
          height: 40,
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        title: Text('Loading...'),
      ),
      error: (error, stack) => _SettingsItem(
        icon: Icons.star,
        title: AppLocalizations.of(context)!.upgradeToPremium,
        subtitle: AppLocalizations.of(context)!.freeUser,
        onTap: () => context.push(AppRoutes.paywall),
      ),
      data: (status) {
        if (status.isActive) {
          // Show active subscription info
          return Column(
            children: [
              _SubscriptionStatusTile(status: status),
              _SettingsItem(
                icon: Icons.card_giftcard,
                title: AppLocalizations.of(context)!.redeemPromoCode,
                subtitle: 'Have another code?',
                onTap: () => context.push(AppRoutes.promoCode),
              ),
            ],
          );
        } else {
          // Show upgrade options
          return Column(
            children: [
              _SettingsItem(
                icon: Icons.star,
                title: AppLocalizations.of(context)!.upgradeToPremium,
                subtitle: AppLocalizations.of(context)!.freeUser,
                onTap: () => context.push(AppRoutes.paywall),
              ),
              _SettingsItem(
                icon: Icons.card_giftcard,
                title: AppLocalizations.of(context)!.redeemPromoCode,
                onTap: () => context.push(AppRoutes.promoCode),
              ),
            ],
          );
        }
      },
    );
  }
}

class _SubscriptionStatusTile extends StatelessWidget {
  const _SubscriptionStatusTile({required this.status});

  final SubscriptionStatus status;

  @override
  Widget build(BuildContext context) {
    String subtitle;
    if (status.expiryDate != null) {
      final dateStr = DateFormat.yMMMd().format(status.expiryDate!);
      subtitle = AppLocalizations.of(context)!.subscriptionExpires(dateStr);
    } else {
      subtitle = status.type == SubscriptionType.promoCode
          ? 'Via promo code: ${status.promoCode}'
          : AppLocalizations.of(context)!.subscriptionActive;
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star,
              color: AppColors.secondary,
              size: 28,
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.subscriptionActive,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Spacing.xxs),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: AppColors.secondary,
            size: 28,
          ),
        ],
      ),
    );
  }
}
