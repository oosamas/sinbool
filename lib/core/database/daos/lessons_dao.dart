import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/chapters_table.dart';
import '../tables/lessons_table.dart';

part 'lessons_dao.g.dart';

/// DAO for lessons operations
/// From Issue #4 - Database Setup
@DriftAccessor(tables: [Lessons, LessonContent, QuizQuestions])
class LessonsDao extends DatabaseAccessor<AppDatabase> with _$LessonsDaoMixin {
  LessonsDao(super.db);

  /// Get all lessons for a chapter
  Future<List<Lesson>> getLessonsForChapter(int chapterId) {
    return (select(lessons)
          ..where((t) => t.chapterId.equals(chapterId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  /// Get lesson by ID
  Future<Lesson?> getLessonById(int id) {
    return (select(lessons)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Get lesson by server ID
  Future<Lesson?> getLessonByServerId(String serverId) {
    return (select(lessons)..where((t) => t.serverId.equals(serverId)))
        .getSingleOrNull();
  }

  /// Watch lessons for a chapter
  Stream<List<Lesson>> watchLessonsForChapter(int chapterId) {
    return (select(lessons)
          ..where((t) => t.chapterId.equals(chapterId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  /// Insert or update a lesson
  Future<int> upsertLesson(LessonsCompanion lesson) {
    return into(lessons).insertOnConflictUpdate(lesson);
  }

  /// Insert multiple lessons
  Future<void> insertLessons(List<LessonsCompanion> lessonsList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(lessons, lessonsList);
    });
  }

  /// Delete a lesson
  Future<int> deleteLesson(int id) {
    return (delete(lessons)..where((t) => t.id.equals(id))).go();
  }

  // Lesson Content

  /// Get all content pages for a lesson
  Future<List<LessonContentData>> getContentForLesson(int lessonId) {
    return (select(lessonContent)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]))
        .get();
  }

  /// Watch content pages for a lesson
  Stream<List<LessonContentData>> watchContentForLesson(int lessonId) {
    return (select(lessonContent)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]))
        .watch();
  }

  /// Insert lesson content
  Future<void> insertContent(List<LessonContentCompanion> contentList) async {
    await batch((batch) {
      batch.insertAll(lessonContent, contentList);
    });
  }

  /// Delete content for a lesson
  Future<int> deleteContentForLesson(int lessonId) {
    return (delete(lessonContent)..where((t) => t.lessonId.equals(lessonId)))
        .go();
  }

  // Quiz Questions

  /// Get quiz questions for a lesson
  Future<List<QuizQuestion>> getQuizForLesson(int lessonId) {
    return (select(quizQuestions)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  /// Watch quiz questions for a lesson
  Stream<List<QuizQuestion>> watchQuizForLesson(int lessonId) {
    return (select(quizQuestions)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  /// Insert quiz questions
  Future<void> insertQuizQuestions(
      List<QuizQuestionsCompanion> questionsList) async {
    await batch((batch) {
      batch.insertAll(quizQuestions, questionsList);
    });
  }

  /// Delete quiz questions for a lesson
  Future<int> deleteQuizForLesson(int lessonId) {
    return (delete(quizQuestions)..where((t) => t.lessonId.equals(lessonId)))
        .go();
  }
}
