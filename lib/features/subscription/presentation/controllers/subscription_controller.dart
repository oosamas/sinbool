import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/promo_code_repository.dart';
import '../../data/repositories/subscription_repository.dart';
import '../../domain/entities/promo_code_entity.dart';
import '../../domain/entities/subscription_status.dart';

part 'subscription_controller.g.dart';

/// State for the subscription controller
class SubscriptionState {
  const SubscriptionState({
    this.status = SubscriptionStatus.free,
    this.products = const [],
    this.isLoading = false,
    this.isPurchasing = false,
    this.error,
  });

  final SubscriptionStatus status;
  final List<ProductDetails> products;
  final bool isLoading;
  final bool isPurchasing;
  final String? error;

  bool get isSubscribed => status.isActive;

  SubscriptionState copyWith({
    SubscriptionStatus? status,
    List<ProductDetails>? products,
    bool? isLoading,
    bool? isPurchasing,
    String? error,
  }) {
    return SubscriptionState(
      status: status ?? this.status,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isPurchasing: isPurchasing ?? this.isPurchasing,
      error: error,
    );
  }
}

/// Controller for managing subscription state and actions
@riverpod
class SubscriptionController extends _$SubscriptionController {
  @override
  SubscriptionState build() {
    _loadInitialState();
    return const SubscriptionState(isLoading: true);
  }

  SubscriptionRepository get _repository =>
      ref.read(subscriptionRepositoryProvider);

  PromoCodeRepository get _promoCodeRepo =>
      ref.read(promoCodeRepositoryProvider);

  /// Load initial subscription state
  Future<void> _loadInitialState() async {
    try {
      final status = await _repository.getSubscriptionStatus();
      final products = await _repository.getProducts();

      state = state.copyWith(
        status: status,
        products: products,
        isLoading: false,
        isPurchasing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isPurchasing: false,
        error: 'Failed to load subscription status',
      );
    }
  }

  /// Refresh subscription status
  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadInitialState();
  }

  /// Purchase subscription
  Future<bool> purchaseSubscription() async {
    if (state.isPurchasing) return false;

    state = state.copyWith(isPurchasing: true, error: null);

    // Listen for purchase status updates from the repository
    _repository.onPurchaseUpdate = (status, error) {
      if (status == PurchaseStatus.pending) {
        state = state.copyWith(isPurchasing: true, error: null);
      } else if (status == PurchaseStatus.error) {
        state = state.copyWith(
          isPurchasing: false,
          error: error ?? 'Purchase failed',
        );
      } else if (status == PurchaseStatus.canceled) {
        state = state.copyWith(isPurchasing: false);
      }
    };

    try {
      final success = await _repository.purchaseSubscription();

      // Clean up callback
      _repository.onPurchaseUpdate = null;

      if (success) {
        await refresh();
        return state.isSubscribed;
      } else {
        state = state.copyWith(
          isPurchasing: false,
          error: state.error ?? 'Failed to complete purchase',
        );
        return false;
      }
    } catch (e) {
      _repository.onPurchaseUpdate = null;
      state = state.copyWith(
        isPurchasing: false,
        error: 'Purchase failed: $e',
      );
      return false;
    }
  }

  /// Restore purchases
  Future<bool> restorePurchases() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final restored = await _repository.restorePurchases();
      await refresh();
      return restored || state.isSubscribed;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to restore purchases',
      );
      return false;
    }
  }

  /// Redeem a promo code
  Future<PromoCodeResult> redeemPromoCode(String code) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _promoCodeRepo.redeemPromoCode(code);

      if (result.success) {
        await refresh();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result.errorMessage,
        );
      }

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to redeem promo code',
      );
      return PromoCodeResult.failure('Failed to redeem promo code');
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
