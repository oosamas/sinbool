import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../sync/domain/entities/sync_state_entity.dart';
import '../../../sync/presentation/controllers/sync_controller.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../controllers/auth_controller.dart';

/// Card showing account info, sync status, and sign-out button
class AccountInfoCard extends ConsumerWidget {
  const AccountInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final syncState = ref.watch(syncControllerProvider);

    if (!authState.isAuthenticated) return const SizedBox.shrink();

    final user = authState.user!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Account info
        Container(
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  user.provider == AuthProvider.apple
                      ? Icons.apple
                      : Icons.g_mobiledata,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Linked',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (user.email != null)
                      Text(
                        user.email!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              const Icon(Icons.check_circle, color: AppColors.success, size: 20),
            ],
          ),
        ),
        const SizedBox(height: Spacing.md),

        // Sync status
        Container(
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              _SyncStatusIcon(status: syncState.status),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cloud Sync',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      _getSyncStatusText(syncState),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              // Sync now button
              TextButton(
                onPressed: syncState.status == SyncStatus.syncing
                    ? null
                    : () => ref.read(syncControllerProvider.notifier).syncNow(),
                child: Text(
                  syncState.status == SyncStatus.syncing ? 'Syncing...' : 'Sync Now',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.lg),

        // Sign out button
        OutlinedButton.icon(
          onPressed: authState.isLoading
              ? null
              : () => _showSignOutDialog(context, ref),
          icon: const Icon(Icons.logout, size: 18),
          label: const Text('Sign Out'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.error,
            side: const BorderSide(color: AppColors.error),
          ),
        ),
      ],
    );
  }

  String _getSyncStatusText(SyncStateEntity syncState) {
    switch (syncState.status) {
      case SyncStatus.idle:
        return 'Not synced yet';
      case SyncStatus.syncing:
        return 'Syncing...';
      case SyncStatus.success:
        if (syncState.lastSyncTime != null) {
          final diff = DateTime.now().difference(syncState.lastSyncTime!);
          if (diff.inMinutes < 1) return 'Synced just now';
          if (diff.inHours < 1) return 'Synced ${diff.inMinutes}m ago';
          if (diff.inDays < 1) return 'Synced ${diff.inHours}h ago';
          return 'Synced ${diff.inDays}d ago';
        }
        return 'Synced';
      case SyncStatus.error:
        return syncState.errorMessage ?? 'Sync failed';
    }
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out?'),
        content: const Text(
          'Your progress will continue to be saved locally on this device. '
          'Cloud sync will be disabled until you sign in again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              ref.read(syncControllerProvider.notifier).reset();
              await ref.read(authControllerProvider.notifier).signOut();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class _SyncStatusIcon extends StatelessWidget {
  const _SyncStatusIcon({required this.status});

  final SyncStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case SyncStatus.idle:
        return const Icon(Icons.cloud_off, color: AppColors.textHint, size: 24);
      case SyncStatus.syncing:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      case SyncStatus.success:
        return const Icon(Icons.cloud_done, color: AppColors.success, size: 24);
      case SyncStatus.error:
        return const Icon(Icons.cloud_off, color: AppColors.error, size: 24);
    }
  }
}
