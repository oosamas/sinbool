import 'package:drift/drift.dart';

/// Audio cache table for storing pre-generated narration audio files locally
/// Audio is generated server-side with Gemini 2.5 Flash, stored in Firebase Storage,
/// and downloaded once per device.
class AudioCache extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Lesson serverId (e.g., "prophet_ayyub_lesson_1") - used to match Firebase Storage paths
  TextColumn get lessonServerId => text()();

  /// Language code (e.g., "en", "ar")
  TextColumn get language => text()();

  /// Local file path where the audio is stored on this device
  TextColumn get localFilePath => text()();

  /// Firebase Storage path for re-download if needed
  TextColumn get storagePath => text()();

  /// File size in bytes (for cache management)
  IntColumn get fileSizeBytes => integer().withDefault(const Constant(0))();

  /// Audio duration in seconds
  IntColumn get durationSeconds => integer().withDefault(const Constant(0))();

  /// When the audio was downloaded
  DateTimeColumn get downloadedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {lessonServerId, language},
      ];
}
