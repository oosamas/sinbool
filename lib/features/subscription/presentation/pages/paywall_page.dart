import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/database/tables/subscription_table.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/subscription_controller.dart';
import '../widgets/subscription_benefits_list.dart';

/// Paywall page shown when user tries to access premium content
class PaywallPage extends ConsumerStatefulWidget {
  const PaywallPage({super.key});

  @override
  ConsumerState<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends ConsumerState<PaywallPage> {
  String _selectedProductId = ProductIds.yearlySubscription;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subscriptionControllerProvider);
    final controller = ref.read(subscriptionControllerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

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
                        l10n.unlockAllStories,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: Spacing.sm),

                      // Subheadline
                      Text(
                        l10n.premiumDescription,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textOnPrimary.withValues(alpha: 0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: Spacing.xl),

                      // Benefits list
                      const SubscriptionBenefitsList(),

                      const SizedBox(height: Spacing.xl),

                      // Choose plan label
                      Text(
                        l10n.choosePlan,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: Spacing.md),

                      // Plan cards
                      _buildPlanCards(context, state),

                      const SizedBox(height: Spacing.sm),

                      // Cancel anytime note
                      Text(
                        l10n.cancelAnytime,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textOnPrimary.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
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
                                  l10n.subscribe,
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
                          l10n.restorePurchases,
                          style: TextStyle(
                            color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                      ),

                      // Promo code link
                      TextButton(
                        onPressed: () => context.push(AppRoutes.promoCode),
                        child: Text(
                          l10n.havePromoCode,
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
                              l10n.termsOfService,
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
                              l10n.privacyPolicy,
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

  Widget _buildPlanCards(BuildContext context, SubscriptionState state) {
    final l10n = AppLocalizations.of(context)!;
    final monthlyProduct = _findProduct(state.products, ProductIds.monthlySubscription);
    final yearlyProduct = _findProduct(state.products, ProductIds.yearlySubscription);

    final monthlyPrice = monthlyProduct?.price ?? '\$4.99';
    final yearlyPrice = yearlyProduct?.price ?? '\$49.99';

    return Row(
      children: [
        // Yearly plan (recommended)
        Expanded(
          child: _PlanCard(
            label: l10n.yearlySubscription,
            price: yearlyPrice,
            period: l10n.perYear,
            badge: l10n.bestValue,
            isSelected: _selectedProductId == ProductIds.yearlySubscription,
            onTap: () => setState(() {
              _selectedProductId = ProductIds.yearlySubscription;
            }),
          ),
        ),
        const SizedBox(width: Spacing.md),
        // Monthly plan
        Expanded(
          child: _PlanCard(
            label: l10n.monthlySubscription,
            price: monthlyPrice,
            period: l10n.perMonth,
            isSelected: _selectedProductId == ProductIds.monthlySubscription,
            onTap: () => setState(() {
              _selectedProductId = ProductIds.monthlySubscription;
            }),
          ),
        ),
      ],
    );
  }

  ProductDetails? _findProduct(List<ProductDetails> products, String productId) {
    for (final product in products) {
      if (product.id == productId) return product;
    }
    return null;
  }

  Future<void> _handlePurchase(
    BuildContext context,
    SubscriptionController controller,
  ) async {
    final success = await controller.purchaseSubscription(
      productId: _selectedProductId,
    );
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
    final restored = await ref
        .read(subscriptionControllerProvider.notifier)
        .restorePurchases();
    if (context.mounted) {
      if (restored) {
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

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.label,
    required this.price,
    required this.period,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  final String label;
  final String price;
  final String period;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surface
              : AppColors.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: isSelected ? AppColors.secondary : Colors.transparent,
            width: 2.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  badge!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textOnSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.xs),
            ] else
              const SizedBox(height: 22),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              price,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              period,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: Spacing.xs),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.secondary : AppColors.textHint,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
