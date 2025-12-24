import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'content_loader_service.dart';

part 'data_initialization_service.g.dart';

/// Service for initializing content data
/// From Issue #5 - Content Domain
class DataInitializationService {
  DataInitializationService(this._contentLoader);

  final ContentLoaderService _contentLoader;

  /// Initialize content from JSON asset files
  Future<void> initializeSampleData() async {
    // Load all content from JSON files
    await _contentLoader.loadAllContent();
  }
}

/// Data initialization service provider
@riverpod
DataInitializationService dataInitializationService(
  DataInitializationServiceRef ref,
) {
  final contentLoader = ref.watch(contentLoaderServiceProvider);
  return DataInitializationService(contentLoader);
}

/// Initialize data on app start
@riverpod
Future<void> initializeData(InitializeDataRef ref) async {
  final service = ref.watch(dataInitializationServiceProvider);
  await service.initializeSampleData();
}
