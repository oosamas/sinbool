import 'package:flutter_test/flutter_test.dart';
import 'package:sinbool/features/audio/domain/entities/audio_state.dart';

void main() {
  group('AudioState', () {
    test('should create initial state with default values', () {
      const state = AudioState.initial;

      expect(state.isPlaying, isFalse);
      expect(state.isLoading, isFalse);
      expect(state.isBuffering, isFalse);
      expect(state.currentPosition, equals(Duration.zero));
      expect(state.totalDuration, equals(Duration.zero));
      expect(state.playbackSpeed, equals(1.0));
      expect(state.volume, equals(1.0));
      expect(state.currentTrackId, isNull);
      expect(state.error, isNull);
    });

    test('should calculate progress correctly', () {
      const state = AudioState(
        currentPosition: Duration(seconds: 30),
        totalDuration: Duration(seconds: 60),
      );

      expect(state.progress, equals(0.5));
    });

    test('should return 0 progress when duration is 0', () {
      const state = AudioState(
        currentPosition: Duration(seconds: 30),
        totalDuration: Duration.zero,
      );

      expect(state.progress, equals(0.0));
    });

    test('should calculate remaining time correctly', () {
      const state = AudioState(
        currentPosition: Duration(seconds: 30),
        totalDuration: Duration(seconds: 60),
      );

      expect(state.remaining, equals(const Duration(seconds: 30)));
    });

    test('should identify ready state correctly', () {
      const loadingState = AudioState(isLoading: true);
      const readyState = AudioState(
        isLoading: false,
        totalDuration: Duration(seconds: 60),
      );

      expect(loadingState.isReady, isFalse);
      expect(readyState.isReady, isTrue);
    });

    test('should identify error state correctly', () {
      const normalState = AudioState();
      const errorState = AudioState(error: 'Something went wrong');

      expect(normalState.hasError, isFalse);
      expect(errorState.hasError, isTrue);
    });

    test('should create loading state with track ID', () {
      final state = AudioState.loading('track-123');

      expect(state.isLoading, isTrue);
      expect(state.currentTrackId, equals('track-123'));
    });

    test('should create error state with message', () {
      final state = AudioState.error('Network error');

      expect(state.error, equals('Network error'));
      expect(state.hasError, isTrue);
    });

    test('copyWith should preserve values when not specified', () {
      const state = AudioState(
        isPlaying: true,
        playbackSpeed: 1.5,
        volume: 0.8,
      );

      final newState = state.copyWith(isPlaying: false);

      expect(newState.isPlaying, isFalse);
      expect(newState.playbackSpeed, equals(1.5));
      expect(newState.volume, equals(0.8));
    });
  });

  group('AudioTrack', () {
    test('should create track with required fields', () {
      const track = AudioTrack(
        id: 'track-1',
        title: 'Test Track',
        url: 'https://example.com/audio.mp3',
      );

      expect(track.id, equals('track-1'));
      expect(track.title, equals('Test Track'));
      expect(track.url, equals('https://example.com/audio.mp3'));
    });

    test('should return localized title for English', () {
      const track = AudioTrack(
        id: 'track-1',
        title: 'English Title',
        titleArabic: 'العنوان العربي',
        url: 'https://example.com/audio.mp3',
      );

      expect(track.getTitle('en'), equals('English Title'));
    });

    test('should return Arabic title for Arabic locale', () {
      const track = AudioTrack(
        id: 'track-1',
        title: 'English Title',
        titleArabic: 'العنوان العربي',
        url: 'https://example.com/audio.mp3',
      );

      expect(track.getTitle('ar'), equals('العنوان العربي'));
    });

    test('should format duration correctly', () {
      const track = AudioTrack(
        id: 'track-1',
        title: 'Test Track',
        url: 'https://example.com/audio.mp3',
        durationMs: 125000, // 2:05
      );

      expect(track.formattedDuration, equals('2:05'));
    });

    test('should return null formatted duration when not set', () {
      const track = AudioTrack(
        id: 'track-1',
        title: 'Test Track',
        url: 'https://example.com/audio.mp3',
      );

      expect(track.formattedDuration, isNull);
    });
  });
}
