// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsRepositoryHash() =>
    r'10c2c94e31c0fade14f11a5820eab660ad8b4aaa';

/// Settings repository provider
///
/// Copied from [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider =
    AutoDisposeProvider<SettingsRepository>.internal(
      settingsRepository,
      name: r'settingsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$settingsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsRepositoryRef = AutoDisposeProviderRef<SettingsRepository>;
String _$appSettingsHash() => r'5d7da95c4a789f945427ba0169f4b8677dfc1e98';

/// App settings provider
///
/// Copied from [appSettings].
@ProviderFor(appSettings)
final appSettingsProvider =
    AutoDisposeFutureProvider<AppSettingsEntity>.internal(
      appSettings,
      name: r'appSettingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppSettingsRef = AutoDisposeFutureProviderRef<AppSettingsEntity>;
String _$themeModeStreamHash() => r'889980bfe4e060b99c4e2e513cca831c55106e0e';

/// Theme mode stream provider
///
/// Copied from [themeModeStream].
@ProviderFor(themeModeStream)
final themeModeStreamProvider = AutoDisposeStreamProvider<ThemeMode>.internal(
  themeModeStream,
  name: r'themeModeStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeModeStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeModeStreamRef = AutoDisposeStreamProviderRef<ThemeMode>;
String _$languageStreamHash() => r'dd0197afc952c813337bf68e1d713394e79432c4';

/// Language stream provider
///
/// Copied from [languageStream].
@ProviderFor(languageStream)
final languageStreamProvider = AutoDisposeStreamProvider<String>.internal(
  languageStream,
  name: r'languageStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$languageStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LanguageStreamRef = AutoDisposeStreamProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
