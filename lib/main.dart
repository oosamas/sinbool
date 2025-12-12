import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/services/error_handler_service.dart';
import 'firebase_options.dart';
import 'injection.dart';

Future<void> main() async {
  // Run with error handling
  await ErrorHandlerService.runGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize error handler first
    await ErrorHandlerService.instance.initialize();

    // Set preferred orientations (portrait only for children's app)
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // Initialize Firebase
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      ErrorHandlerService.instance.info('Firebase initialized successfully');
    } catch (e) {
      // Firebase is optional - app works offline
      ErrorHandlerService.instance.warning(
        'Firebase initialization skipped',
        'App will work in offline mode. Configure Firebase for full features.',
      );
    }

    // Initialize dependencies
    await configureDependencies();

    ErrorHandlerService.instance.info('App initialization complete');

    runApp(
      const ProviderScope(
        child: SinboolApp(),
      ),
    );
  });
}

/// Environment configuration
class AppEnvironment {
  AppEnvironment._();

  static const bool isProduction = kReleaseMode;
  static const bool isDevelopment = kDebugMode;
  static const bool isProfile = kProfileMode;

  static String get name {
    if (isProduction) return 'production';
    if (isProfile) return 'profile';
    return 'development';
  }
}
