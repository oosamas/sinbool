// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inAppPurchaseHash() => r'120d8bc1395647ddc3cd22546a5b073b0f35db1a';

/// In-App Purchase instance provider
///
/// Copied from [inAppPurchase].
@ProviderFor(inAppPurchase)
final inAppPurchaseProvider = Provider<InAppPurchase>.internal(
  inAppPurchase,
  name: r'inAppPurchaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inAppPurchaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InAppPurchaseRef = ProviderRef<InAppPurchase>;
String _$subscriptionRepositoryHash() =>
    r'66980ffe01a99da1ee775ff1c25582bb95d61f5d';

/// Subscription repository provider
///
/// Copied from [subscriptionRepository].
@ProviderFor(subscriptionRepository)
final subscriptionRepositoryProvider =
    Provider<SubscriptionRepository>.internal(
      subscriptionRepository,
      name: r'subscriptionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscriptionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionRepositoryRef = ProviderRef<SubscriptionRepository>;
String _$subscriptionStatusHash() =>
    r'54c3a2eaf74095564e65f91d9974c30997e105a9';

/// Subscription status provider
///
/// Copied from [subscriptionStatus].
@ProviderFor(subscriptionStatus)
final subscriptionStatusProvider =
    AutoDisposeFutureProvider<SubscriptionStatus>.internal(
      subscriptionStatus,
      name: r'subscriptionStatusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscriptionStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionStatusRef =
    AutoDisposeFutureProviderRef<SubscriptionStatus>;
String _$subscriptionStatusStreamHash() =>
    r'4d34aab68755822e5b71d51b0b9826b3fb348943';

/// Subscription status stream provider
///
/// Copied from [subscriptionStatusStream].
@ProviderFor(subscriptionStatusStream)
final subscriptionStatusStreamProvider =
    AutoDisposeStreamProvider<SubscriptionStatus>.internal(
      subscriptionStatusStream,
      name: r'subscriptionStatusStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subscriptionStatusStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionStatusStreamRef =
    AutoDisposeStreamProviderRef<SubscriptionStatus>;
String _$isSubscribedHash() => r'909569052035cc80f03b21c8e3b6bdbdffec9351';

/// Is subscribed provider - simple boolean check
///
/// Copied from [isSubscribed].
@ProviderFor(isSubscribed)
final isSubscribedProvider = AutoDisposeFutureProvider<bool>.internal(
  isSubscribed,
  name: r'isSubscribedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isSubscribedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsSubscribedRef = AutoDisposeFutureProviderRef<bool>;
String _$availableProductsHash() => r'b191c6d3b30df5a9d253ccb694d56522cf2b4a8f';

/// Available products provider
///
/// Copied from [availableProducts].
@ProviderFor(availableProducts)
final availableProductsProvider =
    AutoDisposeFutureProvider<List<ProductDetails>>.internal(
      availableProducts,
      name: r'availableProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$availableProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AvailableProductsRef =
    AutoDisposeFutureProviderRef<List<ProductDetails>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
