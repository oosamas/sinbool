import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/daos/subscription_dao.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/database/tables/subscription_table.dart';
import '../../domain/entities/subscription_status.dart';

part 'subscription_repository.g.dart';

/// Repository for managing in-app subscriptions
class SubscriptionRepository {
  SubscriptionRepository(this._dao, this._iap);

  final SubscriptionDao _dao;
  final InAppPurchase _iap;

  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  /// Product ID for monthly subscription
  static const String monthlyProductId = ProductIds.monthlySubscription;

  /// Initialize the repository and start listening to purchases
  Future<void> initialize() async {
    final available = await _iap.isAvailable();
    if (!available) return;

    _purchaseSubscription = _iap.purchaseStream.listen(
      _handlePurchaseUpdate,
      onError: (error) {
        // Log error but don't crash
      },
    );
  }

  /// Dispose resources
  void dispose() {
    _purchaseSubscription?.cancel();
  }

  /// Get current subscription status
  Future<SubscriptionStatus> getSubscriptionStatus() async {
    // Check for active store subscription
    final subscription = await _dao.getActiveSubscription();
    if (subscription != null) {
      final isExpired = subscription.expiryDate != null &&
          subscription.expiryDate!.isBefore(DateTime.now());

      if (!isExpired) {
        return SubscriptionStatus(
          isActive: true,
          type: SubscriptionType.monthly,
          expiryDate: subscription.expiryDate,
        );
      }
    }

    // Check for active promo code
    final promoCode = await _dao.getActivePromoCode();
    if (promoCode != null) {
      return SubscriptionStatus(
        isActive: true,
        type: SubscriptionType.promoCode,
        expiryDate: promoCode.expiryDate,
        promoCode: promoCode.code,
      );
    }

    return SubscriptionStatus.free;
  }

  /// Watch subscription status changes
  Stream<SubscriptionStatus> watchSubscriptionStatus() {
    return _dao.watchHasActiveAccess().asyncMap((_) => getSubscriptionStatus());
  }

  /// Check if user has premium access
  Future<bool> hasAccess() async {
    return _dao.hasActiveAccess();
  }

  /// Get available products
  Future<List<ProductDetails>> getProducts() async {
    final available = await _iap.isAvailable();
    if (!available) return [];

    final response = await _iap.queryProductDetails({monthlyProductId});
    if (response.error != null) {
      return [];
    }

    return response.productDetails;
  }

  /// Purchase subscription
  Future<bool> purchaseSubscription() async {
    final products = await getProducts();
    if (products.isEmpty) return false;

    final product = products.first;
    final purchaseParam = PurchaseParam(productDetails: product);

    return _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  /// Handle purchase updates from the store
  Future<void> _handlePurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        // Verify and save the purchase
        await _verifyAndSavePurchase(purchase);
      }

      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }

  /// Verify and save a purchase
  Future<void> _verifyAndSavePurchase(PurchaseDetails purchase) async {
    // In a production app, you should verify the purchase with your server
    // For now, we'll save it locally

    final platform = Platform.isIOS ? 'ios' : 'android';
    final existingPurchase = await _dao.getSubscriptionByToken(
      purchase.purchaseID ?? '',
    );

    if (existingPurchase == null) {
      // Calculate expiry date (1 month from purchase)
      final expiryDate = DateTime.now().add(const Duration(days: 30));

      await _dao.saveSubscription(
        purchaseToken: purchase.purchaseID ?? DateTime.now().toIso8601String(),
        productId: purchase.productID,
        platform: platform,
        purchaseDate: DateTime.now(),
        expiryDate: expiryDate,
      );
    }
  }

  /// Activate a promo code (call after server validation)
  Future<void> activatePromoCode({
    required String code,
    required DateTime expiryDate,
  }) async {
    await _dao.savePromoCode(
      code: code,
      expiryDate: expiryDate,
    );
  }

  /// Deactivate promo code
  Future<void> deactivatePromoCode(String code) async {
    await _dao.deactivatePromoCode(code);
  }
}

/// In-App Purchase instance provider
@Riverpod(keepAlive: true)
InAppPurchase inAppPurchase(InAppPurchaseRef ref) {
  return InAppPurchase.instance;
}

/// Subscription repository provider
@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(SubscriptionRepositoryRef ref) {
  final dao = ref.watch(subscriptionDaoProvider);
  final iap = ref.watch(inAppPurchaseProvider);
  final repo = SubscriptionRepository(dao, iap);

  // Initialize on creation
  repo.initialize();

  // Dispose on ref disposal
  ref.onDispose(() => repo.dispose());

  return repo;
}

/// Subscription status provider
@riverpod
Future<SubscriptionStatus> subscriptionStatus(SubscriptionStatusRef ref) {
  final repo = ref.watch(subscriptionRepositoryProvider);
  return repo.getSubscriptionStatus();
}

/// Subscription status stream provider
@riverpod
Stream<SubscriptionStatus> subscriptionStatusStream(SubscriptionStatusStreamRef ref) {
  final repo = ref.watch(subscriptionRepositoryProvider);
  return repo.watchSubscriptionStatus();
}

/// Is subscribed provider - simple boolean check
@riverpod
Future<bool> isSubscribed(IsSubscribedRef ref) async {
  final status = await ref.watch(subscriptionStatusProvider.future);
  return status.isActive;
}

/// Available products provider
@riverpod
Future<List<ProductDetails>> availableProducts(AvailableProductsRef ref) {
  final repo = ref.watch(subscriptionRepositoryProvider);
  return repo.getProducts();
}
