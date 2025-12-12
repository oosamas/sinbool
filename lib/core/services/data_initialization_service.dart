import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/chapters/data/repositories/chapter_repository.dart';
import '../../features/lessons/data/repositories/lesson_repository.dart';
import '../database/database_provider.dart';

part 'data_initialization_service.g.dart';

/// Service for initializing sample data
/// From Issue #5 - Content Domain
class DataInitializationService {
  DataInitializationService(this._chapterRepo, this._lessonRepo);

  final ChapterRepository _chapterRepo;
  final LessonRepository _lessonRepo;

  /// Initialize sample data for development
  Future<void> initializeSampleData() async {
    // Insert sample chapters
    await _chapterRepo.insertSampleData();

    // Get all chapters and insert lessons for each
    final chapters = await _chapterRepo.getAllChapters();
    for (final chapter in chapters) {
      await _lessonRepo.insertSampleLessons(chapter.id, chapter.serverId);

      // Get lessons and insert content/quiz for first lesson
      final lessons = await _lessonRepo.getLessonsForChapter(chapter.id);
      if (lessons.isNotEmpty) {
        await _lessonRepo.insertSampleContent(lessons.first.id);
        if (lessons.first.hasQuiz) {
          await _lessonRepo.insertSampleQuiz(lessons.first.id);
        }
      }
    }
  }
}

/// Data initialization service provider
@riverpod
DataInitializationService dataInitializationService(
  DataInitializationServiceRef ref,
) {
  final chapterRepo = ref.watch(chapterRepositoryProvider);
  final lessonRepo = ref.watch(lessonRepositoryProvider);
  return DataInitializationService(chapterRepo, lessonRepo);
}

/// Initialize data on app start
@riverpod
Future<void> initializeData(InitializeDataRef ref) async {
  final service = ref.watch(dataInitializationServiceProvider);
  await service.initializeSampleData();
}
