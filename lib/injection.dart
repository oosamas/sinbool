import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Configure all dependencies
/// Called once at app startup in main.dart
Future<void> configureDependencies() async {
  getIt
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(getIt<Connectivity>()),
    );
}
