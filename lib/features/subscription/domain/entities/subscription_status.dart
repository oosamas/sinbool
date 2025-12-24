import 'package:equatable/equatable.dart';

/// Subscription type enumeration
enum SubscriptionType {
  /// No active subscription
  none,
  /// Monthly subscription via app stores
  monthly,
  /// Subscription via promo code
  promoCode,
}

/// Entity representing user's subscription status
class SubscriptionStatus extends Equatable {
  const SubscriptionStatus({
    required this.isActive,
    required this.type,
    this.expiryDate,
    this.promoCode,
  });

  /// Whether the subscription is currently active
  final bool isActive;

  /// Type of subscription
  final SubscriptionType type;

  /// When the subscription expires (null for none type)
  final DateTime? expiryDate;

  /// The promo code used (only for promoCode type)
  final String? promoCode;

  /// Default free (no subscription) status
  static const SubscriptionStatus free = SubscriptionStatus(
    isActive: false,
    type: SubscriptionType.none,
  );

  /// Check if subscription has expired
  bool get isExpired {
    if (expiryDate == null) return type == SubscriptionType.none;
    return DateTime.now().isAfter(expiryDate!);
  }

  /// Get remaining days until expiry
  int? get remainingDays {
    if (expiryDate == null) return null;
    final now = DateTime.now();
    if (now.isAfter(expiryDate!)) return 0;
    return expiryDate!.difference(now).inDays;
  }

  /// Create a copy with updated fields
  SubscriptionStatus copyWith({
    bool? isActive,
    SubscriptionType? type,
    DateTime? expiryDate,
    String? promoCode,
  }) {
    return SubscriptionStatus(
      isActive: isActive ?? this.isActive,
      type: type ?? this.type,
      expiryDate: expiryDate ?? this.expiryDate,
      promoCode: promoCode ?? this.promoCode,
    );
  }

  @override
  List<Object?> get props => [isActive, type, expiryDate, promoCode];
}
