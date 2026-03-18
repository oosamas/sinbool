import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/entities/lesson_entity.dart';

part 'lesson_repository.g.dart';

/// Repository for lesson data operations
/// From Issue #5 - Content Domain
class LessonRepository {
  LessonRepository(this._db);

  final AppDatabase _db;

  /// Get lessons for a chapter
  Future<List<LessonEntity>> getLessonsForChapter(int chapterId) async {
    final lessons = await (_db.select(_db.lessons)
          ..where((t) => t.chapterId.equals(chapterId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();

    final entities = <LessonEntity>[];
    for (final lesson in lessons) {
      final progress = await _getProgress(lesson.id);
      entities.add(_mapToEntity(lesson, progress));
    }
    return entities;
  }

  /// Watch lessons for a chapter
  Stream<List<LessonEntity>> watchLessonsForChapter(int chapterId) {
    return (_db.select(_db.lessons)
          ..where((t) => t.chapterId.equals(chapterId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch()
        .asyncMap((lessons) async {
      final entities = <LessonEntity>[];
      for (final lesson in lessons) {
        final progress = await _getProgress(lesson.id);
        entities.add(_mapToEntity(lesson, progress));
      }
      return entities;
    });
  }

  /// Get lesson by ID
  Future<LessonEntity?> getLessonById(int id) async {
    final lesson = await (_db.select(_db.lessons)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (lesson == null) return null;
    final progress = await _getProgress(lesson.id);
    return _mapToEntity(lesson, progress);
  }

  /// Get lesson by server ID
  Future<LessonEntity?> getLessonByServerId(String serverId) async {
    final lesson = await (_db.select(_db.lessons)
          ..where((t) => t.serverId.equals(serverId)))
        .getSingleOrNull();
    if (lesson == null) return null;
    final progress = await _getProgress(lesson.id);
    return _mapToEntity(lesson, progress);
  }

  /// Get content for a lesson
  Future<List<LessonContentEntity>> getContentForLesson(int lessonId) async {
    final content = await (_db.select(_db.lessonContent)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]))
        .get();

    return content.map(_mapContentToEntity).toList();
  }

  /// Get quiz questions for a lesson
  Future<List<QuizQuestionEntity>> getQuizForLesson(int lessonId) async {
    final questions = await (_db.select(_db.quizQuestions)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();

    return questions.map(_mapQuizToEntity).toList();
  }

  /// Mark lesson as started
  Future<void> markLessonStarted(int lessonId) async {
    final existing = await (_db.select(_db.lessonProgress)
          ..where((t) => t.lessonId.equals(lessonId)))
        .getSingleOrNull();

    if (existing == null) {
      await _db.into(_db.lessonProgress).insert(
            LessonProgressCompanion.insert(
              lessonId: lessonId,
              startedAt: Value(DateTime.now()),
            ),
          );
    }
  }

  /// Update last page viewed
  Future<void> updateLastPage(int lessonId, int pageNumber) async {
    await markLessonStarted(lessonId);
    await (_db.update(_db.lessonProgress)
          ..where((t) => t.lessonId.equals(lessonId)))
        .write(LessonProgressCompanion(
      lastPageViewed: Value(pageNumber),
      updatedAt: Value(DateTime.now()),
    ));
  }

  /// Mark lesson as completed
  Future<void> markLessonCompleted(int lessonId) async {
    await markLessonStarted(lessonId);
    await (_db.update(_db.lessonProgress)
          ..where((t) => t.lessonId.equals(lessonId)))
        .write(LessonProgressCompanion(
      isCompleted: const Value(true),
      completedAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ));
  }

  /// Insert sample lessons for a chapter
  Future<void> insertSampleLessons(int chapterId, String chapterServerId) async {
    final existing = await (_db.select(_db.lessons)
          ..where((t) => t.chapterId.equals(chapterId)))
        .get();
    if (existing.isNotEmpty) return;

    await _db.batch((batch) {
      batch.insertAll(_db.lessons, [
        LessonsCompanion.insert(
          serverId: '$chapterServerId-intro',
          chapterId: chapterId,
          title: 'Introduction',
          titleArabic: const Value('المقدمة'),
          subtitle: const Value('Learn about the background'),
          subtitleArabic: const Value('تعرف على الخلفية'),
          sortOrder: const Value(1),
          durationMinutes: const Value(5),
          hasAudio: const Value(true),
        ),
        LessonsCompanion.insert(
          serverId: '$chapterServerId-part1',
          chapterId: chapterId,
          title: 'Part 1: The Beginning',
          titleArabic: const Value('الجزء الأول: البداية'),
          subtitle: const Value('How the story starts'),
          subtitleArabic: const Value('كيف تبدأ القصة'),
          sortOrder: const Value(2),
          durationMinutes: const Value(8),
          hasAudio: const Value(true),
          hasQuiz: const Value(true),
        ),
        LessonsCompanion.insert(
          serverId: '$chapterServerId-part2',
          chapterId: chapterId,
          title: 'Part 2: The Journey',
          titleArabic: const Value('الجزء الثاني: الرحلة'),
          subtitle: const Value('Following the path'),
          subtitleArabic: const Value('اتباع الطريق'),
          sortOrder: const Value(3),
          durationMinutes: const Value(10),
          hasAudio: const Value(true),
        ),
        LessonsCompanion.insert(
          serverId: '$chapterServerId-part3',
          chapterId: chapterId,
          title: 'Part 3: The Trials',
          titleArabic: const Value('الجزء الثالث: الابتلاءات'),
          subtitle: const Value('Overcoming difficulties'),
          subtitleArabic: const Value('التغلب على الصعوبات'),
          sortOrder: const Value(4),
          durationMinutes: const Value(12),
          hasAudio: const Value(true),
          hasQuiz: const Value(true),
        ),
        LessonsCompanion.insert(
          serverId: '$chapterServerId-conclusion',
          chapterId: chapterId,
          title: 'Conclusion: Lessons Learned',
          titleArabic: const Value('الخاتمة: العبر والدروس'),
          subtitle: const Value('What we can learn'),
          subtitleArabic: const Value('ما يمكننا تعلمه'),
          sortOrder: const Value(5),
          durationMinutes: const Value(7),
          hasAudio: const Value(true),
          hasQuiz: const Value(true),
        ),
      ]);
    });
  }

  /// Insert sample content for a lesson
  Future<void> insertSampleContent(int lessonId) async {
    final existing = await (_db.select(_db.lessonContent)
          ..where((t) => t.lessonId.equals(lessonId)))
        .get();
    if (existing.isNotEmpty) return;

    await _db.batch((batch) {
      batch.insertAll(_db.lessonContent, [
        LessonContentCompanion.insert(
          lessonId: lessonId,
          pageNumber: 1,
          contentText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
          translation: const Value(
              'In the name of Allah, the Most Gracious, the Most Merciful'),
          imageDescription: const Value('Opening page with Islamic calligraphy'),
        ),
        LessonContentCompanion.insert(
          lessonId: lessonId,
          pageNumber: 2,
          contentText:
              'Long ago, in a land far away, there lived a righteous man who '
              'always remembered Allah in everything he did.',
          imageDescription: const Value('A peaceful village scene'),
        ),
        LessonContentCompanion.insert(
          lessonId: lessonId,
          pageNumber: 3,
          contentText:
              'He would pray five times a day and always help those in need. '
              'His kindness was known throughout the land.',
          imageDescription: const Value('Man praying at sunset'),
        ),
        LessonContentCompanion.insert(
          lessonId: lessonId,
          pageNumber: 4,
          contentText:
              'One day, Allah decided to test his faith with a great trial. '
              'But he remained patient and trusted in Allah\'s plan.',
          imageDescription: const Value('Stormy clouds gathering'),
        ),
        LessonContentCompanion.insert(
          lessonId: lessonId,
          pageNumber: 5,
          contentText:
              'Through patience and prayer, he overcame every challenge. '
              'Allah rewarded him for his unwavering faith.',
          imageDescription: const Value('Beautiful sunrise'),
        ),
        LessonContentCompanion.insert(
          lessonId: lessonId,
          pageNumber: 6,
          contentText:
              'The moral of this story teaches us that with faith and patience, '
              'we can overcome any difficulty in life.',
          imageDescription: const Value('Peaceful ending scene'),
        ),
      ]);
    });
  }

  /// Insert sample quiz questions for a lesson
  Future<void> insertSampleQuiz(int lessonId) async {
    final existing = await (_db.select(_db.quizQuestions)
          ..where((t) => t.lessonId.equals(lessonId)))
        .get();
    if (existing.isNotEmpty) return;

    await _db.batch((batch) {
      batch.insertAll(_db.quizQuestions, [
        QuizQuestionsCompanion.insert(
          lessonId: lessonId,
          question: 'What is the most important thing the story teaches us?',
          questionArabic:
              const Value('ما هو أهم شيء تعلمنا إياه القصة؟'),
          options: jsonEncode([
            'To be kind to others',
            'To have faith and patience',
            'To be rich',
            'To travel far'
          ]),
          optionsArabic: const Value(
              '["أن نكون لطفاء مع الآخرين","أن نتحلى بالإيمان والصبر","أن نكون أغنياء","أن نسافر بعيداً"]'),
          correctIndex: 1,
          sortOrder: const Value(1),
        ),
        QuizQuestionsCompanion.insert(
          lessonId: lessonId,
          question: 'How many times a day should Muslims pray?',
          questionArabic: const Value('كم مرة في اليوم يجب أن يصلي المسلمون؟'),
          options: jsonEncode(['3 times', '4 times', '5 times', '2 times']),
          optionsArabic:
              const Value('["3 مرات","4 مرات","5 مرات","مرتين"]'),
          correctIndex: 2,
          sortOrder: const Value(2),
        ),
        QuizQuestionsCompanion.insert(
          lessonId: lessonId,
          question: 'What helped the Prophet overcome his trials?',
          questionArabic: const Value('ما الذي ساعد النبي على التغلب على ابتلاءاته؟'),
          options: jsonEncode([
            'His wealth',
            'His strength',
            'Faith and patience',
            'His friends'
          ]),
          optionsArabic: const Value(
              '["ثروته","قوته","الإيمان والصبر","أصدقاؤه"]'),
          correctIndex: 2,
          sortOrder: const Value(3),
        ),
      ]);
    });
  }

  Future<LessonProgressData?> _getProgress(int lessonId) async {
    return await (_db.select(_db.lessonProgress)
          ..where((t) => t.lessonId.equals(lessonId)))
        .getSingleOrNull();
  }

  LessonEntity _mapToEntity(Lesson lesson, LessonProgressData? progress) {
    return LessonEntity(
      id: lesson.id,
      serverId: lesson.serverId,
      chapterId: lesson.chapterId,
      title: lesson.title,
      titleArabic: lesson.titleArabic,
      subtitle: lesson.subtitle,
      subtitleArabic: lesson.subtitleArabic,
      sortOrder: lesson.sortOrder,
      durationMinutes: lesson.durationMinutes,
      hasAudio: lesson.hasAudio,
      hasQuiz: lesson.hasQuiz,
      thumbnailUrl: lesson.thumbnailUrl,
      audioUrl: lesson.audioUrl,
      isPremium: lesson.isPremium,
      isDownloaded: lesson.isDownloaded,
      isCompleted: progress?.isCompleted ?? false,
      lastPageViewed: progress?.lastPageViewed ?? 0,
    );
  }

  LessonContentEntity _mapContentToEntity(LessonContentData content) {
    return LessonContentEntity(
      id: content.id,
      lessonId: content.lessonId,
      pageNumber: content.pageNumber,
      contentText: content.contentText,
      contentTextArabic: content.contentTextArabic,
      translation: content.translation,
      imageUrl: content.imageUrl,
      imageDescription: content.imageDescription,
    );
  }

  QuizQuestionEntity _mapQuizToEntity(QuizQuestion quiz) {
    List<String> options;
    List<String>? optionsArabic;

    try {
      options = List<String>.from(jsonDecode(quiz.options));
    } catch (_) {
      options = [quiz.options];
    }

    if (quiz.optionsArabic != null) {
      try {
        optionsArabic = List<String>.from(jsonDecode(quiz.optionsArabic!));
      } catch (_) {
        optionsArabic = null;
      }
    }

    return QuizQuestionEntity(
      id: quiz.id,
      lessonId: quiz.lessonId,
      question: quiz.question,
      questionArabic: quiz.questionArabic,
      options: options,
      optionsArabic: optionsArabic,
      correctIndex: quiz.correctIndex,
      explanation: quiz.explanation,
      explanationArabic: quiz.explanationArabic,
      sortOrder: quiz.sortOrder,
    );
  }
}

/// Lesson repository provider
@riverpod
LessonRepository lessonRepository(LessonRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return LessonRepository(db);
}

/// Lessons for chapter provider
@riverpod
Stream<List<LessonEntity>> lessonsForChapter(
  LessonsForChapterRef ref,
  int chapterId,
) {
  final repository = ref.watch(lessonRepositoryProvider);
  return repository.watchLessonsForChapter(chapterId);
}

/// Single lesson provider
@riverpod
Future<LessonEntity?> lesson(LessonRef ref, String serverId) {
  final repository = ref.watch(lessonRepositoryProvider);
  return repository.getLessonByServerId(serverId);
}

/// Lesson content provider
@riverpod
Future<List<LessonContentEntity>> lessonContent(
  LessonContentRef ref,
  int lessonId,
) {
  final repository = ref.watch(lessonRepositoryProvider);
  return repository.getContentForLesson(lessonId);
}

/// Quiz questions provider
@riverpod
Future<List<QuizQuestionEntity>> quizQuestions(
  QuizQuestionsRef ref,
  int lessonId,
) {
  final repository = ref.watch(lessonRepositoryProvider);
  return repository.getQuizForLesson(lessonId);
}
