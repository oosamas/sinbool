import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/bookmarks_dao.dart';
import '../../../../core/database/daos/progress_dao.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/services/error_handler_service.dart';
import '../services/firestore_sync_service.dart';

part 'sync_repository.g.dart';

/// Repository for syncing local data with Firestore
class SyncRepository {
  SyncRepository(this._progressDao, this._bookmarksDao, this._firestoreService);

  final ProgressDao _progressDao;
  final BookmarksDao _bookmarksDao;
  final FirestoreSyncService _firestoreService;

  /// Full sync: download from cloud, merge locally, then upload
  Future<void> fullSync(String userId) async {
    await _syncProgressFromCloud(userId);
    await _syncBookmarksFromCloud(userId);
    await _syncProgressToCloud(userId);
    await _syncBookmarksToCloud(userId);
    await _firestoreService.writeSyncMetadata(userId, {
      'lastSyncAt': FieldValue.serverTimestamp(),
      'appVersion': '1.0.0',
    });
  }

  /// Upload local progress to cloud
  Future<void> _syncProgressToCloud(String userId) async {
    try {
      // Upload user progress
      final userProgress = await _progressDao.getUserProgress();
      await _firestoreService.writeUserProgress(userId, {
        'totalLessonsCompleted': userProgress.totalLessonsCompleted,
        'totalQuizzesPassed': userProgress.totalQuizzesPassed,
        'currentStreak': userProgress.currentStreak,
        'longestStreak': userProgress.longestStreak,
        'totalTimeMinutes': userProgress.totalTimeMinutes,
        'lastActivityDate': userProgress.lastActivityDate?.toIso8601String(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Upload lesson progress
      final allLessons = await _getAllLessonProgress();
      if (allLessons.isNotEmpty) {
        await _firestoreService.writeLessonProgress(userId, allLessons);
      }
    } catch (e) {
      ErrorHandlerService.instance.error('Failed to sync progress to cloud', e);
      rethrow;
    }
  }

  /// Download cloud progress and merge with local
  Future<void> _syncProgressFromCloud(String userId) async {
    try {
      // Merge user progress (take max values)
      final cloudProgress = await _firestoreService.readUserProgress(userId);
      if (cloudProgress != null) {
        final localProgress = await _progressDao.getUserProgress();
        await _progressDao.updateUserProgress(UserProgressCompanion(
          totalLessonsCompleted: Value(max(
            localProgress.totalLessonsCompleted,
            (cloudProgress['totalLessonsCompleted'] as int?) ?? 0,
          )),
          totalQuizzesPassed: Value(max(
            localProgress.totalQuizzesPassed,
            (cloudProgress['totalQuizzesPassed'] as int?) ?? 0,
          )),
          currentStreak: Value(max(
            localProgress.currentStreak,
            (cloudProgress['currentStreak'] as int?) ?? 0,
          )),
          longestStreak: Value(max(
            localProgress.longestStreak,
            (cloudProgress['longestStreak'] as int?) ?? 0,
          )),
          totalTimeMinutes: Value(max(
            localProgress.totalTimeMinutes,
            (cloudProgress['totalTimeMinutes'] as int?) ?? 0,
          )),
          updatedAt: Value(DateTime.now()),
        ));
      }

      // Merge lesson progress
      final cloudLessons = await _firestoreService.readLessonProgress(userId);
      for (final cloudLesson in cloudLessons) {
        final lessonId = cloudLesson['lessonId'] as int;
        final localLesson = await _progressDao.getLessonProgress(lessonId);

        if (localLesson == null) {
          // Cloud has progress that local doesn't - create it
          await _progressDao.getOrCreateLessonProgress(lessonId);
          await _progressDao.updateLessonProgress(
            lessonId,
            LessonProgressCompanion(
              isCompleted: Value(cloudLesson['isCompleted'] as bool? ?? false),
              lastPageViewed: Value(cloudLesson['lastPageViewed'] as int? ?? 0),
              quizScore: Value(cloudLesson['quizScore'] as int?),
              quizAttempts: Value(cloudLesson['quizAttempts'] as int? ?? 0),
              timeSpentMinutes: Value(cloudLesson['timeSpentMinutes'] as int? ?? 0),
              updatedAt: Value(DateTime.now()),
            ),
          );
        } else {
          // Both exist - merge (take max/best values)
          final cloudCompleted = cloudLesson['isCompleted'] as bool? ?? false;
          final mergedCompleted = localLesson.isCompleted || cloudCompleted;

          await _progressDao.updateLessonProgress(
            lessonId,
            LessonProgressCompanion(
              isCompleted: Value(mergedCompleted),
              lastPageViewed: Value(max(
                localLesson.lastPageViewed,
                (cloudLesson['lastPageViewed'] as int?) ?? 0,
              )),
              quizScore: Value(max(
                localLesson.quizScore ?? 0,
                (cloudLesson['quizScore'] as int?) ?? 0,
              )),
              quizAttempts: Value(max(
                localLesson.quizAttempts,
                (cloudLesson['quizAttempts'] as int?) ?? 0,
              )),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }
    } catch (e) {
      ErrorHandlerService.instance.error('Failed to sync progress from cloud', e);
      rethrow;
    }
  }

  /// Upload local bookmarks to cloud
  Future<void> _syncBookmarksToCloud(String userId) async {
    try {
      final bookmarks = await _bookmarksDao.getAllBookmarks();
      final bookmarkData = bookmarks.map((b) => {
            'lessonId': b.bookmark.lessonId,
            'note': b.bookmark.note,
            'createdAt': b.bookmark.createdAt.toIso8601String(),
          }).toList();

      if (bookmarkData.isNotEmpty) {
        await _firestoreService.writeBookmarks(userId, bookmarkData);
      }
    } catch (e) {
      ErrorHandlerService.instance.error('Failed to sync bookmarks to cloud', e);
      rethrow;
    }
  }

  /// Download cloud bookmarks and merge with local
  Future<void> _syncBookmarksFromCloud(String userId) async {
    try {
      final cloudBookmarks = await _firestoreService.readBookmarks(userId);

      for (final cloudBookmark in cloudBookmarks) {
        final lessonId = cloudBookmark['lessonId'] as int;
        final isBookmarked = await _bookmarksDao.isLessonBookmarked(lessonId);

        if (!isBookmarked) {
          // Cloud has bookmark that local doesn't - add it
          final note = cloudBookmark['note'] as String?;
          await _bookmarksDao.addBookmark(lessonId, note: note);
        }
      }
    } catch (e) {
      ErrorHandlerService.instance.error('Failed to sync bookmarks from cloud', e);
      rethrow;
    }
  }

  /// Helper to get all lesson progress as maps
  Future<List<Map<String, dynamic>>> _getAllLessonProgress() async {
    // We need to access the database directly for a bulk read
    // This is a pragmatic approach using the DAO's existing methods
    final result = <Map<String, dynamic>>[];

    // Get all lessons that have progress
    final db = _progressDao.attachedDatabase;
    final rows = await db.select(db.lessonProgress).get();

    for (final row in rows) {
      result.add({
        'lessonId': row.lessonId,
        'isCompleted': row.isCompleted,
        'lastPageViewed': row.lastPageViewed,
        'quizScore': row.quizScore,
        'quizAttempts': row.quizAttempts,
        'timeSpentMinutes': row.timeSpentMinutes,
        'startedAt': row.startedAt?.toIso8601String(),
        'completedAt': row.completedAt?.toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      });
    }

    return result;
  }
}

/// Firestore instance provider
@Riverpod(keepAlive: true)
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

/// Firestore sync service provider
@Riverpod(keepAlive: true)
FirestoreSyncService firestoreSyncService(FirestoreSyncServiceRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return FirestoreSyncService(firestore);
}

/// Sync repository provider
@Riverpod(keepAlive: true)
SyncRepository syncRepository(SyncRepositoryRef ref) {
  final progressDao = ref.watch(progressDaoProvider);
  final bookmarksDao = ref.watch(bookmarksDaoProvider);
  final firestoreService = ref.watch(firestoreSyncServiceProvider);
  return SyncRepository(progressDao, bookmarksDao, firestoreService);
}
