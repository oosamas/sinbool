// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_control_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$canAccessLessonHash() => r'982718b832736d3fcf340f744e7629f0abff39d7';

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

/// Provider to check if a lesson can be accessed
/// First lesson of each chapter (sortOrder == 1) is always free
///
/// Copied from [canAccessLesson].
@ProviderFor(canAccessLesson)
const canAccessLessonProvider = CanAccessLessonFamily();

/// Provider to check if a lesson can be accessed
/// First lesson of each chapter (sortOrder == 1) is always free
///
/// Copied from [canAccessLesson].
class CanAccessLessonFamily extends Family<AsyncValue<bool>> {
  /// Provider to check if a lesson can be accessed
  /// First lesson of each chapter (sortOrder == 1) is always free
  ///
  /// Copied from [canAccessLesson].
  const CanAccessLessonFamily();

  /// Provider to check if a lesson can be accessed
  /// First lesson of each chapter (sortOrder == 1) is always free
  ///
  /// Copied from [canAccessLesson].
  CanAccessLessonProvider call(LessonEntity lesson) {
    return CanAccessLessonProvider(lesson);
  }

  @override
  CanAccessLessonProvider getProviderOverride(
    covariant CanAccessLessonProvider provider,
  ) {
    return call(provider.lesson);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'canAccessLessonProvider';
}

/// Provider to check if a lesson can be accessed
/// First lesson of each chapter (sortOrder == 1) is always free
///
/// Copied from [canAccessLesson].
class CanAccessLessonProvider extends AutoDisposeFutureProvider<bool> {
  /// Provider to check if a lesson can be accessed
  /// First lesson of each chapter (sortOrder == 1) is always free
  ///
  /// Copied from [canAccessLesson].
  CanAccessLessonProvider(LessonEntity lesson)
    : this._internal(
        (ref) => canAccessLesson(ref as CanAccessLessonRef, lesson),
        from: canAccessLessonProvider,
        name: r'canAccessLessonProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$canAccessLessonHash,
        dependencies: CanAccessLessonFamily._dependencies,
        allTransitiveDependencies:
            CanAccessLessonFamily._allTransitiveDependencies,
        lesson: lesson,
      );

  CanAccessLessonProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lesson,
  }) : super.internal();

  final LessonEntity lesson;

  @override
  Override overrideWith(
    FutureOr<bool> Function(CanAccessLessonRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CanAccessLessonProvider._internal(
        (ref) => create(ref as CanAccessLessonRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lesson: lesson,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _CanAccessLessonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CanAccessLessonProvider && other.lesson == lesson;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lesson.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CanAccessLessonRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `lesson` of this provider.
  LessonEntity get lesson;
}

class _CanAccessLessonProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with CanAccessLessonRef {
  _CanAccessLessonProviderElement(super.provider);

  @override
  LessonEntity get lesson => (origin as CanAccessLessonProvider).lesson;
}

String _$hasPremiumAccessHash() => r'156b872e3c6eb8e256fbd0fa9e87c3463b9dc0a9';

/// Provider to check if user has premium access
///
/// Copied from [hasPremiumAccess].
@ProviderFor(hasPremiumAccess)
final hasPremiumAccessProvider = AutoDisposeFutureProvider<bool>.internal(
  hasPremiumAccess,
  name: r'hasPremiumAccessProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasPremiumAccessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasPremiumAccessRef = AutoDisposeFutureProviderRef<bool>;
String _$isLessonPositionFreeHash() =>
    r'3a3de5787524066da29935b1ed7bd074c79095ca';

/// Provider that returns whether a lesson at a given position is free
/// Position 1 (first lesson) is always free
///
/// Copied from [isLessonPositionFree].
@ProviderFor(isLessonPositionFree)
const isLessonPositionFreeProvider = IsLessonPositionFreeFamily();

/// Provider that returns whether a lesson at a given position is free
/// Position 1 (first lesson) is always free
///
/// Copied from [isLessonPositionFree].
class IsLessonPositionFreeFamily extends Family<bool> {
  /// Provider that returns whether a lesson at a given position is free
  /// Position 1 (first lesson) is always free
  ///
  /// Copied from [isLessonPositionFree].
  const IsLessonPositionFreeFamily();

  /// Provider that returns whether a lesson at a given position is free
  /// Position 1 (first lesson) is always free
  ///
  /// Copied from [isLessonPositionFree].
  IsLessonPositionFreeProvider call(int sortOrder) {
    return IsLessonPositionFreeProvider(sortOrder);
  }

  @override
  IsLessonPositionFreeProvider getProviderOverride(
    covariant IsLessonPositionFreeProvider provider,
  ) {
    return call(provider.sortOrder);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isLessonPositionFreeProvider';
}

/// Provider that returns whether a lesson at a given position is free
/// Position 1 (first lesson) is always free
///
/// Copied from [isLessonPositionFree].
class IsLessonPositionFreeProvider extends AutoDisposeProvider<bool> {
  /// Provider that returns whether a lesson at a given position is free
  /// Position 1 (first lesson) is always free
  ///
  /// Copied from [isLessonPositionFree].
  IsLessonPositionFreeProvider(int sortOrder)
    : this._internal(
        (ref) =>
            isLessonPositionFree(ref as IsLessonPositionFreeRef, sortOrder),
        from: isLessonPositionFreeProvider,
        name: r'isLessonPositionFreeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isLessonPositionFreeHash,
        dependencies: IsLessonPositionFreeFamily._dependencies,
        allTransitiveDependencies:
            IsLessonPositionFreeFamily._allTransitiveDependencies,
        sortOrder: sortOrder,
      );

  IsLessonPositionFreeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sortOrder,
  }) : super.internal();

  final int sortOrder;

  @override
  Override overrideWith(
    bool Function(IsLessonPositionFreeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsLessonPositionFreeProvider._internal(
        (ref) => create(ref as IsLessonPositionFreeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sortOrder: sortOrder,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsLessonPositionFreeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsLessonPositionFreeProvider &&
        other.sortOrder == sortOrder;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sortOrder.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsLessonPositionFreeRef on AutoDisposeProviderRef<bool> {
  /// The parameter `sortOrder` of this provider.
  int get sortOrder;
}

class _IsLessonPositionFreeProviderElement
    extends AutoDisposeProviderElement<bool>
    with IsLessonPositionFreeRef {
  _IsLessonPositionFreeProviderElement(super.provider);

  @override
  int get sortOrder => (origin as IsLessonPositionFreeProvider).sortOrder;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
