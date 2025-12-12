import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Standard loading indicator used across the app
/// From Issue #94 - UI/UX Consistency Guidelines
class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
    this.message,
    this.color,
  });

  final String? message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: color ?? AppColors.primary,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Inline loading indicator for buttons and small spaces
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.size = 24,
    this.color,
    this.strokeWidth = 2,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
