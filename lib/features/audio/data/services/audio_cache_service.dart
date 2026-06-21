import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/daos/audio_cache_dao.dart';
import '../../../../core/database/database_provider.dart';

part 'audio_cache_service.g.dart';

/// Service for downloading and caching pre-generated audio narrations.
///
/// Audio files are generated offline with Gemini 2.5 Flash TTS,
/// uploaded to Firebase Storage, and downloaded once per device.
class AudioCacheService {
  AudioCacheService(this._audioCacheDao);

  final AudioCacheDao _audioCacheDao;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Firebase Storage path pattern: audio/{language}/{lessonServerId}.mp3
  String _storagePath(String lessonServerId, String language) {
    return 'audio/$language/$lessonServerId.mp3';
  }

  /// Local cache directory for audio files
  Future<Directory> _cacheDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(appDir.path, 'audio_cache'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  /// Get local file path for a cached audio file
  Future<String> _localPath(String lessonServerId, String language) async {
    final dir = await _cacheDir();
    return p.join(dir.path, '${language}_$lessonServerId.mp3');
  }

  /// Check if audio is available locally (cached)
  Future<bool> isAudioCached(String lessonServerId, String language) async {
    return _audioCacheDao.isAudioCached(lessonServerId, language);
  }

  /// Get the local file path for cached audio, or null if not cached
  Future<String?> getCachedAudioPath(
      String lessonServerId, String language) async {
    final entry = await _audioCacheDao.getCachedAudio(lessonServerId, language);
    if (entry == null) return null;

    final file = File(entry.localFilePath);
    if (await file.exists()) {
      return entry.localFilePath;
    }

    // File was deleted externally, clean up DB entry
    await _audioCacheDao.deleteCacheEntry(lessonServerId, language);
    return null;
  }

  /// Check if audio exists in Firebase Storage for this lesson
  Future<bool> isAudioAvailableRemotely(
      String lessonServerId, String language) async {
    try {
      final ref = _storage.ref(_storagePath(lessonServerId, language));
      await ref.getMetadata();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Download audio from Firebase Storage and cache it locally.
  /// Returns the local file path, or null if download failed.
  ///
  /// [onProgress] callback receives download progress (0.0 to 1.0).
  Future<String?> downloadAndCache(
    String lessonServerId,
    String language, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      final storagePath = _storagePath(lessonServerId, language);
      final localPath = await _localPath(lessonServerId, language);
      final localFile = File(localPath);

      final ref = _storage.ref(storagePath);
      final metadata = await ref.getMetadata();
      final totalBytes = metadata.size ?? 0;

      // Download to local file
      final downloadTask = ref.writeToFile(localFile);

      if (onProgress != null && totalBytes > 0) {
        downloadTask.snapshotEvents.listen((event) {
          final progress = event.bytesTransferred / totalBytes;
          onProgress(progress.clamp(0.0, 1.0));
        });
      }

      await downloadTask;

      // Get file size
      final fileSize = await localFile.length();

      // Save to database
      await _audioCacheDao.upsertCacheEntry(
        lessonServerId: lessonServerId,
        language: language,
        localFilePath: localPath,
        storagePath: storagePath,
        fileSizeBytes: fileSize,
      );

      return localPath;
    } catch (_) {
      return null;
    }
  }

  /// Get audio for a lesson: returns cached path or downloads first.
  /// This is the main method to use from the UI.
  Future<String?> getAudio(
    String lessonServerId,
    String language, {
    void Function(double progress)? onProgress,
  }) async {
    // Check local cache first
    final cachedPath = await getCachedAudioPath(lessonServerId, language);
    if (cachedPath != null) return cachedPath;

    // Download from Firebase Storage
    return downloadAndCache(lessonServerId, language, onProgress: onProgress);
  }

  /// Get total cache size in bytes
  Future<int> getTotalCacheSize() => _audioCacheDao.getTotalCacheSize();

  /// Get human-readable cache size
  Future<String> getFormattedCacheSize() async {
    final bytes = await getTotalCacheSize();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Clear all cached audio
  Future<void> clearCache() => _audioCacheDao.clearAllCache();
}

/// Audio cache service provider
@Riverpod(keepAlive: true)
AudioCacheService audioCacheService(AudioCacheServiceRef ref) {
  final dao = ref.watch(audioCacheDaoProvider);
  return AudioCacheService(dao);
}
