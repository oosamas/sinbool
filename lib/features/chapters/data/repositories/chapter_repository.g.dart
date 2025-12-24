// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chapterRepositoryHash() => r'82f94d2e5089c27185d4cf2fe97deaaf996d7577';

/// Chapter repository provider
///
/// Copied from [chapterRepository].
@ProviderFor(chapterRepository)
final chapterRepositoryProvider =
    AutoDisposeProvider<ChapterRepository>.internal(
      chapterRepository,
      name: r'chapterRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chapterRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChapterRepositoryRef = AutoDisposeProviderRef<ChapterRepository>;
String _$chaptersHash() => r'650170c4bf5564d2aceaf1cfa93f2b6660d44e40';

/// All chapters provider
///
/// Copied from [chapters].
@ProviderFor(chapters)
final chaptersProvider =
    AutoDisposeStreamProvider<List<ChapterEntity>>.internal(
      chapters,
      name: r'chaptersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chaptersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChaptersRef = AutoDisposeStreamProviderRef<List<ChapterEntity>>;
String _$chapterHash() => r'7f3424c882e847a5acfce49813b58c7e528b8e9e';

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

/// Single chapter provider
///
/// Copied from [chapter].
@ProviderFor(chapter)
const chapterProvider = ChapterFamily();

/// Single chapter provider
///
/// Copied from [chapter].
class ChapterFamily extends Family<AsyncValue<ChapterEntity?>> {
  /// Single chapter provider
  ///
  /// Copied from [chapter].
  const ChapterFamily();

  /// Single chapter provider
  ///
  /// Copied from [chapter].
  ChapterProvider call(String serverId) {
    return ChapterProvider(serverId);
  }

  @override
  ChapterProvider getProviderOverride(covariant ChapterProvider provider) {
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
  String? get name => r'chapterProvider';
}

/// Single chapter provider
///
/// Copied from [chapter].
class ChapterProvider extends AutoDisposeFutureProvider<ChapterEntity?> {
  /// Single chapter provider
  ///
  /// Copied from [chapter].
  ChapterProvider(String serverId)
    : this._internal(
        (ref) => chapter(ref as ChapterRef, serverId),
        from: chapterProvider,
        name: r'chapterProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chapterHash,
        dependencies: ChapterFamily._dependencies,
        allTransitiveDependencies: ChapterFamily._allTransitiveDependencies,
        serverId: serverId,
      );

  ChapterProvider._internal(
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
    FutureOr<ChapterEntity?> Function(ChapterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChapterProvider._internal(
        (ref) => create(ref as ChapterRef),
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
  AutoDisposeFutureProviderElement<ChapterEntity?> createElement() {
    return _ChapterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChapterProvider && other.serverId == serverId;
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
mixin ChapterRef on AutoDisposeFutureProviderRef<ChapterEntity?> {
  /// The parameter `serverId` of this provider.
  String get serverId;
}

class _ChapterProviderElement
    extends AutoDisposeFutureProviderElement<ChapterEntity?>
    with ChapterRef {
  _ChapterProviderElement(super.provider);

  @override
  String get serverId => (origin as ChapterProvider).serverId;
}

String _$filteredChaptersHash() => r'bcadede05fd045b18e8a8a716e3edba19207e11c';

/// Filtered chapters provider with search and category filter
///
/// Copied from [FilteredChapters].
@ProviderFor(FilteredChapters)
final filteredChaptersProvider =
    AutoDisposeNotifierProvider<
      FilteredChapters,
      AsyncValue<List<ChapterEntity>>
    >.internal(
      FilteredChapters.new,
      name: r'filteredChaptersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredChaptersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FilteredChapters =
    AutoDisposeNotifier<AsyncValue<List<ChapterEntity>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
