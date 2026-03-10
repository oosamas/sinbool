import 'package:cloud_firestore/cloud_firestore.dart';

/// Low-level Firestore read/write operations for syncing
class FirestoreSyncService {
  FirestoreSyncService(this._firestore);

  final FirebaseFirestore _firestore;

  /// Get the user document reference
  DocumentReference _userDoc(String userId) =>
      _firestore.collection('users').doc(userId);

  /// Write user progress to Firestore
  Future<void> writeUserProgress(
    String userId,
    Map<String, dynamic> data,
  ) async {
    await _userDoc(userId)
        .collection('progress')
        .doc('user_progress')
        .set(data, SetOptions(merge: true));
  }

  /// Read user progress from Firestore
  Future<Map<String, dynamic>?> readUserProgress(String userId) async {
    final doc = await _userDoc(userId)
        .collection('progress')
        .doc('user_progress')
        .get();
    return doc.data();
  }

  /// Write lesson progress (batch)
  Future<void> writeLessonProgress(
    String userId,
    List<Map<String, dynamic>> lessons,
  ) async {
    final batch = _firestore.batch();

    // Use a subcollection for individual lesson progress
    for (final lesson in lessons) {
      final lessonId = lesson['lessonId'] as int;
      final docRef = _userDoc(userId)
          .collection('lesson_progress')
          .doc(lessonId.toString());
      batch.set(docRef, lesson, SetOptions(merge: true));
    }

    await batch.commit();
  }

  /// Read all lesson progress from Firestore
  Future<List<Map<String, dynamic>>> readLessonProgress(String userId) async {
    final snapshot = await _userDoc(userId)
        .collection('lesson_progress')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Write bookmarks (batch)
  Future<void> writeBookmarks(
    String userId,
    List<Map<String, dynamic>> bookmarks,
  ) async {
    final batch = _firestore.batch();

    for (final bookmark in bookmarks) {
      final lessonId = bookmark['lessonId'] as int;
      final docRef = _userDoc(userId)
          .collection('bookmarks')
          .doc(lessonId.toString());
      batch.set(docRef, bookmark, SetOptions(merge: true));
    }

    await batch.commit();
  }

  /// Read all bookmarks from Firestore
  Future<List<Map<String, dynamic>>> readBookmarks(String userId) async {
    final snapshot = await _userDoc(userId)
        .collection('bookmarks')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Delete a bookmark from Firestore
  Future<void> deleteBookmark(String userId, int lessonId) async {
    await _userDoc(userId)
        .collection('bookmarks')
        .doc(lessonId.toString())
        .delete();
  }

  /// Write sync metadata
  Future<void> writeSyncMetadata(String userId, Map<String, dynamic> data) async {
    await _userDoc(userId)
        .collection('settings')
        .doc('sync_metadata')
        .set(data, SetOptions(merge: true));
  }
}
