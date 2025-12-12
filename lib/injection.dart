import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Configure all dependencies
/// Called once at app startup in main.dart
Future<void> configureDependencies() async {
  // Core
  _registerCore();

  // Data sources
  _registerDataSources();

  // Repositories
  _registerRepositories();

  // Use cases
  _registerUseCases();
}

void _registerCore() {
  // Network Info
  getIt
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(getIt<Connectivity>()),
    );

  // API Client (will be added in Issue #19)
  // getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Local Database (will be added in Issue #93 implementation)
  // getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Secure Storage (will be added in Issue #20)
  // getIt.registerLazySingleton<FlutterSecureStorage>(
  //   () => const FlutterSecureStorage(),
  // );
}

void _registerDataSources() {
  // Remote data sources will be registered here
  // Example:
  // getIt.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(getIt<ApiClient>()),
  // );
}

void _registerRepositories() {
  // Repositories will be registered here
  // Example:
  // getIt.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(
  //     remoteDataSource: getIt<AuthRemoteDataSource>(),
  //     networkInfo: getIt<NetworkInfo>(),
  //   ),
  // );
}

void _registerUseCases() {
  // Use cases will be registered here
  // Example:
  // getIt.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(getIt<AuthRepository>()),
  // );
}
