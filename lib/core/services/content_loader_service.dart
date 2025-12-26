import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

part 'content_loader_service.g.dart';

/// Service for loading content from JSON asset files into the database
class ContentLoaderService {
  ContentLoaderService(this._db);

  final AppDatabase _db;

  // Content version - increment this when content JSON files change
  static const int _contentVersion = 3;
  static const String _contentVersionKey = 'content_version';

  /// Check if content needs to be reloaded (version changed or missing content)
  Future<bool> _needsContentReload() async {
    final chapters = await _db.select(_db.chapters).get();
    if (chapters.isEmpty) {
      print('ContentLoader: No chapters found - need reload');
      return true;
    }

    // Check if any chapter has fewer lessons than expected (indicates stale data)
    for (final chapter in chapters) {
      final lessons = await (_db.select(_db.lessons)
            ..where((t) => t.chapterId.equals(chapter.id)))
          .get();
      if (lessons.length < chapter.lessonCount) {
        print('ContentLoader: Chapter ${chapter.serverId} has ${lessons.length} lessons, expected ${chapter.lessonCount}');
        return true; // Mismatch - need reload
      }

      // Also check if lessons have content
      for (final lesson in lessons) {
        final content = await (_db.select(_db.lessonContent)
              ..where((t) => t.lessonId.equals(lesson.id)))
            .get();
        if (content.isEmpty) {
          print('ContentLoader: Lesson ${lesson.serverId} (id=${lesson.id}) has no content - need reload');
          return true;
        }
      }
    }

    print('ContentLoader: All content present, no reload needed');
    return false;
  }

  /// Force reload all content (clears existing and reloads from JSON)
  Future<void> forceReloadAllContent() async {
    // Delete all existing content in correct order (respect foreign key constraints)
    // First delete tables that reference lessons
    await _db.delete(_db.lessonProgress).go();
    await _db.delete(_db.bookmarks).go();
    await _db.delete(_db.quizQuestions).go();
    await _db.delete(_db.lessonContent).go();
    // Then delete lessons (which reference chapters)
    await _db.delete(_db.lessons).go();
    // Finally delete chapters
    await _db.delete(_db.chapters).go();

    // Reload everything
    await _loadAllContentFiles();
  }

  /// Load all prophet content from asset files
  Future<void> loadAllContent() async {
    // Check if we need to force reload due to stale data
    final needsReload = await _needsContentReload();
    if (needsReload) {
      print('Content reload needed - clearing and reloading all content');
      await forceReloadAllContent();
      return;
    }

    await _loadAllContentFiles();
  }

  /// Internal method to load all content files
  Future<void> _loadAllContentFiles() async {
    // Load Prophet Adam
    await loadContentFromAsset('assets/content/prophet_adam.json');

    // Load Prophet Nuh
    await loadContentFromAsset('assets/content/prophet_nuh.json');

    // Load Prophet Ibrahim
    await loadContentFromAsset('assets/content/prophet_ibrahim.json');

    // Load Prophet Musa
    await loadContentFromAsset('assets/content/prophet_musa.json');

    // Load Prophet Yusuf
    await loadContentFromAsset('assets/content/prophet_yusuf.json');

    // Load Prophet Isa
    await loadContentFromAsset('assets/content/prophet_isa.json');

    // Load Prophet Muhammad
    await loadContentFromAsset('assets/content/prophet_muhammad.json');

    // Load Prophet Dawud
    await loadContentFromAsset('assets/content/prophet_dawud.json');

    // Load Prophet Sulayman
    await loadContentFromAsset('assets/content/prophet_sulayman.json');

    // Load Prophet Ayyub
    await loadContentFromAsset('assets/content/prophet_ayyub.json');

    // Load Prophet Lut
    await loadContentFromAsset('assets/content/prophet_lut.json');

    // Load Prophet Ismail
    await loadContentFromAsset('assets/content/prophet_ismail.json');

    // Load Prophet Shuayb
    await loadContentFromAsset('assets/content/prophet_shuayb.json');

    // Load Prophet Zakariya
    await loadContentFromAsset('assets/content/prophet_zakariya.json');

    // Load Prophet Yahya
    await loadContentFromAsset('assets/content/prophet_yahya.json');

    // Load Prophet Hud
    await loadContentFromAsset('assets/content/prophet_hud.json');

    // Load Prophet Idris
    await loadContentFromAsset('assets/content/prophet_idris.json');

    // Load Prophet Yunus
    await loadContentFromAsset('assets/content/prophet_yunus.json');

    // Load Prophet Salih
    await loadContentFromAsset('assets/content/prophet_salih.json');

    // Load Prophet Ishaq
    await loadContentFromAsset('assets/content/prophet_ishaq.json');

    // Load Prophet Yaqub
    await loadContentFromAsset('assets/content/prophet_yaqub.json');

    // === Righteous People from the Quran ===

    // Maryam (mother of Prophet Isa)
    await loadContentFromAsset('assets/content/righteous_maryam.json');

    // Luqman the Wise
    await loadContentFromAsset('assets/content/righteous_luqman.json');

    // === Animals from the Quran ===

    // The Elephant Army (Surah Al-Fil)
    await loadContentFromAsset('assets/content/animal_elephant.json');

    // The Whale and Prophet Yunus
    await loadContentFromAsset('assets/content/animal_whale.json');

    // The Hoopoe Bird (Sulayman's messenger)
    await loadContentFromAsset('assets/content/animal_hoopoe.json');

    // The Ant (Sulayman's story)
    await loadContentFromAsset('assets/content/animal_ant.json');

    // The Crow Teacher (Habil & Qabil)
    await loadContentFromAsset('assets/content/animal_crow.json');

    // The She-Camel of Prophet Salih
    await loadContentFromAsset('assets/content/animal_camel.json');

    // The Dog of the Cave (Ashab al-Kahf)
    await loadContentFromAsset('assets/content/animal_dog.json');
  }

  /// Load content from a single JSON asset file
  Future<void> loadContentFromAsset(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      await _loadChapterContent(data);
    } on FormatException catch (e) {
      // JSON parsing error - this is a real error that should be visible
      print('ContentLoader: JSON parse error in $assetPath: $e');
      rethrow;
    } catch (e) {
      // Asset might not exist yet or other errors
      // Check if it's an asset not found error (contains 'Unable to load asset')
      final errorMsg = e.toString();
      if (errorMsg.contains('Unable to load asset')) {
        print('ContentLoader: Asset not found $assetPath');
      } else {
        print('ContentLoader: Error loading $assetPath: $e');
      }
    }
  }

  /// Load chapter content from parsed JSON data
  Future<void> _loadChapterContent(Map<String, dynamic> data) async {
    final chapterData = data['chapter'];
    final lessonsData = data['lessons'];

    if (chapterData is! Map<String, dynamic>) {
      throw FormatException('Invalid chapter data: expected Map, got ${chapterData.runtimeType}');
    }
    if (lessonsData is! List<dynamic>) {
      throw FormatException('Invalid lessons data: expected List, got ${lessonsData.runtimeType}');
    }

    // Check if chapter already exists
    final existingChapter = await (_db.select(_db.chapters)
          ..where((t) => t.serverId.equals(chapterData['serverId'] as String)))
        .getSingleOrNull();

    int chapterId;

    if (existingChapter != null) {
      chapterId = existingChapter.id;
      // Update existing chapter
      await (_db.update(_db.chapters)
            ..where((t) => t.id.equals(chapterId)))
          .write(ChaptersCompanion(
        title: Value(chapterData['title'] as String),
        titleArabic: Value(chapterData['titleArabic'] as String?),
        description: Value(chapterData['description'] as String),
        descriptionArabic: Value(chapterData['descriptionArabic'] as String?),
        iconName: Value(chapterData['iconName'] as String? ?? 'menu_book'),
        colorHex: Value(chapterData['colorHex'] as String? ?? '#2E7D32'),
        sortOrder: Value(chapterData['sortOrder'] as int? ?? 0),
        lessonCount: Value(lessonsData.length),
      ));
    } else {
      // Insert new chapter
      chapterId = await _db.into(_db.chapters).insert(
            ChaptersCompanion.insert(
              serverId: chapterData['serverId'] as String,
              title: chapterData['title'] as String,
              titleArabic: Value(chapterData['titleArabic'] as String?),
              description: chapterData['description'] as String,
              descriptionArabic:
                  Value(chapterData['descriptionArabic'] as String?),
              iconName: Value(chapterData['iconName'] as String? ?? 'menu_book'),
              colorHex: Value(chapterData['colorHex'] as String? ?? '#2E7D32'),
              sortOrder: Value(chapterData['sortOrder'] as int? ?? 0),
              lessonCount: Value(lessonsData.length),
            ),
          );
    }

    // Load lessons for this chapter
    for (final lessonData in lessonsData) {
      await _loadLesson(chapterId, lessonData as Map<String, dynamic>);
    }
  }

  /// Load a single lesson with its content and quiz
  Future<void> _loadLesson(int chapterId, Map<String, dynamic> lessonData) async {
    final serverId = lessonData['serverId'] as String;

    // Check if lesson already exists
    final existingLesson = await (_db.select(_db.lessons)
          ..where((t) => t.serverId.equals(serverId)))
        .getSingleOrNull();

    int lessonId;

    if (existingLesson != null) {
      lessonId = existingLesson.id;
      // Update existing lesson
      await (_db.update(_db.lessons)..where((t) => t.id.equals(lessonId)))
          .write(LessonsCompanion(
        title: Value(lessonData['title'] as String),
        titleArabic: Value(lessonData['titleArabic'] as String?),
        subtitle: Value(lessonData['subtitle'] as String?),
        subtitleArabic: Value(lessonData['subtitleArabic'] as String?),
        sortOrder: Value(lessonData['sortOrder'] as int? ?? 0),
        durationMinutes: Value(lessonData['durationMinutes'] as int? ?? 5),
        hasAudio: Value(lessonData['hasAudio'] as bool? ?? false),
        hasQuiz: Value(lessonData['hasQuiz'] as bool? ?? false),
      ));
    } else {
      // Insert new lesson
      lessonId = await _db.into(_db.lessons).insert(
            LessonsCompanion.insert(
              serverId: serverId,
              chapterId: chapterId,
              title: lessonData['title'] as String,
              titleArabic: Value(lessonData['titleArabic'] as String?),
              subtitle: Value(lessonData['subtitle'] as String?),
              subtitleArabic: Value(lessonData['subtitleArabic'] as String?),
              sortOrder: Value(lessonData['sortOrder'] as int? ?? 0),
              durationMinutes: Value(lessonData['durationMinutes'] as int? ?? 5),
              hasAudio: Value(lessonData['hasAudio'] as bool? ?? false),
              hasQuiz: Value(lessonData['hasQuiz'] as bool? ?? false),
            ),
          );
    }

    // Load content pages
    final contentList = lessonData['content'] as List<dynamic>?;
    if (contentList != null && contentList.isNotEmpty) {
      // Delete existing content for this lesson
      await (_db.delete(_db.lessonContent)
            ..where((t) => t.lessonId.equals(lessonId)))
          .go();

      // Insert new content
      for (final contentData in contentList) {
        final content = contentData as Map<String, dynamic>;
        await _db.into(_db.lessonContent).insert(
              LessonContentCompanion.insert(
                lessonId: lessonId,
                pageNumber: content['pageNumber'] as int,
                contentText: content['contentText'] as String,
                contentTextArabic:
                    Value(content['contentTextArabic'] as String?),
                translation: Value(content['translation'] as String?),
                imageUrl: Value(content['imageUrl'] as String?),
                imageDescription:
                    Value(content['imageDescription'] as String?),
              ),
            );
      }
      print('ContentLoader: Loaded ${contentList.length} pages for lesson $serverId (id=$lessonId)');
    } else {
      print('ContentLoader: WARNING - No content found in JSON for lesson $serverId');
    }

    // Load quiz questions
    final quizList = lessonData['quiz'] as List<dynamic>?;
    if (quizList != null) {
      // Delete existing quiz for this lesson
      await (_db.delete(_db.quizQuestions)
            ..where((t) => t.lessonId.equals(lessonId)))
          .go();

      // Insert new quiz questions
      int sortOrder = 1;
      for (final quizData in quizList) {
        final quiz = quizData as Map<String, dynamic>;
        await _db.into(_db.quizQuestions).insert(
              QuizQuestionsCompanion.insert(
                lessonId: lessonId,
                question: quiz['question'] as String,
                questionArabic: Value(quiz['questionArabic'] as String?),
                options: jsonEncode(quiz['options']),
                optionsArabic: Value(
                    quiz['optionsArabic'] != null
                        ? jsonEncode(quiz['optionsArabic'])
                        : null),
                correctIndex: quiz['correctIndex'] as int,
                explanation: Value(quiz['explanation'] as String?),
                explanationArabic:
                    Value(quiz['explanationArabic'] as String?),
                sortOrder: Value(sortOrder++),
              ),
            );
      }
    }
  }
}

/// Content loader service provider
@riverpod
ContentLoaderService contentLoaderService(ContentLoaderServiceRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return ContentLoaderService(db);
}

/// Load all content provider
@riverpod
Future<void> loadAllContent(LoadAllContentRef ref) async {
  final service = ref.watch(contentLoaderServiceProvider);
  await service.loadAllContent();
}
