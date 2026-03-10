import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/daos/subscription_dao.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/database/tables/subscription_table.dart';
import '../../../../core/services/error_handler_service.dart';
import '../../domain/entities/subscription_status.dart';

part 'subscription_repository.g.dart';

/// Callback type for purchase status updates
typedef PurchaseUpdateCallback = void Function(PurchaseStatus status, String? error);

/// Repository for managing in-app subscriptions
class SubscriptionRepository {
  SubscriptionRepository(this._dao, this._iap);

  final SubscriptionDao _dao;
  final InAppPurchase _iap;

  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  /// Completer used to signal when a purchase or restore flow finishes
  Completer<bool>? _purchaseCompleter;

  /// Optional callback for notifying controllers of purchase updates
  PurchaseUpdateCallback? onPurchaseUpdate;

  /// Product ID for monthly subscription
  static const String monthlyProductId = ProductIds.monthlySubscription;

  /// Initialize the repository and start listening to purchases
  Future<void> initialize() async {
    final available = await _iap.isAvailable();
    if (!available) return;

    _purchaseSubscription = _iap.purchaseStream.listen(
      _handlePurchaseUpdate,
      onError: (error) {
        ErrorHandlerService.instance.error(
          'Purchase stream error',
          error,
        );
        _purchaseCompleter?.complete(false);
        _purchaseCompleter = null;
      },
    );
  }

  /// Dispose resources
  void dispose() {
    _purchaseSubscription?.cancel();
    _purchaseCompleter = null;
  }

  /// Get current subscription status, also deactivates expired records
  Future<SubscriptionStatus> getSubscriptionStatus() async {
    // Clean up expired subscriptions in the database
    await _dao.deactivateExpiredSubscriptions();
    await _dao.deactivateExpiredPromoCodes();

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
      ErrorHandlerService.instance.warning(
        'Failed to query products',
        response.error!.message,
      );
      return [];
    }

    return response.productDetails;
  }

  /// Purchase subscription - returns true if purchase succeeds
  Future<bool> purchaseSubscription() async {
    final products = await getProducts();
    if (products.isEmpty) return false;

    final product = products.first;
    final purchaseParam = PurchaseParam(productDetails: product);

    // Set up completer to wait for the purchase stream result
    _purchaseCompleter = Completer<bool>();

    final initiated = await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    if (!initiated) {
      _purchaseCompleter = null;
      return false;
    }

    // Wait for the purchase stream to resolve (with a timeout)
    try {
      return await _purchaseCompleter!.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          _purchaseCompleter = null;
          return false;
        },
      );
    } catch (_) {
      _purchaseCompleter = null;
      return false;
    }
  }

  /// Restore purchases - returns true if any purchases were restored
  Future<bool> restorePurchases() async {
    _purchaseCompleter = Completer<bool>();

    await _iap.restorePurchases();

    // Wait for restore to complete through the purchase stream
    try {
      return await _purchaseCompleter!.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _purchaseCompleter = null;
          return false;
        },
      );
    } catch (_) {
      _purchaseCompleter = null;
      return false;
    }
  }

  /// Handle purchase updates from the store
  Future<void> _handlePurchaseUpdate(List<PurchaseDetails> purchases) async {
    var anySuccessful = false;

    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _verifyAndSavePurchase(purchase);
          anySuccessful = true;
          onPurchaseUpdate?.call(purchase.status, null);
          break;

        case PurchaseStatus.pending:
          onPurchaseUpdate?.call(PurchaseStatus.pending, null);
          break;

        case PurchaseStatus.error:
          final errorMessage = purchase.error?.message ?? 'Purchase failed';
          ErrorHandlerService.instance.error('Purchase error', errorMessage);
          onPurchaseUpdate?.call(PurchaseStatus.error, errorMessage);
          break;

        case PurchaseStatus.canceled:
          onPurchaseUpdate?.call(PurchaseStatus.canceled, null);
          break;
      }

      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }

    // Resolve the completer if one is waiting
    if (_purchaseCompleter != null && !_purchaseCompleter!.isCompleted) {
      _purchaseCompleter!.complete(anySuccessful);
      _purchaseCompleter = null;
    }
  }

  /// Verify and save a purchase
  Future<void> _verifyAndSavePurchase(PurchaseDetails purchase) async {
    // Validate purchase ID exists
    final purchaseId = purchase.purchaseID;
    if (purchaseId == null || purchaseId.isEmpty) {
      ErrorHandlerService.instance.warning(
        'Purchase has no ID',
        'Product: ${purchase.productID}',
      );
      return;
    }

    final platform = Platform.isIOS ? 'ios' : 'android';
    final existingPurchase = await _dao.getSubscriptionByToken(purchaseId);

    if (existingPurchase == null) {
      // Parse the transaction date from the purchase if available,
      // otherwise use current time
      final purchaseDate = purchase.transactionDate != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.tryParse(purchase.transactionDate!) ?? DateTime.now().millisecondsSinceEpoch,
            )
          : DateTime.now();

      // For auto-renewable subscriptions, the store manages renewal.
      // We store a 30-day window locally and refresh on each app launch.
      // Server-side receipt validation should be added for production.
      final expiryDate = purchaseDate.add(const Duration(days: 30));

      await _dao.saveSubscription(
        purchaseToken: purchaseId,
        productId: purchase.productID,
        platform: platform,
        purchaseDate: purchaseDate,
        expiryDate: expiryDate,
      );
    } else {
      // Existing purchase found - renew its expiry (handles re-subscribe / restore)
      final newExpiry = DateTime.now().add(const Duration(days: 30));
      await _dao.updateSubscriptionExpiry(purchaseId, newExpiry);
      // Ensure it's marked active
      await _dao.reactivateSubscription(purchaseId);
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
