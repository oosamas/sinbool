import 'package:equatable/equatable.dart';

/// Entity representing a promo code
class PromoCodeEntity extends Equatable {
  const PromoCodeEntity({
    required this.code,
    required this.isValid,
    this.expiryDate,
    this.durationDays,
    this.errorMessage,
  });

  /// The promo code string
  final String code;

  /// Whether the code is valid
  final bool isValid;

  /// When the promo code subscription expires
  final DateTime? expiryDate;

  /// Duration in days the code grants
  final int? durationDays;

  /// Error message if code is invalid
  final String? errorMessage;

  /// Create an invalid promo code result
  factory PromoCodeEntity.invalid(String code, String message) {
    return PromoCodeEntity(
      code: code,
      isValid: false,
      errorMessage: message,
    );
  }

  /// Create a valid promo code result
  factory PromoCodeEntity.valid({
    required String code,
    required DateTime expiryDate,
    required int durationDays,
  }) {
    return PromoCodeEntity(
      code: code,
      isValid: true,
      expiryDate: expiryDate,
      durationDays: durationDays,
    );
  }

  @override
  List<Object?> get props => [code, isValid, expiryDate, durationDays, errorMessage];
}

/// Result of promo code validation
class PromoCodeResult extends Equatable {
  const PromoCodeResult({
    required this.success,
    this.promoCode,
    this.errorMessage,
  });

  /// Whether validation was successful
  final bool success;

  /// The validated promo code entity
  final PromoCodeEntity? promoCode;

  /// Error message if validation failed
  final String? errorMessage;

  /// Create a success result
  factory PromoCodeResult.success(PromoCodeEntity promoCode) {
    return PromoCodeResult(
      success: true,
      promoCode: promoCode,
    );
  }

  /// Create a failure result
  factory PromoCodeResult.failure(String message) {
    return PromoCodeResult(
      success: false,
      errorMessage: message,
    );
  }

  @override
  List<Object?> get props => [success, promoCode, errorMessage];
}
