import 'dart:io';

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/audio_cache_table.dart';

part 'audio_cache_dao.g.dart';

/// DAO for audio cache operations
@DriftAccessor(tables: [AudioCache])
class AudioCacheDao extends DatabaseAccessor<AppDatabase>
    with _$AudioCacheDaoMixin {
  AudioCacheDao(super.db);

  /// Get cached audio for a lesson + language
  Future<AudioCacheData?> getCachedAudio(
      String lessonServerId, String language) {
    return (select(audioCache)
          ..where((t) =>
              t.lessonServerId.equals(lessonServerId) &
              t.language.equals(language)))
        .getSingleOrNull();
  }

  /// Check if audio is cached and the local file still exists
  Future<bool> isAudioCached(String lessonServerId, String language) async {
    final entry = await getCachedAudio(lessonServerId, language);
    if (entry == null) return false;
    return File(entry.localFilePath).existsSync();
  }

  /// Insert or update a cache entry
  Future<void> upsertCacheEntry({
    required String lessonServerId,
    required String language,
    required String localFilePath,
    required String storagePath,
    int fileSizeBytes = 0,
    int durationSeconds = 0,
  }) async {
    await into(audioCache).insertOnConflictUpdate(
      AudioCacheCompanion.insert(
        lessonServerId: lessonServerId,
        language: language,
        localFilePath: localFilePath,
        storagePath: storagePath,
        fileSizeBytes: Value(fileSizeBytes),
        durationSeconds: Value(durationSeconds),
      ),
    );
  }

  /// Delete a cache entry and its local file
  Future<void> deleteCacheEntry(String lessonServerId, String language) async {
    final entry = await getCachedAudio(lessonServerId, language);
    if (entry != null) {
      final file = File(entry.localFilePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await (delete(audioCache)
          ..where((t) =>
              t.lessonServerId.equals(lessonServerId) &
              t.language.equals(language)))
        .go();
  }

  /// Get total cache size in bytes
  Future<int> getTotalCacheSize() async {
    final sum = audioCache.fileSizeBytes.sum();
    final query = selectOnly(audioCache)..addColumns([sum]);
    final result = await query.getSingle();
    return result.read(sum) ?? 0;
  }

  /// Get all cache entries
  Future<List<AudioCacheData>> getAllCacheEntries() {
    return select(audioCache).get();
  }

  /// Clear all audio cache (delete files + DB entries)
  Future<void> clearAllCache() async {
    final entries = await getAllCacheEntries();
    for (final entry in entries) {
      final file = File(entry.localFilePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await delete(audioCache).go();
  }
}
