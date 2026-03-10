/// Status of the sync operation
enum SyncStatus {
  idle,
  syncing,
  success,
  error,
}

/// Entity representing the current sync state
class SyncStateEntity {
  const SyncStateEntity({
    this.status = SyncStatus.idle,
    this.lastSyncTime,
    this.errorMessage,
  });

  final SyncStatus status;
  final DateTime? lastSyncTime;
  final String? errorMessage;

  static const SyncStateEntity initial = SyncStateEntity();

  SyncStateEntity copyWith({
    SyncStatus? status,
    DateTime? lastSyncTime,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SyncStateEntity(
      status: status ?? this.status,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
