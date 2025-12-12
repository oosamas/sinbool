import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/audio_state.dart';

part 'audio_service.g.dart';

/// Audio playback service using just_audio
/// From Issue #6 - Audio Player Feature
class AudioService {
  AudioService() : _player = AudioPlayer();

  final AudioPlayer _player;
  String? _currentTrackId;

  /// Get current audio state stream
  Stream<AudioState> get stateStream {
    return _player.playerStateStream.asyncMap((playerState) async {
      final position = _player.position;
      final duration = _player.duration ?? Duration.zero;

      return AudioState(
        isPlaying: playerState.playing,
        isLoading: playerState.processingState == ProcessingState.loading,
        isBuffering: playerState.processingState == ProcessingState.buffering,
        currentPosition: position,
        totalDuration: duration,
        playbackSpeed: _player.speed,
        volume: _player.volume,
        currentTrackId: _currentTrackId,
      );
    });
  }

  /// Get position stream
  Stream<Duration> get positionStream => _player.positionStream;

  /// Get duration stream
  Stream<Duration?> get durationStream => _player.durationStream;

  /// Load audio from URL
  Future<Duration?> loadAudio(String url, {String? trackId}) async {
    _currentTrackId = trackId;
    try {
      final duration = await _player.setUrl(url);
      return duration;
    } catch (e) {
      throw AudioException('Failed to load audio: $e');
    }
  }

  /// Load audio from asset
  Future<Duration?> loadAsset(String assetPath, {String? trackId}) async {
    _currentTrackId = trackId;
    try {
      final duration = await _player.setAsset(assetPath);
      return duration;
    } catch (e) {
      throw AudioException('Failed to load audio asset: $e');
    }
  }

  /// Play audio
  Future<void> play() async {
    try {
      await _player.play();
    } catch (e) {
      throw AudioException('Failed to play audio: $e');
    }
  }

  /// Pause audio
  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      throw AudioException('Failed to pause audio: $e');
    }
  }

  /// Stop audio
  Future<void> stop() async {
    try {
      await _player.stop();
      _currentTrackId = null;
    } catch (e) {
      throw AudioException('Failed to stop audio: $e');
    }
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e) {
      throw AudioException('Failed to seek: $e');
    }
  }

  /// Seek forward by duration
  Future<void> seekForward(Duration amount) async {
    final newPosition = _player.position + amount;
    final maxPosition = _player.duration ?? Duration.zero;
    await seek(newPosition > maxPosition ? maxPosition : newPosition);
  }

  /// Seek backward by duration
  Future<void> seekBackward(Duration amount) async {
    final newPosition = _player.position - amount;
    await seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  /// Set playback speed
  Future<void> setSpeed(double speed) async {
    try {
      await _player.setSpeed(speed);
    } catch (e) {
      throw AudioException('Failed to set speed: $e');
    }
  }

  /// Set volume (0.0 - 1.0)
  Future<void> setVolume(double volume) async {
    try {
      await _player.setVolume(volume.clamp(0.0, 1.0));
    } catch (e) {
      throw AudioException('Failed to set volume: $e');
    }
  }

  /// Get current position
  Duration get currentPosition => _player.position;

  /// Get total duration
  Duration? get totalDuration => _player.duration;

  /// Check if playing
  bool get isPlaying => _player.playing;

  /// Dispose player
  Future<void> dispose() async {
    await _player.dispose();
  }
}

/// Audio service exception
class AudioException implements Exception {
  AudioException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Audio service provider
@Riverpod(keepAlive: true)
AudioService audioService(AudioServiceRef ref) {
  final service = AudioService();
  ref.onDispose(() => service.dispose());
  return service;
}

/// Audio state provider
@riverpod
Stream<AudioState> audioState(AudioStateRef ref) {
  final service = ref.watch(audioServiceProvider);
  return service.stateStream;
}
