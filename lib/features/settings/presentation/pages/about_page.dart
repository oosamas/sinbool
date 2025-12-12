import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// About page
/// From Issue #3 - Navigation & Routing
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Sinbool'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          children: [
            // App icon and name
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                size: 56,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: Spacing.lg),
            Text(
              'Sinbool',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              'Islamic Stories for Children',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: Spacing.sm),
            Text(
              'Version 1.0.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
            const SizedBox(height: Spacing.xl),

            // Description
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Mission',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: Spacing.sm),
                    Text(
                      'Sinbool is dedicated to bringing beautiful Islamic stories '
                      'to children around the world. Our goal is to make learning '
                      'about Islamic history and values fun, engaging, and '
                      'accessible to young Muslims everywhere.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.md),

            // Features
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: Spacing.md),
                    _FeatureItem(
                      icon: Icons.auto_stories,
                      text: 'Beautiful illustrated stories',
                    ),
                    _FeatureItem(
                      icon: Icons.headphones,
                      text: 'Audio narration with Quranic recitation',
                    ),
                    _FeatureItem(
                      icon: Icons.quiz,
                      text: 'Interactive quizzes',
                    ),
                    _FeatureItem(
                      icon: Icons.translate,
                      text: 'Multiple language support',
                    ),
                    _FeatureItem(
                      icon: Icons.family_restroom,
                      text: 'COPPA compliant & child-safe',
                    ),
                    _FeatureItem(
                      icon: Icons.download,
                      text: 'Offline access',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.md),

            // Credits
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Credits',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: Spacing.sm),
                    Text(
                      'Built with love for the Muslim Ummah.\n\n'
                      'Quran recitation by qualified Qaris.\n'
                      'Stories reviewed by Islamic scholars.\n'
                      'Illustrations by talented Muslim artists.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.xl),

            // Copyright
            Text(
              '© 2024 Sinbool. All rights reserved.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
            const SizedBox(height: Spacing.md),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
