import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/subscription_controller.dart';
import '../widgets/subscription_benefits_list.dart';

/// Paywall page shown when user tries to access premium content
class PaywallPage extends ConsumerWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(subscriptionControllerProvider);
    final controller = ref.read(subscriptionControllerProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                  child: Column(
                    children: [
                      const SizedBox(height: Spacing.md),

                      // App icon/illustration
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_stories,
                          size: 60,
                          color: AppColors.secondary,
                        ),
                      ),

                      const SizedBox(height: Spacing.xl),

                      // Headline
                      Text(
                        AppLocalizations.of(context)!.unlockAllStories,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: Spacing.sm),

                      // Subheadline
                      Text(
                        AppLocalizations.of(context)!.premiumDescription,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: Spacing.xl),

                      // Benefits list
                      const SubscriptionBenefitsList(),

                      const SizedBox(height: Spacing.xl),

                      // Price card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(Spacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.monthlySubscription,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: Spacing.xs),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$9.95',
                                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.perMonth,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Spacing.sm),
                            Text(
                              AppLocalizations.of(context)!.cancelAnytime,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: Spacing.lg),

                      // Error message
                      if (state.error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: Spacing.md),
                          child: Text(
                            state.error!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Subscribe button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isPurchasing || state.isLoading
                              ? null
                              : () => _handlePurchase(context, controller),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.textOnSecondary,
                            padding: const EdgeInsets.symmetric(vertical: Spacing.md),
                          ),
                          child: state.isPurchasing
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.textOnSecondary,
                                  ),
                                )
                              : Text(
                                  AppLocalizations.of(context)!.subscribe,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: Spacing.md),

                      // Restore purchases
                      TextButton(
                        onPressed: state.isLoading
                            ? null
                            : () => _handleRestore(context, ref),
                        child: Text(
                          AppLocalizations.of(context)!.restorePurchases,
                          style: TextStyle(
                            color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                      ),

                      // Promo code link
                      TextButton(
                        onPressed: () => context.push(AppRoutes.promoCode),
                        child: Text(
                          AppLocalizations.of(context)!.havePromoCode,
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: Spacing.md),

                      // Terms and privacy
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => context.push(AppRoutes.termsOfService),
                            child: Text(
                              AppLocalizations.of(context)!.termsOfService,
                              style: TextStyle(
                                color: AppColors.textOnPrimary.withValues(alpha: 0.7),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            ' | ',
                            style: TextStyle(
                              color: AppColors.textOnPrimary.withValues(alpha: 0.5),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.push(AppRoutes.privacyPolicy),
                            child: Text(
                              AppLocalizations.of(context)!.privacyPolicy,
                              style: TextStyle(
                                color: AppColors.textOnPrimary.withValues(alpha: 0.7),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: Spacing.lg),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePurchase(
    BuildContext context,
    SubscriptionController controller,
  ) async {
    final success = await controller.purchaseSubscription();
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.subscriptionSuccess),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    }
  }

  Future<void> _handleRestore(
    BuildContext context,
    WidgetRef ref,
  ) async {
    await ref.read(subscriptionControllerProvider.notifier).restorePurchases();
    final state = ref.read(subscriptionControllerProvider);
    if (context.mounted) {
      if (state.isSubscribed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.purchasesRestored),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.noPurchasesToRestore),
            backgroundColor: AppColors.warning,
          ),
        );
      }
    }
  }
}
