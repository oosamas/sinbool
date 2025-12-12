import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Global error handler service for production error tracking
/// Integrates with Firebase Crashlytics for crash reporting
class ErrorHandlerService {
  ErrorHandlerService._();

  static final ErrorHandlerService _instance = ErrorHandlerService._();
  static ErrorHandlerService get instance => _instance;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: kDebugMode ? Level.debug : Level.warning,
  );

  bool _initialized = false;
  FirebaseCrashlytics? _crashlytics;

  /// Initialize the error handler
  /// Should be called before runApp
  Future<void> initialize() async {
    if (_initialized) return;

    // Setup Flutter error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };

    // Setup platform dispatcher error handling
    PlatformDispatcher.instance.onError = (error, stack) {
      _handlePlatformError(error, stack);
      return true;
    };

    // Initialize Crashlytics in release mode
    if (!kDebugMode) {
      try {
        _crashlytics = FirebaseCrashlytics.instance;
        await _crashlytics?.setCrashlyticsCollectionEnabled(true);
      } catch (e) {
        _logger.w('Firebase Crashlytics not configured: $e');
      }
    }

    _initialized = true;
    _logger.i('ErrorHandlerService initialized');
  }

  /// Log a debug message
  void debug(String message, [dynamic data]) {
    _logger.d(data != null ? '$message: $data' : message);
  }

  /// Log an info message
  void info(String message, [dynamic data]) {
    _logger.i(data != null ? '$message: $data' : message);
  }

  /// Log a warning message
  void warning(String message, [dynamic data]) {
    _logger.w(data != null ? '$message: $data' : message);
    _crashlytics?.log('WARNING: $message ${data ?? ''}');
  }

  /// Log an error with optional stack trace
  void error(
    String message,
    dynamic error, [
    StackTrace? stackTrace,
  ]) {
    _logger.e(message, error: error, stackTrace: stackTrace);

    if (!kDebugMode && _crashlytics != null && error != null) {
      _crashlytics!.recordError(
        error,
        stackTrace ?? StackTrace.current,
        reason: message,
        fatal: false,
      );
    }
  }

  /// Log a fatal error (will be marked as fatal in Crashlytics)
  void fatal(
    String message,
    dynamic error, [
    StackTrace? stackTrace,
  ]) {
    _logger.f(message, error: error, stackTrace: stackTrace);

    if (!kDebugMode && _crashlytics != null && error != null) {
      _crashlytics!.recordError(
        error,
        stackTrace ?? StackTrace.current,
        reason: message,
        fatal: true,
      );
    }
  }

  /// Set user identifier for crash reports
  Future<void> setUserIdentifier(String userId) async {
    await _crashlytics?.setUserIdentifier(userId);
  }

  /// Set custom key-value for crash reports
  Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics?.setCustomKey(key, value);
  }

  /// Handle Flutter framework errors
  void _handleFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      _crashlytics?.recordFlutterFatalError(details);
    }
  }

  /// Handle platform errors (non-Flutter errors)
  void _handlePlatformError(Object error, StackTrace stack) {
    _logger.e('Platform error', error: error, stackTrace: stack);

    if (!kDebugMode && _crashlytics != null) {
      _crashlytics!.recordError(error, stack, fatal: true);
    }
  }

  /// Run a zone guarded operation with error handling
  static Future<void> runGuarded(Future<void> Function() body) async {
    await runZonedGuarded(
      () async {
        await body();
      },
      (error, stackTrace) {
        instance.error('Unhandled zone error', error, stackTrace);
      },
    );
  }
}

/// Extension for easy logging throughout the app
extension ErrorLogging on Object {
  void logDebug(String message, [dynamic data]) {
    ErrorHandlerService.instance.debug('[$runtimeType] $message', data);
  }

  void logInfo(String message, [dynamic data]) {
    ErrorHandlerService.instance.info('[$runtimeType] $message', data);
  }

  void logWarning(String message, [dynamic data]) {
    ErrorHandlerService.instance.warning('[$runtimeType] $message', data);
  }

  void logError(String message, dynamic error, [StackTrace? stackTrace]) {
    ErrorHandlerService.instance.error('[$runtimeType] $message', error, stackTrace);
  }
}
