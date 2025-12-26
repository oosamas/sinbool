/// Bookmark entity representing a saved lesson
/// From Issue #8 - Bookmarks Feature
class BookmarkEntity {
  const BookmarkEntity({
    required this.id,
    required this.lessonId,
    required this.lessonServerId,
    required this.chapterServerId,
    required this.lessonTitle,
    this.lessonTitleArabic,
    required this.chapterTitle,
    this.chapterTitleArabic,
    this.lessonDurationMinutes,
    this.hasAudio = false,
    this.hasQuiz = false,
    this.isCompleted = false,
    this.note,
    required this.createdAt,
  });

  final int id;
  final int lessonId;
  final String lessonServerId;
  final String chapterServerId;
  final String lessonTitle;
  final String? lessonTitleArabic;
  final String chapterTitle;
  final String? chapterTitleArabic;
  final int? lessonDurationMinutes;
  final bool hasAudio;
  final bool hasQuiz;
  final bool isCompleted;
  final String? note;
  final DateTime createdAt;

  /// Get localized lesson title
  String getLessonTitle(String locale) {
    if (locale.startsWith('ar') && lessonTitleArabic != null) {
      return lessonTitleArabic!;
    }
    return lessonTitle;
  }

  /// Get localized chapter title
  String getChapterTitle(String locale) {
    if (locale.startsWith('ar') && chapterTitleArabic != null) {
      return chapterTitleArabic!;
    }
    return chapterTitle;
  }

  /// Get formatted duration
  String? get formattedDuration {
    if (lessonDurationMinutes == null) return null;
    return '$lessonDurationMinutes min';
  }

  /// Check if bookmark was added today
  bool get isAddedToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final bookmarkDate = DateTime(
      createdAt.year,
      createdAt.month,
      createdAt.day,
    );
    return today.isAtSameMomentAs(bookmarkDate);
  }

  /// Check if bookmark was added this week
  bool get isAddedThisWeek {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    return createdAt.isAfter(weekAgo);
  }

  BookmarkEntity copyWith({
    int? id,
    int? lessonId,
    String? lessonServerId,
    String? chapterServerId,
    String? lessonTitle,
    String? lessonTitleArabic,
    String? chapterTitle,
    String? chapterTitleArabic,
    int? lessonDurationMinutes,
    bool? hasAudio,
    bool? hasQuiz,
    bool? isCompleted,
    String? note,
    DateTime? createdAt,
  }) {
    return BookmarkEntity(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      lessonServerId: lessonServerId ?? this.lessonServerId,
      chapterServerId: chapterServerId ?? this.chapterServerId,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      lessonTitleArabic: lessonTitleArabic ?? this.lessonTitleArabic,
      chapterTitle: chapterTitle ?? this.chapterTitle,
      chapterTitleArabic: chapterTitleArabic ?? this.chapterTitleArabic,
      lessonDurationMinutes: lessonDurationMinutes ?? this.lessonDurationMinutes,
      hasAudio: hasAudio ?? this.hasAudio,
      hasQuiz: hasQuiz ?? this.hasQuiz,
      isCompleted: isCompleted ?? this.isCompleted,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
