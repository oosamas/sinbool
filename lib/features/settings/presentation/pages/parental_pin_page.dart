import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../controllers/settings_controller.dart';

/// PIN setup/change page for parental controls
/// From Issue #3 - Navigation & Routing
/// Updated in Issue #9 - Parental Controls & Settings
class ParentalPinPage extends ConsumerStatefulWidget {
  const ParentalPinPage({super.key});

  @override
  ConsumerState<ParentalPinPage> createState() => _ParentalPinPageState();
}

class _ParentalPinPageState extends ConsumerState<ParentalPinPage> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _savePin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final success = await ref
          .read(settingsControllerProvider.notifier)
          .setParentalPin(_pinController.text);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PIN saved successfully')),
          );
          Navigator.of(context).pop();
        } else {
          setState(() {
            _error = 'Failed to save PIN. Please try again.';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsControllerProvider);
    final hasExistingPin = settingsState.hasParentalPin;

    return Scaffold(
      appBar: AppBar(
        title: Text(hasExistingPin ? 'Change PIN' : 'Set PIN'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info
              Container(
                padding: const EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.info),
                    const SizedBox(width: Spacing.md),
                    Expanded(
                      child: Text(
                        'This PIN will be required to access parental controls '
                        'and restricted settings.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.xl),

              // PIN input
              Text(
                'Enter 4-digit PIN',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: Spacing.md),
              TextFormField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: '****',
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.length != 4) {
                    return 'Please enter a 4-digit PIN';
                  }
                  // Check for common weak PINs
                  final weakPins = ['0000', '1234', '1111', '2222', '3333', '4444', '5555', '6666', '7777', '8888', '9999'];
                  if (weakPins.contains(value)) {
                    return 'Please choose a stronger PIN';
                  }
                  return null;
                },
              ),
              const SizedBox(height: Spacing.lg),

              // Confirm PIN
              Text(
                'Confirm PIN',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: Spacing.md),
              TextFormField(
                controller: _confirmPinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: '****',
                  counterText: '',
                ),
                validator: (value) {
                  if (value != _pinController.text) {
                    return 'PINs do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: Spacing.xl),

              // Error message
              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: AppColors.error),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: Spacing.lg),
              ],

              // Save button
              AppButton(
                text: hasExistingPin ? 'Update PIN' : 'Set PIN',
                onPressed: _savePin,
                isLoading: _isLoading,
              ),

              // Remove PIN option (if has existing)
              if (hasExistingPin) ...[
                const SizedBox(height: Spacing.lg),
                TextButton(
                  onPressed: () => _showRemovePinDialog(context),
                  style: TextButton.styleFrom(foregroundColor: AppColors.error),
                  child: const Text('Remove PIN'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showRemovePinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove PIN?'),
        content: const Text(
          'This will disable PIN protection for parental controls. '
          'Anyone will be able to access these settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ref.read(settingsControllerProvider.notifier).removeParentalPin();
                if (context.mounted) {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PIN removed')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.of(context).pop(); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to remove PIN: $e')),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
