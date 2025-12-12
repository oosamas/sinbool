/// Audio player state entity
/// From Issue #6 - Audio Player Feature
class AudioState {
  const AudioState({
    this.isPlaying = false,
    this.isLoading = false,
    this.isBuffering = false,
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.playbackSpeed = 1.0,
    this.volume = 1.0,
    this.currentTrackId,
    this.error,
  });

  final bool isPlaying;
  final bool isLoading;
  final bool isBuffering;
  final Duration currentPosition;
  final Duration totalDuration;
  final double playbackSpeed;
  final double volume;
  final String? currentTrackId;
  final String? error;

  /// Progress as percentage (0.0 - 1.0)
  double get progress =>
      totalDuration.inMilliseconds > 0
          ? currentPosition.inMilliseconds / totalDuration.inMilliseconds
          : 0.0;

  /// Remaining time
  Duration get remaining => totalDuration - currentPosition;

  /// Check if audio is ready
  bool get isReady => !isLoading && totalDuration.inMilliseconds > 0;

  /// Check if has error
  bool get hasError => error != null;

  AudioState copyWith({
    bool? isPlaying,
    bool? isLoading,
    bool? isBuffering,
    Duration? currentPosition,
    Duration? totalDuration,
    double? playbackSpeed,
    double? volume,
    String? currentTrackId,
    String? error,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      isBuffering: isBuffering ?? this.isBuffering,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      volume: volume ?? this.volume,
      currentTrackId: currentTrackId ?? this.currentTrackId,
      error: error,
    );
  }

  /// Create initial state
  static const initial = AudioState();

  /// Create loading state
  factory AudioState.loading(String trackId) {
    return AudioState(
      isLoading: true,
      currentTrackId: trackId,
    );
  }

  /// Create error state
  factory AudioState.error(String message) {
    return AudioState(error: message);
  }
}

/// Audio track information
class AudioTrack {
  const AudioTrack({
    required this.id,
    required this.title,
    required this.url,
    this.titleArabic,
    this.artist,
    this.artworkUrl,
    this.durationMs,
  });

  final String id;
  final String title;
  final String? titleArabic;
  final String url;
  final String? artist;
  final String? artworkUrl;
  final int? durationMs;

  /// Get formatted duration
  String? get formattedDuration {
    if (durationMs == null) return null;
    final duration = Duration(milliseconds: durationMs!);
    final minutes = duration.inMinutes;
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Get localized title
  String getTitle(String locale) {
    if (locale.startsWith('ar') && titleArabic != null) {
      return titleArabic!;
    }
    return title;
  }
}
