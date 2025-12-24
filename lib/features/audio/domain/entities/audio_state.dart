import 'package:flutter/material.dart';

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

  /// Create initial state
  static const initial = AudioState();

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
}

/// Audio playback mode
enum AudioMode {
  /// Story narration only (in user's language)
  narration,

  /// Quran recitation only (Arabic)
  quranRecitation,

  /// Both narration and Quran recitation
  both,
}

extension AudioModeExtension on AudioMode {
  String get displayName {
    switch (this) {
      case AudioMode.narration:
        return 'Story Narration';
      case AudioMode.quranRecitation:
        return 'Quran Recitation';
      case AudioMode.both:
        return 'Narration + Quran';
    }
  }

  String get description {
    switch (this) {
      case AudioMode.narration:
        return 'Listen to the story in your language';
      case AudioMode.quranRecitation:
        return 'Listen to Quran verses in Arabic';
      case AudioMode.both:
        return 'Full experience with narration and Quran';
    }
  }

  IconData get icon {
    switch (this) {
      case AudioMode.narration:
        return Icons.record_voice_over;
      case AudioMode.quranRecitation:
        return Icons.menu_book;
      case AudioMode.both:
        return Icons.headphones;
    }
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
    this.trackType = AudioTrackType.narration,
    this.language = 'en',
  });

  final String id;
  final String title;
  final String? titleArabic;
  final String url;
  final String? artist;
  final String? artworkUrl;
  final int? durationMs;
  final AudioTrackType trackType;
  final String language;

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

/// Type of audio track
enum AudioTrackType {
  /// Story narration
  narration,

  /// Quran recitation
  quranRecitation,
}

/// Helper class to generate audio tracks for lessons
class LessonAudioHelper {
  LessonAudioHelper._();

  /// Sample narration URLs by language
  /// In production, these would come from your backend/CDN
  static const Map<String, String> _sampleNarrationUrls = {
    'en': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    'ar': 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/002.mp3',
    'ur': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    'id': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    'es': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    'fr': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
  };

  /// Sample Quran recitation URLs (by surah number)
  static const Map<int, String> _quranRecitationUrls = {
    1: 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3',
    2: 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/002.mp3',
    3: 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/003.mp3',
    112: 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/112.mp3',
    113: 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/113.mp3',
    114: 'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/114.mp3',
  };

  /// Get narration track for a lesson in specified language
  static AudioTrack getNarrationTrack({
    required String lessonId,
    required String lessonTitle,
    required String language,
    String? lessonTitleArabic,
    int? durationMinutes,
  }) {
    final url = _sampleNarrationUrls[language] ?? _sampleNarrationUrls['en']!;
    final languageName = _getLanguageName(language);

    return AudioTrack(
      id: '${lessonId}_narration_$language',
      title: '$lessonTitle ($languageName)',
      titleArabic: lessonTitleArabic,
      url: url,
      artist: 'Sinbool Narrator',
      durationMs: (durationMinutes ?? 5) * 60 * 1000,
      trackType: AudioTrackType.narration,
      language: language,
    );
  }

  /// Get Quran recitation track
  static AudioTrack getQuranTrack({
    required String lessonId,
    required String lessonTitle,
    int surahNumber = 1,
    int? durationMinutes,
  }) {
    final url = _quranRecitationUrls[surahNumber] ?? _quranRecitationUrls[1]!;

    return AudioTrack(
      id: '${lessonId}_quran_$surahNumber',
      title: 'Quran - Surah ${_getSurahName(surahNumber)}',
      titleArabic: 'القرآن - سورة ${_getSurahNameArabic(surahNumber)}',
      url: url,
      artist: 'Mishary Rashid Alafasy',
      durationMs: (durationMinutes ?? 3) * 60 * 1000,
      trackType: AudioTrackType.quranRecitation,
      language: 'ar',
    );
  }

  /// Get all tracks for a lesson based on mode
  static List<AudioTrack> getTracksForLesson({
    required String lessonId,
    required String lessonTitle,
    required String language,
    required AudioMode mode,
    String? lessonTitleArabic,
    int? durationMinutes,
    int surahNumber = 1,
  }) {
    final tracks = <AudioTrack>[];

    switch (mode) {
      case AudioMode.narration:
        tracks.add(getNarrationTrack(
          lessonId: lessonId,
          lessonTitle: lessonTitle,
          lessonTitleArabic: lessonTitleArabic,
          language: language,
          durationMinutes: durationMinutes,
        ));
        break;
      case AudioMode.quranRecitation:
        tracks.add(getQuranTrack(
          lessonId: lessonId,
          lessonTitle: lessonTitle,
          surahNumber: surahNumber,
          durationMinutes: durationMinutes,
        ));
        break;
      case AudioMode.both:
        // Add narration first, then Quran
        tracks.add(getNarrationTrack(
          lessonId: lessonId,
          lessonTitle: lessonTitle,
          lessonTitleArabic: lessonTitleArabic,
          language: language,
          durationMinutes: durationMinutes,
        ));
        tracks.add(getQuranTrack(
          lessonId: lessonId,
          lessonTitle: lessonTitle,
          surahNumber: surahNumber,
          durationMinutes: 3,
        ));
        break;
    }

    return tracks;
  }

  static String _getLanguageName(String code) {
    const names = {
      'en': 'English',
      'ar': 'العربية',
      'ur': 'اردو',
      'id': 'Indonesia',
      'es': 'Español',
      'fr': 'Français',
    };
    return names[code] ?? 'English';
  }

  static String _getSurahName(int number) {
    const names = {
      1: 'Al-Fatiha',
      2: 'Al-Baqarah',
      3: 'Ali \'Imran',
      112: 'Al-Ikhlas',
      113: 'Al-Falaq',
      114: 'An-Nas',
    };
    return names[number] ?? 'Al-Fatiha';
  }

  static String _getSurahNameArabic(int number) {
    const names = {
      1: 'الفاتحة',
      2: 'البقرة',
      3: 'آل عمران',
      112: 'الإخلاص',
      113: 'الفلق',
      114: 'الناس',
    };
    return names[number] ?? 'الفاتحة';
  }
}
