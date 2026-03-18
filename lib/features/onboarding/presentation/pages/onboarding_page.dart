import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../settings/data/repositories/settings_repository.dart';

/// Onboarding page for first-time users
/// From Issue #3 - Navigation & Routing
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      icon: Icons.menu_book_rounded,
      title: 'Beautiful Islamic Stories',
      description:
          'Discover inspiring stories from the Quran and Islamic history, '
          'designed especially for children.',
      color: AppColors.primary,
    ),
    _OnboardingData(
      icon: Icons.headphones_rounded,
      title: 'Listen & Learn',
      description:
          'Enjoy audio narration with beautiful recitation. '
          'Perfect for learning on the go.',
      color: AppColors.secondary,
    ),
    _OnboardingData(
      icon: Icons.quiz_rounded,
      title: 'Interactive Quizzes',
      description:
          'Test your knowledge with fun quizzes after each story. '
          'Learn while having fun!',
      color: AppColors.success,
    ),
    _OnboardingData(
      icon: Icons.family_restroom_rounded,
      title: 'Safe for Children',
      description:
          'COPPA compliant with parental controls. '
          'A safe environment for your children to learn.',
      color: AppColors.info,
    ),
    _OnboardingData(
      icon: Icons.star_rounded,
      title: 'Premium Experience',
      description:
          'Try the first lesson of each chapter FREE! '
          'Unlock full access to all stories, audio, and quizzes with Premium.',
      color: AppColors.secondary,
      isPremium: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    await settingsRepo.setOnboardingCompleted(true);
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(Spacing.md),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text('Skip'),
                ),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _OnboardingPageContent(data: _pages[index]);
                },
              ),
            ),

            // Page indicators
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? _pages[index].color
                          : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

            // Next/Get Started button
            Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: AppButton(
                text: _currentPage == _pages.length - 1
                    ? 'Get Started'
                    : 'Next',
                onPressed: _nextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.isPremium = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isPremium;
}

class _OnboardingPageContent extends StatelessWidget {
  const _OnboardingPageContent({required this.data});

  final _OnboardingData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              data.icon,
              size: 80,
              color: data.color,
            ),
          ),
          const SizedBox(height: Spacing.xl),
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.md),
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          // Premium comparison for the premium page
          if (data.isPremium) ...[
            const SizedBox(height: Spacing.xl),
            _PremiumComparisonWidget(),
          ],
        ],
      ),
    );
  }
}

class _PremiumComparisonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          _ComparisonRow(
            feature: 'First lesson of each chapter',
            isFree: true,
            isPremium: true,
          ),
          const Divider(height: Spacing.md),
          _ComparisonRow(
            feature: 'All stories & lessons',
            isFree: false,
            isPremium: true,
          ),
          const Divider(height: Spacing.md),
          _ComparisonRow(
            feature: 'Audio narration',
            isFree: false,
            isPremium: true,
          ),
          const Divider(height: Spacing.md),
          _ComparisonRow(
            feature: 'Interactive quizzes',
            isFree: false,
            isPremium: true,
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.feature,
    required this.isFree,
    required this.isPremium,
  });

  final String feature;
  final bool isFree;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            feature,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: _CheckMark(isEnabled: isFree, label: 'Free'),
        ),
        Expanded(
          child: _CheckMark(isEnabled: isPremium, label: 'Pro', isPro: true),
        ),
      ],
    );
  }
}

class _CheckMark extends StatelessWidget {
  const _CheckMark({
    required this.isEnabled,
    required this.label,
    this.isPro = false,
  });

  final bool isEnabled;
  final String label;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          isEnabled ? Icons.check_circle : Icons.cancel,
          color: isEnabled
              ? (isPro ? AppColors.secondary : AppColors.success)
              : AppColors.textHint,
          size: 20,
        ),
      ],
    );
  }
}
