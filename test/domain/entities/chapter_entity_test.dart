import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sinbool/features/chapters/domain/entities/chapter_entity.dart';

void main() {
  group('ChapterEntity', () {
    late ChapterEntity chapter;

    setUp(() {
      chapter = const ChapterEntity(
        id: 1,
        serverId: 'chapter-1',
        title: 'Stories of the Prophets',
        titleArabic: 'قصص الأنبياء',
        description: 'Learn about the prophets',
        descriptionArabic: 'تعرف على الأنبياء',
        iconName: 'auto_stories',
        colorHex: '#2E7D32',
        sortOrder: 1,
        lessonCount: 10,
        completedCount: 5,
        isPremium: false,
      );
    });

    test('should return correct title for English locale', () {
      expect(chapter.getTitle('en'), equals('Stories of the Prophets'));
    });

    test('should return Arabic title for Arabic locale', () {
      expect(chapter.getTitle('ar'), equals('قصص الأنبياء'));
    });

    test('should return correct description for English locale', () {
      expect(chapter.getDescription('en'), equals('Learn about the prophets'));
    });

    test('should return Arabic description for Arabic locale', () {
      expect(chapter.getDescription('ar'), equals('تعرف على الأنبياء'));
    });

    test('should calculate progress correctly', () {
      expect(chapter.progress, equals(0.5));
    });

    test('should calculate progress as 0 when no lessons', () {
      final emptyChapter = chapter.copyWith(lessonCount: 0, completedCount: 0);
      expect(emptyChapter.progress, equals(0.0));
    });

    test('should return true for isStarted when completedCount > 0', () {
      expect(chapter.isStarted, isTrue);
    });

    test('should return false for isStarted when completedCount is 0', () {
      final newChapter = chapter.copyWith(completedCount: 0);
      expect(newChapter.isStarted, isFalse);
    });

    test('should return true for isCompleted when all lessons completed', () {
      final completedChapter = chapter.copyWith(completedCount: 10);
      expect(completedChapter.isCompleted, isTrue);
    });

    test('should parse icon correctly', () {
      expect(chapter.icon, equals(Icons.auto_stories));
    });

    test('should return default icon for unknown icon name', () {
      final unknownIconChapter = chapter.copyWith(iconName: 'unknown_icon');
      expect(unknownIconChapter.icon, equals(Icons.menu_book));
    });

    test('should parse color correctly', () {
      expect(chapter.color, equals(const Color(0xFF2E7D32)));
    });

    test('should return default color for invalid hex', () {
      final invalidColorChapter = chapter.copyWith(colorHex: 'invalid');
      expect(invalidColorChapter.color, equals(const Color(0xFF2E7D32)));
    });

    test('copyWith should create a new instance with updated values', () {
      final newChapter = chapter.copyWith(title: 'New Title');
      expect(newChapter.title, equals('New Title'));
      expect(newChapter.serverId, equals('chapter-1'));
    });
  });
}
