import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/repositories/sync_repository.dart';
import '../../domain/entities/sync_state_entity.dart';

part 'sync_controller.g.dart';

/// Controller for managing sync state and operations
@Riverpod(keepAlive: true)
class SyncController extends _$SyncController {
  @override
  SyncStateEntity build() {
    return SyncStateEntity.initial;
  }

  SyncRepository get _repository => ref.read(syncRepositoryProvider);

  /// Perform a full sync (called after sign-in or manually)
  Future<bool> syncNow() async {
    final authState = ref.read(authControllerProvider);
    if (!authState.isAuthenticated) return false;
    if (state.status == SyncStatus.syncing) return false;

    state = state.copyWith(status: SyncStatus.syncing, clearError: true);

    try {
      await _repository.fullSync(authState.user!.uid);
      state = state.copyWith(
        status: SyncStatus.success,
        lastSyncTime: DateTime.now(),
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: SyncStatus.error,
        errorMessage: 'Sync failed. Please try again.',
      );
      return false;
    }
  }

  /// Auto-sync (called on sign-in)
  Future<void> onSignIn(String userId) async {
    state = state.copyWith(status: SyncStatus.syncing, clearError: true);

    try {
      await _repository.fullSync(userId);
      state = state.copyWith(
        status: SyncStatus.success,
        lastSyncTime: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        status: SyncStatus.error,
        errorMessage: 'Initial sync failed. Your progress is saved locally.',
      );
    }
  }

  /// Reset sync state (called on sign-out)
  void reset() {
    state = SyncStateEntity.initial;
  }
}
