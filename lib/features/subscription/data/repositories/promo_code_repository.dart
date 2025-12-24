import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../domain/entities/promo_code_entity.dart';
import 'subscription_repository.dart';

part 'promo_code_repository.g.dart';

/// Repository for promo code validation and activation
class PromoCodeRepository {
  PromoCodeRepository(this._dio, this._subscriptionRepo);

  final Dio _dio;
  final SubscriptionRepository _subscriptionRepo;

  /// Validate a promo code with the backend
  Future<PromoCodeResult> validatePromoCode(String code) async {
    try {
      final normalizedCode = code.toUpperCase().trim();

      // Make API request to validate code
      final response = await _dio.post(
        '${ApiEndpoints.production}${ApiEndpoints.promoValidate}',
        data: {
          'code': normalizedCode,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final isValid = data['valid'] as bool? ?? false;

        if (isValid) {
          final expiryDateStr = data['expiry_date'] as String?;
          final durationDays = data['duration_days'] as int? ?? 30;

          DateTime expiryDate;
          if (expiryDateStr != null) {
            expiryDate = DateTime.parse(expiryDateStr);
          } else {
            expiryDate = DateTime.now().add(Duration(days: durationDays));
          }

          return PromoCodeResult.success(
            PromoCodeEntity.valid(
              code: normalizedCode,
              expiryDate: expiryDate,
              durationDays: durationDays,
            ),
          );
        } else {
          final errorMessage = data['error'] as String? ?? 'Invalid promo code';
          return PromoCodeResult.failure(errorMessage);
        }
      }

      return PromoCodeResult.failure('Invalid response from server');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return PromoCodeResult.failure('Promo code not found');
      } else if (e.response?.statusCode == 410) {
        return PromoCodeResult.failure('Promo code has expired');
      } else if (e.response?.statusCode == 409) {
        return PromoCodeResult.failure('Promo code has already been used');
      }

      // For development/testing, allow certain codes locally
      return _handleOfflineValidation(code);
    } catch (e) {
      return _handleOfflineValidation(code);
    }
  }

  /// Handle offline validation - only allows test codes in debug mode
  PromoCodeResult _handleOfflineValidation(String code) {
    final normalizedCode = code.toUpperCase().trim();

    // Test codes only available in debug mode
    if (kDebugMode) {
      if (normalizedCode == 'SINBOOL2024' || normalizedCode == 'TESTPREMIUM') {
        return PromoCodeResult.success(
          PromoCodeEntity.valid(
            code: normalizedCode,
            expiryDate: DateTime.now().add(const Duration(days: 365)),
            durationDays: 365,
          ),
        );
      }
    }

    return PromoCodeResult.failure('Unable to validate promo code. Please check your internet connection.');
  }

  /// Activate a validated promo code
  Future<bool> activatePromoCode(PromoCodeEntity promoCode) async {
    if (!promoCode.isValid || promoCode.expiryDate == null) {
      return false;
    }

    try {
      await _subscriptionRepo.activatePromoCode(
        code: promoCode.code,
        expiryDate: promoCode.expiryDate!,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Validate and activate a promo code in one step
  Future<PromoCodeResult> redeemPromoCode(String code) async {
    final result = await validatePromoCode(code);

    if (result.success && result.promoCode != null) {
      final activated = await activatePromoCode(result.promoCode!);
      if (!activated) {
        return PromoCodeResult.failure('Failed to activate promo code');
      }
    }

    return result;
  }
}

/// Promo code repository provider
@riverpod
PromoCodeRepository promoCodeRepository(PromoCodeRepositoryRef ref) {
  final dio = Dio();
  final subscriptionRepo = ref.watch(subscriptionRepositoryProvider);
  return PromoCodeRepository(dio, subscriptionRepo);
}
