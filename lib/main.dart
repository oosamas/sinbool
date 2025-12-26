import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/services/error_handler_service.dart';
import 'core/services/security_service.dart';
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

    // Initialize Google Cloud TTS API key (if not already stored)
    await _initializeCloudTts();

    ErrorHandlerService.instance.info('App initialization complete');

    runApp(
      const ProviderScope(
        child: SinboolApp(),
      ),
    );
  });
}

/// Initialize Google Cloud TTS with API key
Future<void> _initializeCloudTts() async {
  // Check if API key is already stored
  final existingKey = await SecurityService.instance.readSecure(
    SecureStorageKeys.googleCloudApiKey,
  );

  if (existingKey == null || existingKey.isEmpty) {
    // Store the API key on first run
    // API key should be provided via --dart-define=GOOGLE_CLOUD_API_KEY=your_key
    const apiKey = String.fromEnvironment(
      'GOOGLE_CLOUD_API_KEY',
      defaultValue: '',
    );
    if (apiKey.isNotEmpty) {
      await SecurityService.instance.storeSecure(
        SecureStorageKeys.googleCloudApiKey,
        apiKey,
      );
      if (kDebugMode) {
        print('CloudTTS: API key initialized from environment');
      }
    } else if (kDebugMode) {
      print('CloudTTS: No API key provided. Use --dart-define=GOOGLE_CLOUD_API_KEY=your_key');
    }
  }
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
