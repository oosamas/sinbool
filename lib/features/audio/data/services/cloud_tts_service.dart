import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/security_service.dart';

part 'cloud_tts_service.g.dart';

/// Cloud TTS Service using Google Cloud Text-to-Speech
/// Provides natural WaveNet voices for storytelling
class CloudTtsService {
  CloudTtsService() {
    _initPlayer();
  }

  final Dio _dio = Dio();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Google Cloud TTS API endpoint
  static const String _apiEndpoint =
      'https://texttospeech.googleapis.com/v1/text:synthesize';

  // API key loaded from secure storage
  String? _apiKey;
  bool _initialized = false;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  String? _currentLanguage = 'en-US';

  void _initPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
    });
  }

  /// Ensure API key is loaded before use
  Future<void> ensureInitialized() async {
    if (_initialized) return;
    await _loadApiKey();
    _initialized = true;
  }

  /// Load API key from secure storage
  Future<void> _loadApiKey() async {
    _apiKey = await SecurityService.instance.readSecure(
      SecureStorageKeys.googleCloudApiKey,
    );
    if (_apiKey != null) {
      debugPrint('CloudTTS: API key loaded: ${_apiKey!.substring(0, 10)}...');
    } else {
      debugPrint('CloudTTS: No API key found in secure storage');
    }
  }

  /// Set and store the API key for Google Cloud TTS
  Future<void> setApiKey(String apiKey) async {
    _apiKey = apiKey;
    await SecurityService.instance.storeSecure(
      SecureStorageKeys.googleCloudApiKey,
      apiKey,
    );
    debugPrint('CloudTTS: API key stored securely');
  }

  /// Set the language for TTS
  void setLanguage(String languageCode) {
    _currentLanguage = _mapLanguageCode(languageCode);
  }

  /// Map app language codes to Google Cloud TTS language codes
  String _mapLanguageCode(String code) {
    switch (code) {
      case 'en':
        return 'en-US';
      case 'ar':
        return 'ar-XA'; // Arabic (Standard)
      case 'ur':
        return 'ur-PK'; // Urdu
      case 'id':
        return 'id-ID'; // Indonesian
      case 'es':
        return 'es-ES'; // Spanish
      case 'fr':
        return 'fr-FR'; // French
      default:
        return 'en-US';
    }
  }

  /// Get the best voice for the current language
  /// Uses WaveNet voices for natural sound
  Map<String, String> _getVoiceConfig(String language) {
    switch (language) {
      case 'en-US':
        return {
          'name': 'en-US-Wavenet-F', // Female, warm storytelling voice
          'ssmlGender': 'FEMALE',
        };
      case 'ar-XA':
        return {
          'name': 'ar-XA-Wavenet-A', // Arabic female
          'ssmlGender': 'FEMALE',
        };
      case 'ur-PK':
        return {
          'name': 'ur-PK-Wavenet-A', // Urdu female
          'ssmlGender': 'FEMALE',
        };
      case 'id-ID':
        return {
          'name': 'id-ID-Wavenet-A', // Indonesian female
          'ssmlGender': 'FEMALE',
        };
      case 'es-ES':
        return {
          'name': 'es-ES-Wavenet-C', // Spanish female
          'ssmlGender': 'FEMALE',
        };
      case 'fr-FR':
        return {
          'name': 'fr-FR-Wavenet-C', // French female
          'ssmlGender': 'FEMALE',
        };
      default:
        return {
          'name': 'en-US-Wavenet-F',
          'ssmlGender': 'FEMALE',
        };
    }
  }

  /// Speak text using Google Cloud TTS
  /// Returns true if successful
  Future<bool> speak(String text) async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      debugPrint('CloudTTS: No API key configured, falling back to device TTS');
      return false;
    }

    if (text.isEmpty) {
      debugPrint('CloudTTS: Empty text, nothing to speak');
      return false;
    }

    try {
      // Stop any current playback
      await stop();

      final voiceConfig = _getVoiceConfig(_currentLanguage!);

      // Prepare request body
      final requestBody = {
        'input': {'text': text},
        'voice': {
          'languageCode': _currentLanguage,
          'name': voiceConfig['name'],
          'ssmlGender': voiceConfig['ssmlGender'],
        },
        'audioConfig': {
          'audioEncoding': 'MP3',
          'speakingRate': 0.9, // Slightly slower for storytelling
          'pitch': 0.0, // Natural pitch
          'volumeGainDb': 0.0,
          'effectsProfileId': ['small-bluetooth-speaker-class-device'],
        },
      };

      debugPrint('CloudTTS: Requesting audio for ${text.length} chars');
      debugPrint('CloudTTS: Using voice ${voiceConfig['name']}');

      // Make API request
      final response = await _dio.post(
        '$_apiEndpoint?key=$_apiKey',
        data: jsonEncode(requestBody),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final audioContent = response.data['audioContent'] as String;
        final audioBytes = base64Decode(audioContent);

        // Save to temp file and play
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/tts_audio_${DateTime.now().millisecondsSinceEpoch}.mp3');
        await tempFile.writeAsBytes(audioBytes);

        debugPrint('CloudTTS: Audio saved, playing...');
        await _audioPlayer.setFilePath(tempFile.path);
        await _audioPlayer.play();

        // Clean up temp file after playback
        unawaited(
          _audioPlayer.playerStateStream.firstWhere(
            (state) => state.processingState == ProcessingState.completed,
          ).then((_) async {
            try {
              if (await tempFile.exists()) {
                await tempFile.delete();
              }
            } catch (e) {
              debugPrint('CloudTTS: Failed to delete temp file: $e');
            }
          }),
        );

        return true;
      } else {
        debugPrint('CloudTTS: API error ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('CloudTTS: Error - $e');
      return false;
    }
  }

  /// Stop playback
  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }

  /// Pause playback
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  /// Resume playback
  Future<void> resume() async {
    await _audioPlayer.play();
  }

  /// Check if API key is configured
  bool get isConfigured => _apiKey != null && _apiKey!.isNotEmpty;

  /// Dispose resources
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}

/// Cloud TTS Service provider
@riverpod
CloudTtsService cloudTtsService(CloudTtsServiceRef ref) {
  final service = CloudTtsService();
  ref.onDispose(() => service.dispose());
  return service;
}
