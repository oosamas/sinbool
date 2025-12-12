// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioControllerHash() => r'b279c8fdfc7963053f5f2c46d384258262b4b503';

/// Audio controller for managing playback
/// From Issue #6 - Audio Player Feature
///
/// Copied from [AudioController].
@ProviderFor(AudioController)
final audioControllerProvider =
    AutoDisposeNotifierProvider<AudioController, AudioState>.internal(
      AudioController.new,
      name: r'audioControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$audioControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AudioController = AutoDisposeNotifier<AudioState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
