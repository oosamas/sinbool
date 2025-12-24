import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/subscription_table.dart';

part 'subscription_dao.g.dart';

/// DAO for subscription operations
@DriftAccessor(tables: [Subscriptions, PromoCodes])
class SubscriptionDao extends DatabaseAccessor<AppDatabase>
    with _$SubscriptionDaoMixin {
  SubscriptionDao(super.db);

  // ==================== Subscriptions ====================

  /// Get active subscription
  Future<Subscription?> getActiveSubscription() async {
    return (select(subscriptions)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.expiryDate)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Watch active subscription
  Stream<Subscription?> watchActiveSubscription() {
    return (select(subscriptions)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.expiryDate)])
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Save subscription purchase
  Future<int> saveSubscription({
    required String purchaseToken,
    required String productId,
    required String platform,
    required DateTime purchaseDate,
    DateTime? expiryDate,
  }) async {
    return into(subscriptions).insert(
      SubscriptionsCompanion.insert(
        purchaseToken: purchaseToken,
        productId: productId,
        platform: platform,
        purchaseDate: purchaseDate,
        expiryDate: Value(expiryDate),
        isActive: const Value(true),
      ),
    );
  }

  /// Update subscription expiry
  Future<int> updateSubscriptionExpiry(String purchaseToken, DateTime expiryDate) {
    return (update(subscriptions)..where((t) => t.purchaseToken.equals(purchaseToken)))
        .write(SubscriptionsCompanion(
          expiryDate: Value(expiryDate),
          updatedAt: Value(DateTime.now()),
        ));
  }

  /// Deactivate subscription
  Future<int> deactivateSubscription(String purchaseToken) {
    return (update(subscriptions)..where((t) => t.purchaseToken.equals(purchaseToken)))
        .write(SubscriptionsCompanion(
          isActive: const Value(false),
          updatedAt: Value(DateTime.now()),
        ));
  }

  /// Deactivate all subscriptions
  Future<int> deactivateAllSubscriptions() {
    return update(subscriptions).write(const SubscriptionsCompanion(
      isActive: Value(false),
    ));
  }

  /// Get subscription by purchase token
  Future<Subscription?> getSubscriptionByToken(String purchaseToken) {
    return (select(subscriptions)
          ..where((t) => t.purchaseToken.equals(purchaseToken)))
        .getSingleOrNull();
  }

  // ==================== Promo Codes ====================

  /// Get active promo code
  Future<PromoCode?> getActivePromoCode() async {
    return (select(promoCodes)
          ..where((t) => t.isActive.equals(true))
          ..where((t) => t.expiryDate.isBiggerThanValue(DateTime.now()))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Watch active promo code
  Stream<PromoCode?> watchActivePromoCode() {
    return (select(promoCodes)
          ..where((t) => t.isActive.equals(true))
          ..where((t) => t.expiryDate.isBiggerThanValue(DateTime.now()))
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Save promo code
  Future<int> savePromoCode({
    required String code,
    required DateTime expiryDate,
  }) async {
    // First deactivate any existing promo codes
    await deactivateAllPromoCodes();

    return into(promoCodes).insert(
      PromoCodesCompanion.insert(
        code: code,
        expiryDate: expiryDate,
        isActive: const Value(true),
      ),
    );
  }

  /// Deactivate promo code
  Future<int> deactivatePromoCode(String code) {
    return (update(promoCodes)..where((t) => t.code.equals(code)))
        .write(const PromoCodesCompanion(isActive: Value(false)));
  }

  /// Deactivate all promo codes
  Future<int> deactivateAllPromoCodes() {
    return update(promoCodes).write(const PromoCodesCompanion(isActive: Value(false)));
  }

  /// Get promo code by code string
  Future<PromoCode?> getPromoCodeByCode(String code) {
    return (select(promoCodes)..where((t) => t.code.equals(code)))
        .getSingleOrNull();
  }

  /// Check if any subscription or promo code is active
  Future<bool> hasActiveAccess() async {
    final subscription = await getActiveSubscription();
    if (subscription != null &&
        (subscription.expiryDate == null || subscription.expiryDate!.isAfter(DateTime.now()))) {
      return true;
    }

    final promoCode = await getActivePromoCode();
    return promoCode != null;
  }

  /// Watch whether user has active access (subscription or promo code)
  Stream<bool> watchHasActiveAccess() {
    // Combine subscription and promo code streams
    return watchActiveSubscription().asyncMap((subscription) async {
      if (subscription != null &&
          (subscription.expiryDate == null || subscription.expiryDate!.isAfter(DateTime.now()))) {
        return true;
      }
      final promoCode = await getActivePromoCode();
      return promoCode != null;
    });
  }
}
