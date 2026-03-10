import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../sync/presentation/controllers/sync_controller.dart';
import '../controllers/auth_controller.dart';

/// Sign-in buttons widget for Apple and Google sign-in
class SignInButtons extends ConsumerWidget {
  const SignInButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // COPPA notice
        Container(
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.info, size: 20),
              const SizedBox(width: Spacing.sm),
              Expanded(
                child: Text(
                  'Parent/guardian sign-in to back up your child\'s learning progress across devices.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.lg),

        // Error message
        if (authState.error != null) ...[
          Container(
            padding: const EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              authState.error!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Spacing.md),
        ],

        // Apple Sign-In (iOS only, or all platforms)
        if (Platform.isIOS) ...[
          _SignInButton(
            onPressed: authState.isLoading
                ? null
                : () => _signInWithApple(ref),
            icon: Icons.apple,
            label: 'Continue with Apple',
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            isLoading: authState.isLoading,
          ),
          const SizedBox(height: Spacing.md),
        ],

        // Google Sign-In
        _SignInButton(
          onPressed: authState.isLoading
              ? null
              : () => _signInWithGoogle(ref),
          icon: Icons.g_mobiledata,
          label: 'Continue with Google',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          borderColor: AppColors.surfaceVariant,
          isLoading: authState.isLoading,
        ),
      ],
    );
  }

  Future<void> _signInWithApple(WidgetRef ref) async {
    final success = await ref.read(authControllerProvider.notifier).signInWithApple();
    if (success) {
      final user = ref.read(authControllerProvider).user;
      if (user != null) {
        await ref.read(syncControllerProvider.notifier).onSignIn(user.uid);
      }
    }
  }

  Future<void> _signInWithGoogle(WidgetRef ref) async {
    final success = await ref.read(authControllerProvider.notifier).signInWithGoogle();
    if (success) {
      final user = ref.read(authControllerProvider).user;
      if (user != null) {
        await ref.read(syncControllerProvider.notifier).onSignIn(user.uid);
      }
    }
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 24),
                  const SizedBox(width: Spacing.sm),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
