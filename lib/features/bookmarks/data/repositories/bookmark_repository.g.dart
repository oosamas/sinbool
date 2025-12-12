// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookmarkRepositoryHash() =>
    r'a7e28690f87d8bd2cb18b11f203c5116ba2bbd82';

/// Bookmark repository provider
///
/// Copied from [bookmarkRepository].
@ProviderFor(bookmarkRepository)
final bookmarkRepositoryProvider =
    AutoDisposeProvider<BookmarkRepository>.internal(
      bookmarkRepository,
      name: r'bookmarkRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bookmarkRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookmarkRepositoryRef = AutoDisposeProviderRef<BookmarkRepository>;
String _$allBookmarksHash() => r'3172470fef3755e9cb0712d5a6cb3519607d76b1';

/// All bookmarks provider
///
/// Copied from [allBookmarks].
@ProviderFor(allBookmarks)
final allBookmarksProvider =
    AutoDisposeStreamProvider<List<BookmarkEntity>>.internal(
      allBookmarks,
      name: r'allBookmarksProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allBookmarksHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllBookmarksRef = AutoDisposeStreamProviderRef<List<BookmarkEntity>>;
String _$isLessonBookmarkedHash() =>
    r'd3c4f69f104ce96c1b1cd5c05259984c8aada1b0';

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

/// Is lesson bookmarked provider
///
/// Copied from [isLessonBookmarked].
@ProviderFor(isLessonBookmarked)
const isLessonBookmarkedProvider = IsLessonBookmarkedFamily();

/// Is lesson bookmarked provider
///
/// Copied from [isLessonBookmarked].
class IsLessonBookmarkedFamily extends Family<AsyncValue<bool>> {
  /// Is lesson bookmarked provider
  ///
  /// Copied from [isLessonBookmarked].
  const IsLessonBookmarkedFamily();

  /// Is lesson bookmarked provider
  ///
  /// Copied from [isLessonBookmarked].
  IsLessonBookmarkedProvider call(int lessonId) {
    return IsLessonBookmarkedProvider(lessonId);
  }

  @override
  IsLessonBookmarkedProvider getProviderOverride(
    covariant IsLessonBookmarkedProvider provider,
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
  String? get name => r'isLessonBookmarkedProvider';
}

/// Is lesson bookmarked provider
///
/// Copied from [isLessonBookmarked].
class IsLessonBookmarkedProvider extends AutoDisposeStreamProvider<bool> {
  /// Is lesson bookmarked provider
  ///
  /// Copied from [isLessonBookmarked].
  IsLessonBookmarkedProvider(int lessonId)
    : this._internal(
        (ref) => isLessonBookmarked(ref as IsLessonBookmarkedRef, lessonId),
        from: isLessonBookmarkedProvider,
        name: r'isLessonBookmarkedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isLessonBookmarkedHash,
        dependencies: IsLessonBookmarkedFamily._dependencies,
        allTransitiveDependencies:
            IsLessonBookmarkedFamily._allTransitiveDependencies,
        lessonId: lessonId,
      );

  IsLessonBookmarkedProvider._internal(
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
    Stream<bool> Function(IsLessonBookmarkedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsLessonBookmarkedProvider._internal(
        (ref) => create(ref as IsLessonBookmarkedRef),
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
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _IsLessonBookmarkedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsLessonBookmarkedProvider && other.lessonId == lessonId;
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
mixin IsLessonBookmarkedRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `lessonId` of this provider.
  int get lessonId;
}

class _IsLessonBookmarkedProviderElement
    extends AutoDisposeStreamProviderElement<bool>
    with IsLessonBookmarkedRef {
  _IsLessonBookmarkedProviderElement(super.provider);

  @override
  int get lessonId => (origin as IsLessonBookmarkedProvider).lessonId;
}

String _$bookmarksCountHash() => r'de1b4e191ab1d3890e7ca7f87d3d8448600eb674';

/// Bookmarks count provider
///
/// Copied from [bookmarksCount].
@ProviderFor(bookmarksCount)
final bookmarksCountProvider = AutoDisposeFutureProvider<int>.internal(
  bookmarksCount,
  name: r'bookmarksCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookmarksCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookmarksCountRef = AutoDisposeFutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
