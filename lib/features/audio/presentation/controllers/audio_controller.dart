import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/services/audio_service.dart';
import '../../domain/entities/audio_state.dart';

part 'audio_controller.g.dart';

/// Audio controller for managing playback
/// From Issue #6 - Audio Player Feature
@riverpod
class AudioController extends _$AudioController {
  @override
  AudioState build() {
    // Listen to audio service state changes
    ref.listen(audioStateProvider, (previous, next) {
      next.when(
        data: (state) => this.state = state,
        loading: () => this.state = state.copyWith(isLoading: true),
        error: (e, _) => this.state = AudioState.error(e.toString()),
      );
    });

    return AudioState.initial;
  }

  AudioService get _audioService => ref.read(audioServiceProvider);

  /// Load and play audio
  Future<void> loadAndPlay(AudioTrack track) async {
    state = AudioState.loading(track.id);

    try {
      await _audioService.loadAudio(track.url, trackId: track.id);
      await _audioService.play();
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    try {
      if (state.isPlaying) {
        await _audioService.pause();
      } else {
        await _audioService.play();
      }
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Play
  Future<void> play() async {
    try {
      await _audioService.play();
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Pause
  Future<void> pause() async {
    try {
      await _audioService.pause();
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Stop
  Future<void> stop() async {
    try {
      await _audioService.stop();
      state = AudioState.initial;
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Seek to position
  Future<void> seekTo(Duration position) async {
    try {
      await _audioService.seek(position);
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Seek forward 10 seconds
  Future<void> seekForward() async {
    try {
      await _audioService.seekForward(const Duration(seconds: 10));
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Seek backward 10 seconds
  Future<void> seekBackward() async {
    try {
      await _audioService.seekBackward(const Duration(seconds: 10));
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Set playback speed
  Future<void> setSpeed(double speed) async {
    try {
      await _audioService.setSpeed(speed);
      state = state.copyWith(playbackSpeed: speed);
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }

  /// Cycle through playback speeds
  Future<void> cycleSpeed() async {
    const speeds = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
    final currentIndex = speeds.indexOf(state.playbackSpeed);
    final nextIndex = (currentIndex + 1) % speeds.length;
    await setSpeed(speeds[nextIndex]);
  }

  /// Set volume
  Future<void> setVolume(double volume) async {
    try {
      await _audioService.setVolume(volume);
      state = state.copyWith(volume: volume);
    } catch (e) {
      state = AudioState.error(e.toString());
    }
  }
}
