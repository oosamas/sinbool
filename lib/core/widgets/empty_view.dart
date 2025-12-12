import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

/// Standard empty state view used across the app
/// From Issue #94 - UI/UX Consistency Guidelines
class EmptyView extends StatelessWidget {
  const EmptyView({
    required this.message,
    super.key,
    this.icon = Icons.inbox_outlined,
    this.action,
    this.title,
  });

  final String message;
  final IconData icon;
  final Widget? action;
  final String? title;

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
              size: 80,
              color: AppColors.textHint,
            ),
            const SizedBox(height: Spacing.md),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Spacing.sm),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            if (action != null) ...[
              const SizedBox(height: Spacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty lessons view
class NoLessonsView extends StatelessWidget {
  const NoLessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyView(
      icon: Icons.menu_book_outlined,
      title: 'No Lessons Yet',
      message: 'Check back soon for new stories!',
    );
  }
}

/// Empty bookmarks view
class NoBookmarksView extends StatelessWidget {
  const NoBookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyView(
      icon: Icons.bookmark_border,
      title: 'No Bookmarks',
      message: 'Bookmark your favorite stories to find them easily later.',
    );
  }
}
