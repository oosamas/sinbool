/// Lesson entity representing a single lesson
/// From Issue #5 - Content Domain
class LessonEntity {
  const LessonEntity({
    required this.id,
    required this.serverId,
    required this.chapterId,
    required this.title,
    this.titleArabic,
    this.subtitle,
    this.subtitleArabic,
    this.sortOrder = 0,
    this.durationMinutes = 5,
    this.hasAudio = false,
    this.hasQuiz = false,
    this.thumbnailUrl,
    this.audioUrl,
    this.isPremium = false,
    this.isDownloaded = false,
    this.isCompleted = false,
    this.isLocked = false,
    this.lastPageViewed = 0,
  });

  final int id;
  final String serverId;
  final int chapterId;
  final String title;
  final String? titleArabic;
  final String? subtitle;
  final String? subtitleArabic;
  final int sortOrder;
  final int durationMinutes;
  final bool hasAudio;
  final bool hasQuiz;
  final String? thumbnailUrl;
  final String? audioUrl;
  final bool isPremium;
  final bool isDownloaded;
  final bool isCompleted;
  final bool isLocked;
  final int lastPageViewed;

  /// Get formatted duration string
  String get duration => '$durationMinutes min';

  /// Get localized title
  String getTitle(String locale) {
    if (locale.startsWith('ar') && titleArabic != null) {
      return titleArabic!;
    }
    return title;
  }

  /// Get localized subtitle
  String? getSubtitle(String locale) {
    if (locale.startsWith('ar') && subtitleArabic != null) {
      return subtitleArabic;
    }
    return subtitle;
  }

  LessonEntity copyWith({
    int? id,
    String? serverId,
    int? chapterId,
    String? title,
    String? titleArabic,
    String? subtitle,
    String? subtitleArabic,
    int? sortOrder,
    int? durationMinutes,
    bool? hasAudio,
    bool? hasQuiz,
    String? thumbnailUrl,
    String? audioUrl,
    bool? isPremium,
    bool? isDownloaded,
    bool? isCompleted,
    bool? isLocked,
    int? lastPageViewed,
  }) {
    return LessonEntity(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      chapterId: chapterId ?? this.chapterId,
      title: title ?? this.title,
      titleArabic: titleArabic ?? this.titleArabic,
      subtitle: subtitle ?? this.subtitle,
      subtitleArabic: subtitleArabic ?? this.subtitleArabic,
      sortOrder: sortOrder ?? this.sortOrder,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      hasAudio: hasAudio ?? this.hasAudio,
      hasQuiz: hasQuiz ?? this.hasQuiz,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      isPremium: isPremium ?? this.isPremium,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      lastPageViewed: lastPageViewed ?? this.lastPageViewed,
    );
  }
}

/// Lesson content page entity
class LessonContentEntity {
  const LessonContentEntity({
    required this.id,
    required this.lessonId,
    required this.pageNumber,
    required this.contentText,
    this.contentTextArabic,
    this.translation,
    this.imageUrl,
    this.imageDescription,
    this.audioStartMs,
    this.audioEndMs,
  });

  final int id;
  final int lessonId;
  final int pageNumber;
  final String contentText;
  final String? contentTextArabic;
  final String? translation;
  final String? imageUrl;
  final String? imageDescription;
  final int? audioStartMs;
  final int? audioEndMs;

  /// Check if content is Arabic
  bool get isArabic =>
      RegExp(r'[\u0600-\u06FF]').hasMatch(contentText);

  /// Get localized content
  String getContent(String locale) {
    if (locale.startsWith('ar') && contentTextArabic != null) {
      return contentTextArabic!;
    }
    return contentText;
  }
}

/// Quiz question entity
class QuizQuestionEntity {
  const QuizQuestionEntity({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.options,
    required this.correctIndex,
    this.questionArabic,
    this.optionsArabic,
    this.explanation,
    this.explanationArabic,
    this.sortOrder = 0,
  });

  final int id;
  final int lessonId;
  final String question;
  final String? questionArabic;
  final List<String> options;
  final List<String>? optionsArabic;
  final int correctIndex;
  final String? explanation;
  final String? explanationArabic;
  final int sortOrder;

  /// Get localized question
  String getQuestion(String locale) {
    if (locale.startsWith('ar') && questionArabic != null) {
      return questionArabic!;
    }
    return question;
  }

  /// Get localized options
  List<String> getOptions(String locale) {
    if (locale.startsWith('ar') && optionsArabic != null) {
      return optionsArabic!;
    }
    return options;
  }

  /// Get localized explanation
  String? getExplanation(String locale) {
    if (locale.startsWith('ar') && explanationArabic != null) {
      return explanationArabic;
    }
    return explanation;
  }

  /// Check if answer is correct
  bool isCorrect(int index) => index == correctIndex;
}
