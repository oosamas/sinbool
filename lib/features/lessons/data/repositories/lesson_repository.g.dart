// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lessonRepositoryHash() => r'3b7843372a97711239555509bca7392c186a86a5';

/// Lesson repository provider
///
/// Copied from [lessonRepository].
@ProviderFor(lessonRepository)
final lessonRepositoryProvider = AutoDisposeProvider<LessonRepository>.internal(
  lessonRepository,
  name: r'lessonRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lessonRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LessonRepositoryRef = AutoDisposeProviderRef<LessonRepository>;
String _$lessonsForChapterHash() => r'9fa6a10d4d17309dc232b08b93c1657094ce1a2e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Lessons for chapter provider
///
/// Copied from [lessonsForChapter].
@ProviderFor(lessonsForChapter)
const lessonsForChapterProvider = LessonsForChapterFamily();

/// Lessons for chapter provider
///
/// Copied from [lessonsForChapter].
class LessonsForChapterFamily extends Family<AsyncValue<List<LessonEntity>>> {
  /// Lessons for chapter provider
  ///
  /// Copied from [lessonsForChapter].
  const LessonsForChapterFamily();

  /// Lessons for chapter provider
  ///
  /// Copied from [lessonsForChapter].
  LessonsForChapterProvider call(int chapterId) {
    return LessonsForChapterProvider(chapterId);
  }

  @override
  LessonsForChapterProvider getProviderOverride(
    covariant LessonsForChapterProvider provider,
  ) {
    return call(provider.chapterId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lessonsForChapterProvider';
}

/// Lessons for chapter provider
///
/// Copied from [lessonsForChapter].
class LessonsForChapterProvider
    extends AutoDisposeStreamProvider<List<LessonEntity>> {
  /// Lessons for chapter provider
  ///
  /// Copied from [lessonsForChapter].
  LessonsForChapterProvider(int chapterId)
    : this._internal(
        (ref) => lessonsForChapter(ref as LessonsForChapterRef, chapterId),
        from: lessonsForChapterProvider,
        name: r'lessonsForChapterProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lessonsForChapterHash,
        dependencies: LessonsForChapterFamily._dependencies,
        allTransitiveDependencies:
            LessonsForChapterFamily._allTransitiveDependencies,
        chapterId: chapterId,
      );

  LessonsForChapterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chapterId,
  }) : super.internal();

  final int chapterId;

  @override
  Override overrideWith(
    Stream<List<LessonEntity>> Function(LessonsForChapterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LessonsForChapterProvider._internal(
        (ref) => create(ref as LessonsForChapterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chapterId: chapterId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<LessonEntity>> createElement() {
    return _LessonsForChapterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonsForChapterProvider && other.chapterId == chapterId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chapterId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LessonsForChapterRef on AutoDisposeStreamProviderRef<List<LessonEntity>> {
  /// The parameter `chapterId` of this provider.
  int get chapterId;
}

class _LessonsForChapterProviderElement
    extends AutoDisposeStreamProviderElement<List<LessonEntity>>
    with LessonsForChapterRef {
  _LessonsForChapterProviderElement(super.provider);

  @override
  int get chapterId => (origin as LessonsForChapterProvider).chapterId;
}

String _$lessonHash() => r'492f7c31149b371b43e4ee5e9d641c799bd44fa6';

/// Single lesson provider
///
/// Copied from [lesson].
@ProviderFor(lesson)
const lessonProvider = LessonFamily();

/// Single lesson provider
///
/// Copied from [lesson].
class LessonFamily extends Family<AsyncValue<LessonEntity?>> {
  /// Single lesson provider
  ///
  /// Copied from [lesson].
  const LessonFamily();

  /// Single lesson provider
  ///
  /// Copied from [lesson].
  LessonProvider call(String serverId) {
    return LessonProvider(serverId);
  }

  @override
  LessonProvider getProviderOverride(covariant LessonProvider provider) {
    return call(provider.serverId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lessonProvider';
}

/// Single lesson provider
///
/// Copied from [lesson].
class LessonProvider extends AutoDisposeFutureProvider<LessonEntity?> {
  /// Single lesson provider
  ///
  /// Copied from [lesson].
  LessonProvider(String serverId)
    : this._internal(
        (ref) => lesson(ref as LessonRef, serverId),
        from: lessonProvider,
        name: r'lessonProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lessonHash,
        dependencies: LessonFamily._dependencies,
        allTransitiveDependencies: LessonFamily._allTransitiveDependencies,
        serverId: serverId,
      );

  LessonProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serverId,
  }) : super.internal();

  final String serverId;

  @override
  Override overrideWith(
    FutureOr<LessonEntity?> Function(LessonRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LessonProvider._internal(
        (ref) => create(ref as LessonRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serverId: serverId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LessonEntity?> createElement() {
    return _LessonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonProvider && other.serverId == serverId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serverId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LessonRef on AutoDisposeFutureProviderRef<LessonEntity?> {
  /// The parameter `serverId` of this provider.
  String get serverId;
}

class _LessonProviderElement
    extends AutoDisposeFutureProviderElement<LessonEntity?>
    with LessonRef {
  _LessonProviderElement(super.provider);

  @override
  String get serverId => (origin as LessonProvider).serverId;
}

String _$lessonContentHash() => r'f6ff3da0ee9e22564e5a4ea77c7d9750d9da7927';

/// Lesson content provider
///
/// Copied from [lessonContent].
@ProviderFor(lessonContent)
const lessonContentProvider = LessonContentFamily();

/// Lesson content provider
///
/// Copied from [lessonContent].
class LessonContentFamily
    extends Family<AsyncValue<List<LessonContentEntity>>> {
  /// Lesson content provider
  ///
  /// Copied from [lessonContent].
  const LessonContentFamily();

  /// Lesson content provider
  ///
  /// Copied from [lessonContent].
  LessonContentProvider call(int lessonId) {
    return LessonContentProvider(lessonId);
  }

  @override
  LessonContentProvider getProviderOverride(
    covariant LessonContentProvider provider,
  ) {
    return call(provider.lessonId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lessonContentProvider';
}

/// Lesson content provider
///
/// Copied from [lessonContent].
class LessonContentProvider
    extends AutoDisposeFutureProvider<List<LessonContentEntity>> {
  /// Lesson content provider
  ///
  /// Copied from [lessonContent].
  LessonContentProvider(int lessonId)
    : this._internal(
        (ref) => lessonContent(ref as LessonContentRef, lessonId),
        from: lessonContentProvider,
        name: r'lessonContentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lessonContentHash,
        dependencies: LessonContentFamily._dependencies,
        allTransitiveDependencies:
            LessonContentFamily._allTransitiveDependencies,
        lessonId: lessonId,
      );

  LessonContentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lessonId,
  }) : super.internal();

  final int lessonId;

  @override
  Override overrideWith(
    FutureOr<List<LessonContentEntity>> Function(LessonContentRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LessonContentProvider._internal(
        (ref) => create(ref as LessonContentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lessonId: lessonId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LessonContentEntity>> createElement() {
    return _LessonContentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonContentProvider && other.lessonId == lessonId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lessonId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LessonContentRef
    on AutoDisposeFutureProviderRef<List<LessonContentEntity>> {
  /// The parameter `lessonId` of this provider.
  int get lessonId;
}

class _LessonContentProviderElement
    extends AutoDisposeFutureProviderElement<List<LessonContentEntity>>
    with LessonContentRef {
  _LessonContentProviderElement(super.provider);

  @override
  int get lessonId => (origin as LessonContentProvider).lessonId;
}

String _$quizQuestionsHash() => r'63d20c0e2229a69ace287a2294dcf536db145990';

/// Quiz questions provider
///
/// Copied from [quizQuestions].
@ProviderFor(quizQuestions)
const quizQuestionsProvider = QuizQuestionsFamily();

/// Quiz questions provider
///
/// Copied from [quizQuestions].
class QuizQuestionsFamily extends Family<AsyncValue<List<QuizQuestionEntity>>> {
  /// Quiz questions provider
  ///
  /// Copied from [quizQuestions].
  const QuizQuestionsFamily();

  /// Quiz questions provider
  ///
  /// Copied from [quizQuestions].
  QuizQuestionsProvider call(int lessonId) {
    return QuizQuestionsProvider(lessonId);
  }

  @override
  QuizQuestionsProvider getProviderOverride(
    covariant QuizQuestionsProvider provider,
  ) {
    return call(provider.lessonId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'quizQuestionsProvider';
}

/// Quiz questions provider
///
/// Copied from [quizQuestions].
class QuizQuestionsProvider
    extends AutoDisposeFutureProvider<List<QuizQuestionEntity>> {
  /// Quiz questions provider
  ///
  /// Copied from [quizQuestions].
  QuizQuestionsProvider(int lessonId)
    : this._internal(
        (ref) => quizQuestions(ref as QuizQuestionsRef, lessonId),
        from: quizQuestionsProvider,
        name: r'quizQuestionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$quizQuestionsHash,
        dependencies: QuizQuestionsFamily._dependencies,
        allTransitiveDependencies:
            QuizQuestionsFamily._allTransitiveDependencies,
        lessonId: lessonId,
      );

  QuizQuestionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lessonId,
  }) : super.internal();

  final int lessonId;

  @override
  Override overrideWith(
    FutureOr<List<QuizQuestionEntity>> Function(QuizQuestionsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuizQuestionsProvider._internal(
        (ref) => create(ref as QuizQuestionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lessonId: lessonId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<QuizQuestionEntity>> createElement() {
    return _QuizQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizQuestionsProvider && other.lessonId == lessonId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lessonId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuizQuestionsRef
    on AutoDisposeFutureProviderRef<List<QuizQuestionEntity>> {
  /// The parameter `lessonId` of this provider.
  int get lessonId;
}

class _QuizQuestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<QuizQuestionEntity>>
    with QuizQuestionsRef {
  _QuizQuestionsProviderElement(super.provider);

  @override
  int get lessonId => (origin as QuizQuestionsProvider).lessonId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
