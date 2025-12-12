import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../loading/loading_view.dart';

/// Primary elevated button for main actions
/// From Issue #2 - Design System
class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: TouchTarget.min,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        child: isLoading
            ? const LoadingIndicator(
                size: 24,
                color: AppColors.textOnPrimary,
              )
            : icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: IconSizes.sm),
                      const SizedBox(width: Spacing.sm),
                      Text(text),
                    ],
                  )
                : Text(text),
      ),
    );
  }
}

/// Secondary outlined button for alternative actions
class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: TouchTarget.min,
      child: OutlinedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        child: isLoading
            ? const LoadingIndicator(
                size: 24,
                color: AppColors.primary,
              )
            : icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: IconSizes.sm),
                      const SizedBox(width: Spacing.sm),
                      Text(text),
                    ],
                  )
                : Text(text),
      ),
    );
  }
}

/// Text button for tertiary actions
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: IconSizes.sm),
                const SizedBox(width: Spacing.xs),
                Text(text),
              ],
            )
          : Text(text),
    );
  }
}

/// Icon button with proper touch target size
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.size = IconSizes.md,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;
  final Color? backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size),
      color: color ?? AppColors.primary,
      style: backgroundColor != null
          ? IconButton.styleFrom(backgroundColor: backgroundColor)
          : null,
      constraints: const BoxConstraints(
        minWidth: TouchTarget.min,
        minHeight: TouchTarget.min,
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }
    return button;
  }
}

/// Floating action button for primary actions
class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.label,
    this.heroTag,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? label;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label!),
        heroTag: heroTag,
      );
    }
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      child: Icon(icon),
    );
  }
}
