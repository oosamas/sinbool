// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'105bd8a8ef41e172ff5db2d8e451479a0697fd42';

/// Database instance provider
/// From Issue #4 - Database Setup
///
/// Copied from [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = Provider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = ProviderRef<AppDatabase>;
String _$chaptersDaoHash() => r'3359d508e72dd83f11daf56c802dd849f2b69471';

/// Chapters DAO provider
///
/// Copied from [chaptersDao].
@ProviderFor(chaptersDao)
final chaptersDaoProvider = AutoDisposeProvider<ChaptersDao>.internal(
  chaptersDao,
  name: r'chaptersDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chaptersDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChaptersDaoRef = AutoDisposeProviderRef<ChaptersDao>;
String _$lessonsDaoHash() => r'dc49eba659ae1eade26276312be5bf9c18e19afe';

/// Lessons DAO provider
///
/// Copied from [lessonsDao].
@ProviderFor(lessonsDao)
final lessonsDaoProvider = AutoDisposeProvider<LessonsDao>.internal(
  lessonsDao,
  name: r'lessonsDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lessonsDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LessonsDaoRef = AutoDisposeProviderRef<LessonsDao>;
String _$bookmarksDaoHash() => r'8a744c10a234ba240e104f5cf6e17e81e0261bc2';

/// Bookmarks DAO provider
///
/// Copied from [bookmarksDao].
@ProviderFor(bookmarksDao)
final bookmarksDaoProvider = AutoDisposeProvider<BookmarksDao>.internal(
  bookmarksDao,
  name: r'bookmarksDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookmarksDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookmarksDaoRef = AutoDisposeProviderRef<BookmarksDao>;
String _$progressDaoHash() => r'6069a73f5a6550f4bf15ffaddbdb9b75272958d7';

/// Progress DAO provider
///
/// Copied from [progressDao].
@ProviderFor(progressDao)
final progressDaoProvider = AutoDisposeProvider<ProgressDao>.internal(
  progressDao,
  name: r'progressDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$progressDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProgressDaoRef = AutoDisposeProviderRef<ProgressDao>;
String _$settingsDaoHash() => r'e6cff93ad8837c40dcc6768ab666177dffbef7be';

/// Settings DAO provider
///
/// Copied from [settingsDao].
@ProviderFor(settingsDao)
final settingsDaoProvider = AutoDisposeProvider<SettingsDao>.internal(
  settingsDao,
  name: r'settingsDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsDaoRef = AutoDisposeProviderRef<SettingsDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
