import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/bookmarks/presentation/pages/bookmarks_page.dart';
import '../../features/chapters/presentation/pages/chapter_detail_page.dart';
import '../../features/chapters/presentation/pages/chapters_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/lessons/presentation/pages/lesson_detail_page.dart';
import '../../features/lessons/presentation/pages/quiz_page.dart';
import '../../features/lessons/presentation/pages/story_viewer_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/about_page.dart';
import '../../features/settings/presentation/pages/language_settings_page.dart';
import '../../features/settings/presentation/pages/parental_controls_page.dart';
import '../../features/settings/presentation/pages/parental_pin_page.dart';
import '../../features/settings/presentation/pages/privacy_policy_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/terms_of_service_page.dart';
import '../../features/settings/presentation/pages/theme_settings_page.dart';
import '../../features/subscription/presentation/pages/paywall_page.dart';
import '../../features/subscription/presentation/pages/promo_code_page.dart';
import '../widgets/navigation/main_shell.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

/// Global navigator key for the app
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

/// App router provider
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash screen
      GoRoute(
        path: AppRoutes.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // Onboarding
      GoRoute(
        path: AppRoutes.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),

      // Main shell with bottom navigation
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Home tab
          GoRoute(
            path: AppRoutes.home,
            name: RouteNames.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),

          // Chapters tab
          GoRoute(
            path: AppRoutes.chapters,
            name: RouteNames.chapters,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChaptersPage(),
            ),
            routes: [
              // Chapter detail (outside shell for full screen)
            ],
          ),

          // Bookmarks tab
          GoRoute(
            path: AppRoutes.bookmarks,
            name: RouteNames.bookmarks,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookmarksPage(),
            ),
          ),

          // Profile tab
          GoRoute(
            path: AppRoutes.profile,
            name: RouteNames.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfilePage(),
            ),
          ),
        ],
      ),

      // Chapter detail (full screen, outside shell)
      GoRoute(
        path: AppRoutes.chapterDetail,
        name: RouteNames.chapterDetail,
        builder: (context, state) {
          final chapterId = state.pathParameters['chapterId']!;
          return ChapterDetailPage(chapterId: chapterId);
        },
        routes: [
          // Lesson detail
          GoRoute(
            path: 'lessons/:lessonId',
            name: RouteNames.lessonDetail,
            builder: (context, state) {
              final chapterId = state.pathParameters['chapterId']!;
              final lessonId = state.pathParameters['lessonId']!;
              return LessonDetailPage(
                chapterId: chapterId,
                lessonId: lessonId,
              );
            },
            routes: [
              // Story viewer
              GoRoute(
                path: 'story',
                name: RouteNames.storyViewer,
                builder: (context, state) {
                  final chapterId = state.pathParameters['chapterId']!;
                  final lessonId = state.pathParameters['lessonId']!;
                  return StoryViewerPage(
                    chapterId: chapterId,
                    lessonId: lessonId,
                  );
                },
              ),
              // Quiz
              GoRoute(
                path: 'quiz',
                name: RouteNames.quizScreen,
                builder: (context, state) {
                  final chapterId = state.pathParameters['chapterId']!;
                  final lessonId = state.pathParameters['lessonId']!;
                  return QuizPage(
                    chapterId: chapterId,
                    lessonId: lessonId,
                  );
                },
              ),
            ],
          ),
        ],
      ),

      // Settings
      GoRoute(
        path: AppRoutes.settings,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsPage(),
        routes: [
          GoRoute(
            path: 'parental',
            name: RouteNames.parentalControls,
            builder: (context, state) => const ParentalControlsPage(),
            routes: [
              GoRoute(
                path: 'pin',
                name: RouteNames.parentalPin,
                builder: (context, state) => const ParentalPinPage(),
              ),
            ],
          ),
          GoRoute(
            path: 'language',
            name: RouteNames.languageSettings,
            builder: (context, state) => const LanguageSettingsPage(),
          ),
          GoRoute(
            path: 'theme',
            name: RouteNames.themeSettings,
            builder: (context, state) => const ThemeSettingsPage(),
          ),
        ],
      ),

      // About & Legal
      GoRoute(
        path: AppRoutes.about,
        name: RouteNames.about,
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        name: RouteNames.privacyPolicy,
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: AppRoutes.termsOfService,
        name: RouteNames.termsOfService,
        builder: (context, state) => const TermsOfServicePage(),
      ),

      // Subscription
      GoRoute(
        path: AppRoutes.paywall,
        name: RouteNames.paywall,
        builder: (context, state) => const PaywallPage(),
      ),
      GoRoute(
        path: AppRoutes.promoCode,
        name: RouteNames.promoCode,
        builder: (context, state) => const PromoCodePage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorRoutePage(error: state.error),
  );
}

/// Error page for unknown routes
class ErrorRoutePage extends StatelessWidget {
  const ErrorRoutePage({required this.error, super.key});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
