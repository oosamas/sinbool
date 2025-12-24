import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/subscription_controller.dart';

/// Page for entering and redeeming promo codes
class PromoCodePage extends ConsumerStatefulWidget {
  const PromoCodePage({super.key});

  @override
  ConsumerState<PromoCodePage> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends ConsumerState<PromoCodePage> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.promoCode),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Illustration
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: Spacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  size: 50,
                  color: AppColors.secondary,
                ),
              ),

              // Title
              Text(
                AppLocalizations.of(context)!.enterPromoCode,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: Spacing.sm),

              // Description
              Text(
                AppLocalizations.of(context)!.promoCodeDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: Spacing.xl),

              // Promo code input
              TextFormField(
                controller: _codeController,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                  UpperCaseTextFormatter(),
                ],
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.promoCode,
                  hintText: AppLocalizations.of(context)!.promoCodeHint,
                  prefixIcon: const Icon(Icons.confirmation_number),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkSurfaceVariant
                      : AppColors.surfaceVariant,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterPromoCode;
                  }
                  if (value.length < 4) {
                    return AppLocalizations.of(context)!.promoCodeTooShort;
                  }
                  return null;
                },
                onChanged: (_) {
                  setState(() {
                    _errorMessage = null;
                    _successMessage = null;
                  });
                },
              ),

              const SizedBox(height: Spacing.lg),

              // Error message
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.error),
                      const SizedBox(width: Spacing.sm),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Success message
              if (_successMessage != null)
                Container(
                  padding: const EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppColors.success),
                      const SizedBox(width: Spacing.sm),
                      Expanded(
                        child: Text(
                          _successMessage!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: Spacing.lg),

              // Apply button
              ElevatedButton(
                onPressed: _isLoading ? null : _applyPromoCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: Spacing.md),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.textOnPrimary,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)!.applyPromoCode,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),

              const SizedBox(height: Spacing.xl),

              // Info text
              Container(
                padding: const EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: Spacing.sm),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.promoCodeInfo,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _applyPromoCode() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    final controller = ref.read(subscriptionControllerProvider.notifier);
    final result = await controller.redeemPromoCode(_codeController.text.trim());

    setState(() {
      _isLoading = false;
    });

    if (result.success) {
      setState(() {
        _successMessage = AppLocalizations.of(context)!.promoCodeSuccess;
      });

      // Wait a moment then navigate back
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        // Pop to go back to previous screen
        context.pop();
      }
    } else {
      setState(() {
        _errorMessage = result.errorMessage ?? AppLocalizations.of(context)!.promoCodeInvalid;
      });
    }
  }
}

/// Input formatter to convert text to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
