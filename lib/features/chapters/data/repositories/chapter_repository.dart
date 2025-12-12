import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/entities/chapter_entity.dart';

part 'chapter_repository.g.dart';

/// Repository for chapter data operations
/// From Issue #5 - Content Domain
class ChapterRepository {
  ChapterRepository(this._db);

  final AppDatabase _db;

  /// Get all chapters with progress
  Future<List<ChapterEntity>> getAllChapters() async {
    final chapters = await _db.select(_db.chapters).get();
    final entities = <ChapterEntity>[];

    for (final chapter in chapters) {
      final completedCount = await _getCompletedCount(chapter.id);
      entities.add(_mapToEntity(chapter, completedCount));
    }

    entities.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return entities;
  }

  /// Watch all chapters with progress
  Stream<List<ChapterEntity>> watchAllChapters() {
    return _db.select(_db.chapters).watch().asyncMap((chapters) async {
      final entities = <ChapterEntity>[];
      for (final chapter in chapters) {
        final completedCount = await _getCompletedCount(chapter.id);
        entities.add(_mapToEntity(chapter, completedCount));
      }
      entities.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      return entities;
    });
  }

  /// Get chapter by ID
  Future<ChapterEntity?> getChapterById(int id) async {
    final chapter = await (_db.select(_db.chapters)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (chapter == null) return null;
    final completedCount = await _getCompletedCount(chapter.id);
    return _mapToEntity(chapter, completedCount);
  }

  /// Get chapter by server ID
  Future<ChapterEntity?> getChapterByServerId(String serverId) async {
    final chapter = await (_db.select(_db.chapters)
          ..where((t) => t.serverId.equals(serverId)))
        .getSingleOrNull();
    if (chapter == null) return null;
    final completedCount = await _getCompletedCount(chapter.id);
    return _mapToEntity(chapter, completedCount);
  }

  /// Insert sample data for development
  Future<void> insertSampleData() async {
    final existing = await _db.select(_db.chapters).get();
    if (existing.isNotEmpty) return;

    await _db.batch((batch) {
      batch.insertAll(_db.chapters, [
        ChaptersCompanion.insert(
          serverId: 'prophet-adam',
          title: 'Prophet Adam (AS)',
          titleArabic: const Value('النبي آدم عليه السلام'),
          description: 'The story of the first human and Prophet',
          descriptionArabic:
              const Value('قصة أول إنسان ونبي على وجه الأرض'),
          iconName: const Value('park'),
          colorHex: const Value('#4CAF50'),
          sortOrder: const Value(1),
          lessonCount: const Value(5),
        ),
        ChaptersCompanion.insert(
          serverId: 'prophet-nuh',
          title: 'Prophet Nuh (AS)',
          titleArabic: const Value('النبي نوح عليه السلام'),
          description: 'The great flood and the ark',
          descriptionArabic: const Value('الطوفان العظيم وسفينة نوح'),
          iconName: const Value('sailing'),
          colorHex: const Value('#2196F3'),
          sortOrder: const Value(2),
          lessonCount: const Value(6),
        ),
        ChaptersCompanion.insert(
          serverId: 'prophet-ibrahim',
          title: 'Prophet Ibrahim (AS)',
          titleArabic: const Value('النبي إبراهيم عليه السلام'),
          description: 'The father of Prophets and his trials',
          descriptionArabic: const Value('أبو الأنبياء وابتلاءاته'),
          iconName: const Value('local_fire_department'),
          colorHex: const Value('#FF9800'),
          sortOrder: const Value(3),
          lessonCount: const Value(8),
        ),
        ChaptersCompanion.insert(
          serverId: 'prophet-yusuf',
          title: 'Prophet Yusuf (AS)',
          titleArabic: const Value('النبي يوسف عليه السلام'),
          description: 'The beautiful story of patience and forgiveness',
          descriptionArabic: const Value('أحسن القصص - قصة الصبر والمغفرة'),
          iconName: const Value('star'),
          colorHex: const Value('#9C27B0'),
          sortOrder: const Value(4),
          lessonCount: const Value(10),
        ),
        ChaptersCompanion.insert(
          serverId: 'prophet-musa',
          title: 'Prophet Musa (AS)',
          titleArabic: const Value('النبي موسى عليه السلام'),
          description: 'The story of the staff and the sea',
          descriptionArabic: const Value('قصة العصا وانشقاق البحر'),
          iconName: const Value('water'),
          colorHex: const Value('#00BCD4'),
          sortOrder: const Value(5),
          lessonCount: const Value(12),
        ),
        ChaptersCompanion.insert(
          serverId: 'prophet-isa',
          title: 'Prophet Isa (AS)',
          titleArabic: const Value('النبي عيسى عليه السلام'),
          description: 'The miraculous birth and teachings',
          descriptionArabic: const Value('الولادة المعجزة والتعاليم'),
          iconName: const Value('wb_sunny'),
          colorHex: const Value('#03A9F4'),
          sortOrder: const Value(6),
          lessonCount: const Value(7),
          isPremium: const Value(true),
        ),
        ChaptersCompanion.insert(
          serverId: 'prophet-muhammad',
          title: 'Prophet Muhammad (SAW)',
          titleArabic: const Value('النبي محمد صلى الله عليه وسلم'),
          description: 'The life of the final Messenger',
          descriptionArabic: const Value('سيرة خاتم الأنبياء والمرسلين'),
          iconName: const Value('mosque'),
          colorHex: const Value('#2E7D32'),
          sortOrder: const Value(7),
          lessonCount: const Value(20),
          isPremium: const Value(true),
        ),
      ]);
    });
  }

  Future<int> _getCompletedCount(int chapterId) async {
    final query = _db.select(_db.lessonProgress).join([
      innerJoin(
        _db.lessons,
        _db.lessons.id.equalsExp(_db.lessonProgress.lessonId),
      ),
    ])
      ..where(_db.lessons.chapterId.equals(chapterId))
      ..where(_db.lessonProgress.isCompleted.equals(true));

    final results = await query.get();
    return results.length;
  }

  ChapterEntity _mapToEntity(Chapter chapter, int completedCount) {
    return ChapterEntity(
      id: chapter.id,
      serverId: chapter.serverId,
      title: chapter.title,
      titleArabic: chapter.titleArabic,
      description: chapter.description,
      descriptionArabic: chapter.descriptionArabic,
      iconName: chapter.iconName,
      colorHex: chapter.colorHex,
      sortOrder: chapter.sortOrder,
      lessonCount: chapter.lessonCount,
      completedCount: completedCount,
      isPremium: chapter.isPremium,
      isDownloaded: chapter.isDownloaded,
    );
  }
}

/// Chapter repository provider
@riverpod
ChapterRepository chapterRepository(ChapterRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return ChapterRepository(db);
}

/// All chapters provider
@riverpod
Stream<List<ChapterEntity>> chapters(ChaptersRef ref) {
  final repository = ref.watch(chapterRepositoryProvider);
  return repository.watchAllChapters();
}

/// Single chapter provider
@riverpod
Future<ChapterEntity?> chapter(ChapterRef ref, String serverId) {
  final repository = ref.watch(chapterRepositoryProvider);
  return repository.getChapterByServerId(serverId);
}
