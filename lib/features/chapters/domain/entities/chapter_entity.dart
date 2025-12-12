import 'package:flutter/material.dart';

/// Chapter entity representing a story collection
/// From Issue #5 - Content Domain
class ChapterEntity {
  const ChapterEntity({
    required this.id,
    required this.serverId,
    required this.title,
    required this.description,
    this.titleArabic,
    this.descriptionArabic,
    this.iconName = 'menu_book',
    this.colorHex = '#2E7D32',
    this.sortOrder = 0,
    this.lessonCount = 0,
    this.completedCount = 0,
    this.isPremium = false,
    this.isDownloaded = false,
  });

  final int id;
  final String serverId;
  final String title;
  final String? titleArabic;
  final String description;
  final String? descriptionArabic;
  final String iconName;
  final String colorHex;
  final int sortOrder;
  final int lessonCount;
  final int completedCount;
  final bool isPremium;
  final bool isDownloaded;

  /// Get icon data from icon name
  IconData get icon {
    const iconMap = {
      'menu_book': Icons.menu_book,
      'auto_stories': Icons.auto_stories,
      'park': Icons.park,
      'sailing': Icons.sailing,
      'local_fire_department': Icons.local_fire_department,
      'star': Icons.star,
      'water': Icons.water,
      'wb_sunny': Icons.wb_sunny,
      'mosque': Icons.mosque,
      'favorite': Icons.favorite,
    };
    return iconMap[iconName] ?? Icons.menu_book;
  }

  /// Get color from hex string
  Color get color {
    try {
      return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF2E7D32);
    }
  }

  /// Progress as percentage (0.0 - 1.0)
  double get progress =>
      lessonCount > 0 ? completedCount / lessonCount : 0.0;

  /// Check if chapter is started
  bool get isStarted => completedCount > 0;

  /// Check if chapter is completed
  bool get isCompleted => lessonCount > 0 && completedCount >= lessonCount;

  /// Get localized title
  String getTitle(String locale) {
    if (locale.startsWith('ar') && titleArabic != null) {
      return titleArabic!;
    }
    return title;
  }

  /// Get localized description
  String getDescription(String locale) {
    if (locale.startsWith('ar') && descriptionArabic != null) {
      return descriptionArabic!;
    }
    return description;
  }

  ChapterEntity copyWith({
    int? id,
    String? serverId,
    String? title,
    String? titleArabic,
    String? description,
    String? descriptionArabic,
    String? iconName,
    String? colorHex,
    int? sortOrder,
    int? lessonCount,
    int? completedCount,
    bool? isPremium,
    bool? isDownloaded,
  }) {
    return ChapterEntity(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      title: title ?? this.title,
      titleArabic: titleArabic ?? this.titleArabic,
      description: description ?? this.description,
      descriptionArabic: descriptionArabic ?? this.descriptionArabic,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      sortOrder: sortOrder ?? this.sortOrder,
      lessonCount: lessonCount ?? this.lessonCount,
      completedCount: completedCount ?? this.completedCount,
      isPremium: isPremium ?? this.isPremium,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}
