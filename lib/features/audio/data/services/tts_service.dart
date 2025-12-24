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
/// Uses premium voices for natural storytelling experience
class TtsService {
  TtsService() {
    _initTts();
  }

  final FlutterTts _flutterTts = FlutterTts();

  TtsState _ttsState = TtsState.stopped;
  TtsState get ttsState => _ttsState;

  String? _currentText;
  String? get currentText => _currentText;

  // Natural speech rate - not too slow, not too fast
  double _speechRate = 0.5;
  double get speechRate => _speechRate;

  double _volume = 1.0;
  double get volume => _volume;

  // Natural pitch - slightly warm tone
  double _pitch = 1.0;
  double get pitch => _pitch;

  String _language = 'en-US';
  String get language => _language;

  String? _currentVoice;
  String? get currentVoice => _currentVoice;

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
        // Use playback category for best audio quality
        await _flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.playback,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
          ],
          IosTextToSpeechAudioMode.defaultMode,
        );

        // Select best available voice for storytelling
        await _selectBestVoice();
      }

      if (Platform.isAndroid) {
        await _flutterTts.setQueueMode(1);
        // On Android, try to use Google's neural voices
        await _selectBestVoice();
      }
    }

    // Set default values for natural speech
    await _flutterTts.setSpeechRate(_speechRate);
    await _flutterTts.setVolume(_volume);
    await _flutterTts.setPitch(_pitch);
    await _flutterTts.setLanguage(_language);
  }

  /// Select the best available voice for natural storytelling
  Future<void> _selectBestVoice() async {
    try {
      final voices = await _flutterTts.getVoices as List<dynamic>;

      // Preferred voices for natural English storytelling (iOS)
      // These are premium/enhanced voices that sound more natural
      final preferredVoices = [
        // iOS Premium voices (need to be downloaded in Settings > Accessibility > Spoken Content)
        'Samantha (Enhanced)', // Very natural American female
        'com.apple.voice.enhanced.en-US.Samantha',
        'com.apple.ttsbundle.Samantha-premium',
        'Samantha',
        'Evan (Enhanced)', // Natural American male
        'com.apple.voice.enhanced.en-US.Evan',
        'Evan',
        'Allison (Enhanced)', // Another natural option
        'com.apple.voice.enhanced.en-US.Allison',
        'Allison',
        // Android Google TTS neural voices
        'en-us-x-tpc-network', // Google US English (natural)
        'en-us-x-tpd-network',
        'en-us-x-tpf-network',
        'en-us-x-sfg-network',
      ];

      String? selectedVoice;

      for (final preferred in preferredVoices) {
        for (final voice in voices) {
          final voiceName = voice['name']?.toString() ?? '';
          final voiceId = voice['identifier']?.toString() ?? '';

          if (voiceName.toLowerCase().contains(preferred.toLowerCase()) ||
              voiceId.toLowerCase().contains(preferred.toLowerCase())) {
            selectedVoice = voiceName.isNotEmpty ? voiceName : voiceId;
            break;
          }
        }
        if (selectedVoice != null) break;
      }

      if (selectedVoice != null) {
        await _flutterTts.setVoice({'name': selectedVoice, 'locale': 'en-US'});
        _currentVoice = selectedVoice;
        debugPrint('TTS: Selected premium voice: $selectedVoice');
      } else {
        // Fall back to default en-US voice
        debugPrint('TTS: Using default voice (no premium voice found)');
        debugPrint('TTS: Available voices: ${voices.take(10)}');
      }
    } catch (e) {
      debugPrint('TTS: Error selecting voice: $e');
    }
  }

  /// Get available languages
  Future<List<dynamic>> getLanguages() async {
    return await _flutterTts.getLanguages;
  }

  /// Get available voices
  Future<List<dynamic>> getVoices() async {
    return await _flutterTts.getVoices;
  }

  /// Set the language for TTS and select best voice
  /// Supports: en-US, ar-SA, ur-PK, id-ID, es-ES, fr-FR
  Future<void> setLanguage(String languageCode) async {
    _language = _mapLanguageCode(languageCode);
    await _flutterTts.setLanguage(_language);
    // Select best voice for this language
    await _selectBestVoiceForLanguage(_language);
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

  /// Select the best voice for a specific language
  Future<void> _selectBestVoiceForLanguage(String locale) async {
    try {
      final voices = await _flutterTts.getVoices as List<dynamic>;
      final localePrefix = locale.split('-')[0].toLowerCase();

      // Find premium/enhanced voices for this locale
      final localeVoices = voices.where((voice) {
        final voiceLocale = (voice['locale'] ?? '').toString().toLowerCase();
        return voiceLocale.startsWith(localePrefix);
      }).toList();

      if (localeVoices.isEmpty) {
        debugPrint('TTS: No voices found for locale $locale');
        return;
      }

      // Prefer enhanced/premium voices
      dynamic bestVoice;
      for (final voice in localeVoices) {
        final name = (voice['name'] ?? '').toString().toLowerCase();
        final id = (voice['identifier'] ?? '').toString().toLowerCase();
        if (name.contains('enhanced') || name.contains('premium') ||
            id.contains('enhanced') || id.contains('premium') ||
            id.contains('compact') == false) {
          bestVoice = voice;
          break;
        }
      }

      // If no premium voice, use first available
      bestVoice ??= localeVoices.first;

      final voiceName = bestVoice['name']?.toString() ?? '';
      if (voiceName.isNotEmpty) {
        await _flutterTts.setVoice({'name': voiceName, 'locale': locale});
        _currentVoice = voiceName;
        debugPrint('TTS: Selected voice "$voiceName" for $locale');
      }
    } catch (e) {
      debugPrint('TTS: Error selecting voice for $locale: $e');
    }
  }

  /// Set speech rate (0.0 to 1.0)
  /// Default 0.5 for natural conversational pace
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
