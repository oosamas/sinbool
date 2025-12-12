// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$progressRepositoryHash() =>
    r'c5dfe7a4943e2f1fbc6b1d04cbf51f5fc92935e5';

/// Progress repository provider
///
/// Copied from [progressRepository].
@ProviderFor(progressRepository)
final progressRepositoryProvider =
    AutoDisposeProvider<ProgressRepository>.internal(
      progressRepository,
      name: r'progressRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$progressRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProgressRepositoryRef = AutoDisposeProviderRef<ProgressRepository>;
String _$userProgressHash() => r'b97bbaca29c7611c7e5dbfb31ea8f6a9a9db3bdb';

/// User progress provider
///
/// Copied from [userProgress].
@ProviderFor(userProgress)
final userProgressProvider =
    AutoDisposeStreamProvider<UserProgressEntity>.internal(
      userProgress,
      name: r'userProgressProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userProgressHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserProgressRef = AutoDisposeStreamProviderRef<UserProgressEntity>;
String _$lessonProgressHash() => r'c30ff58461271b8985cce46f81dafc7332af04e3';

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

/// Lesson progress provider
///
/// Copied from [lessonProgress].
@ProviderFor(lessonProgress)
const lessonProgressProvider = LessonProgressFamily();

/// Lesson progress provider
///
/// Copied from [lessonProgress].
class LessonProgressFamily extends Family<AsyncValue<LessonProgressEntity?>> {
  /// Lesson progress provider
  ///
  /// Copied from [lessonProgress].
  const LessonProgressFamily();

  /// Lesson progress provider
  ///
  /// Copied from [lessonProgress].
  LessonProgressProvider call(int lessonId) {
    return LessonProgressProvider(lessonId);
  }

  @override
  LessonProgressProvider getProviderOverride(
    covariant LessonProgressProvider provider,
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
  String? get name => r'lessonProgressProvider';
}

/// Lesson progress provider
///
/// Copied from [lessonProgress].
class LessonProgressProvider
    extends AutoDisposeStreamProvider<LessonProgressEntity?> {
  /// Lesson progress provider
  ///
  /// Copied from [lessonProgress].
  LessonProgressProvider(int lessonId)
    : this._internal(
        (ref) => lessonProgress(ref as LessonProgressRef, lessonId),
        from: lessonProgressProvider,
        name: r'lessonProgressProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lessonProgressHash,
        dependencies: LessonProgressFamily._dependencies,
        allTransitiveDependencies:
            LessonProgressFamily._allTransitiveDependencies,
        lessonId: lessonId,
      );

  LessonProgressProvider._internal(
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
    Stream<LessonProgressEntity?> Function(LessonProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LessonProgressProvider._internal(
        (ref) => create(ref as LessonProgressRef),
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
  AutoDisposeStreamProviderElement<LessonProgressEntity?> createElement() {
    return _LessonProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonProgressProvider && other.lessonId == lessonId;
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
mixin LessonProgressRef on AutoDisposeStreamProviderRef<LessonProgressEntity?> {
  /// The parameter `lessonId` of this provider.
  int get lessonId;
}

class _LessonProgressProviderElement
    extends AutoDisposeStreamProviderElement<LessonProgressEntity?>
    with LessonProgressRef {
  _LessonProgressProviderElement(super.provider);

  @override
  int get lessonId => (origin as LessonProgressProvider).lessonId;
}

String _$achievementsHash() => r'b1f6d0fbc3302997c0625a5be5c1b87d99ebb54e';

/// Achievements provider
///
/// Copied from [achievements].
@ProviderFor(achievements)
final achievementsProvider =
    AutoDisposeStreamProvider<List<AchievementEntity>>.internal(
      achievements,
      name: r'achievementsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$achievementsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AchievementsRef = AutoDisposeStreamProviderRef<List<AchievementEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
