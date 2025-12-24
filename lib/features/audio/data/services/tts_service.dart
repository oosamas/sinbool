import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tts_service.g.dart';

/// Text-to-Speech state
enum TtsState { playing, stopped, paused, continued }

/// Text-to-Speech service for reading lesson content aloud
/// Enables kids to listen to stories like an audiobook
class TtsService {
  TtsService() {
    _initTts();
  }

  final FlutterTts _flutterTts = FlutterTts();

  TtsState _ttsState = TtsState.stopped;
  TtsState get ttsState => _ttsState;

  String? _currentText;
  String? get currentText => _currentText;

  double _speechRate = 0.45; // Slower for children
  double get speechRate => _speechRate;

  double _volume = 1.0;
  double get volume => _volume;

  double _pitch = 1.0;
  double get pitch => _pitch;

  String _language = 'en-US';
  String get language => _language;

  // Stream controllers for state updates
  final _stateController = StreamController<TtsState>.broadcast();
  Stream<TtsState> get stateStream => _stateController.stream;

  final _progressController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get progressStream => _progressController.stream;

  Future<void> _initTts() async {
    // Set up handlers
    _flutterTts.setStartHandler(() {
      _ttsState = TtsState.playing;
      _stateController.add(_ttsState);
    });

    _flutterTts.setCompletionHandler(() {
      _ttsState = TtsState.stopped;
      _stateController.add(_ttsState);
    });

    _flutterTts.setCancelHandler(() {
      _ttsState = TtsState.stopped;
      _stateController.add(_ttsState);
    });

    _flutterTts.setPauseHandler(() {
      _ttsState = TtsState.paused;
      _stateController.add(_ttsState);
    });

    _flutterTts.setContinueHandler(() {
      _ttsState = TtsState.continued;
      _stateController.add(_ttsState);
    });

    _flutterTts.setErrorHandler((msg) {
      _ttsState = TtsState.stopped;
      _stateController.add(_ttsState);
      debugPrint('TTS Error: $msg');
    });

    // Progress handler for word highlighting (if needed)
    _flutterTts.setProgressHandler((text, start, end, word) {
      _progressController.add({
        'text': text,
        'start': start,
        'end': end,
        'word': word,
      });
    });

    // Configure for mobile platforms
    if (!kIsWeb) {
      if (Platform.isIOS) {
        await _flutterTts.setSharedInstance(true);
        await _flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          ],
          IosTextToSpeechAudioMode.voicePrompt,
        );
      }

      if (Platform.isAndroid) {
        await _flutterTts.setQueueMode(1); // Queue mode
      }
    }

    // Set default values - slower speed for children
    await _flutterTts.setSpeechRate(_speechRate);
    await _flutterTts.setVolume(_volume);
    await _flutterTts.setPitch(_pitch);
    await _flutterTts.setLanguage(_language);
  }

  /// Get available languages
  Future<List<dynamic>> getLanguages() async {
    return await _flutterTts.getLanguages;
  }

  /// Get available voices
  Future<List<dynamic>> getVoices() async {
    return await _flutterTts.getVoices;
  }

  /// Set the language for TTS
  /// Supports: en-US, ar-SA, ur-PK, id-ID, es-ES, fr-FR
  Future<void> setLanguage(String languageCode) async {
    _language = _mapLanguageCode(languageCode);
    await _flutterTts.setLanguage(_language);
  }

  /// Map app language codes to TTS language codes
  String _mapLanguageCode(String code) {
    switch (code) {
      case 'en':
        return 'en-US';
      case 'ar':
        return 'ar-SA';
      case 'ur':
        return 'ur-PK';
      case 'id':
        return 'id-ID';
      case 'es':
        return 'es-ES';
      case 'fr':
        return 'fr-FR';
      default:
        return 'en-US';
    }
  }

  /// Set speech rate (0.0 to 1.0)
  /// Default 0.45 is slower for children's comprehension
  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate.clamp(0.0, 1.0);
    await _flutterTts.setSpeechRate(_speechRate);
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double vol) async {
    _volume = vol.clamp(0.0, 1.0);
    await _flutterTts.setVolume(_volume);
  }

  /// Set pitch (0.5 to 2.0)
  Future<void> setPitch(double p) async {
    _pitch = p.clamp(0.5, 2.0);
    await _flutterTts.setPitch(_pitch);
  }

  /// Speak the given text
  Future<void> speak(String text) async {
    _currentText = text;
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  /// Speak multiple pages of content sequentially
  Future<void> speakPages(List<String> pages, {Function(int)? onPageChange}) async {
    for (int i = 0; i < pages.length; i++) {
      if (_ttsState == TtsState.stopped) break;

      onPageChange?.call(i);
      await speak(pages[i]);

      // Wait for completion before next page
      await _waitForCompletion();
    }
  }

  Future<void> _waitForCompletion() async {
    final completer = Completer<void>();
    late StreamSubscription<TtsState> subscription;

    subscription = stateStream.listen((state) {
      if (state == TtsState.stopped) {
        subscription.cancel();
        completer.complete();
      }
    });

    // Timeout after 5 minutes per page
    return completer.future.timeout(
      const Duration(minutes: 5),
      onTimeout: () {
        subscription.cancel();
      },
    );
  }

  /// Stop speaking
  Future<void> stop() async {
    await _flutterTts.stop();
    _ttsState = TtsState.stopped;
    _stateController.add(_ttsState);
  }

  /// Pause speaking (iOS only)
  Future<void> pause() async {
    await _flutterTts.pause();
  }

  /// Check if TTS is currently speaking
  bool get isPlaying => _ttsState == TtsState.playing;

  /// Check if TTS is paused
  bool get isPaused => _ttsState == TtsState.paused;

  /// Dispose resources
  Future<void> dispose() async {
    await stop();
    await _stateController.close();
    await _progressController.close();
  }
}

/// TTS Service provider
@riverpod
TtsService ttsService(TtsServiceRef ref) {
  final service = TtsService();
  ref.onDispose(() => service.dispose());
  return service;
}

/// TTS State provider - reactive state updates
@riverpod
Stream<TtsState> ttsStateStream(TtsStateStreamRef ref) {
  final service = ref.watch(ttsServiceProvider);
  return service.stateStream;
}
