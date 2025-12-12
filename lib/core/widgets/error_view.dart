import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

/// Standard error view used across the app
/// From Issue #92 - Error Handling Patterns
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.message,
    super.key,
    this.onRetry,
    this.icon = Icons.error_outline,
    this.retryLabel,
  });

  final String message;
  final VoidCallback? onRetry;
  final IconData icon;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: Spacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: Spacing.lg),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryLabel ?? 'Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Network error specific view
class NetworkErrorView extends StatelessWidget {
  const NetworkErrorView({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ErrorView(
      message: 'No internet connection.\nPlease check your network settings.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
    );
  }
}

/// Generic server error view
class ServerErrorView extends StatelessWidget {
  const ServerErrorView({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ErrorView(
      message: 'Something went wrong.\nPlease try again later.',
      icon: Icons.cloud_off,
      onRetry: onRetry,
    );
  }
}
