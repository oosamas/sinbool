import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/controllers/settings_controller.dart';
import 'l10n/app_localizations.dart';

/// Root application widget
/// From Issue #3 - Navigation & Routing
class SinboolApp extends ConsumerWidget {
  const SinboolApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final settingsState = ref.watch(settingsControllerProvider);

    // Get locale from settings
    final locale = Locale(settingsState.settings.language);

    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Router configuration
      routerConfig: router,

      // Theme - using centralized AppTheme
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settingsState.settings.themeMode,

      // Localization - using generated AppLocalizations
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
    );
  }
}
