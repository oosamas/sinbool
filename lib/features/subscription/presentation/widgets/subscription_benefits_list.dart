import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';

/// Widget displaying the list of premium subscription benefits
class SubscriptionBenefitsList extends StatelessWidget {
  const SubscriptionBenefitsList({
    super.key,
    this.compact = false,
  });

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final benefits = [
      _Benefit(
        icon: Icons.auto_stories,
        title: AppLocalizations.of(context)!.benefitAllStories,
        subtitle: AppLocalizations.of(context)!.benefitAllStoriesDesc,
      ),
      _Benefit(
        icon: Icons.headphones,
        title: AppLocalizations.of(context)!.benefitAudioNarration,
        subtitle: AppLocalizations.of(context)!.benefitAudioNarrationDesc,
      ),
      _Benefit(
        icon: Icons.quiz,
        title: AppLocalizations.of(context)!.benefitQuizzes,
        subtitle: AppLocalizations.of(context)!.benefitQuizzesDesc,
      ),
      _Benefit(
        icon: Icons.update,
        title: AppLocalizations.of(context)!.benefitNewContent,
        subtitle: AppLocalizations.of(context)!.benefitNewContentDesc,
      ),
      _Benefit(
        icon: Icons.download_done,
        title: AppLocalizations.of(context)!.benefitOffline,
        subtitle: AppLocalizations.of(context)!.benefitOfflineDesc,
      ),
    ];

    return Column(
      children: benefits.map((benefit) {
        return _BenefitTile(
          benefit: benefit,
          compact: compact,
        );
      }).toList(),
    );
  }
}

class _Benefit {
  const _Benefit({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}

class _BenefitTile extends StatelessWidget {
  const _BenefitTile({
    required this.benefit,
    this.compact = false,
  });

  final _Benefit benefit;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
        child: Row(
          children: [
            Icon(
              benefit.icon,
              color: AppColors.secondary,
              size: 20,
            ),
            const SizedBox(width: Spacing.sm),
            Expanded(
              child: Text(
                benefit.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              benefit.icon,
              color: AppColors.secondary,
              size: 24,
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  benefit.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: Spacing.xxs),
                Text(
                  benefit.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact version for showing in cards
class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: Spacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 14,
            color: AppColors.textOnSecondary,
          ),
          const SizedBox(width: Spacing.xxs),
          Text(
            AppLocalizations.of(context)!.premium,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textOnSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Locked content overlay shown on premium lessons
class LockedContentOverlay extends StatelessWidget {
  const LockedContentOverlay({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.black.withValues(alpha: 0.7),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock,
                  size: 40,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: Spacing.md),
              Text(
                AppLocalizations.of(context)!.premiumContent,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                AppLocalizations.of(context)!.tapToUnlock,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
