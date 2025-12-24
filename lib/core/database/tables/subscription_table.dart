import 'package:drift/drift.dart';

/// Subscription purchases table for tracking in-app purchases
/// Stores purchase tokens and validates subscription status
class Subscriptions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get purchaseToken => text().unique()();
  TextColumn get productId => text()();
  TextColumn get platform => text()(); // 'ios' or 'android'
  DateTimeColumn get purchaseDate => dateTime()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Promo codes table for tracking redeemed codes
class PromoCodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  DateTimeColumn get activatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expiryDate => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

/// Subscription type enum values stored as strings
class SubscriptionTypes {
  SubscriptionTypes._();

  static const String none = 'none';
  static const String monthly = 'monthly';
  static const String promoCode = 'promo_code';
}

/// Product IDs for in-app purchases
class ProductIds {
  ProductIds._();

  // Same ID for both iOS and Android for consistency
  static const String monthlySubscription = 'com.sinbool.app.premium.monthly';
}
