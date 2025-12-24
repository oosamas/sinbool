import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../lessons/domain/entities/lesson_entity.dart';
import '../../data/repositories/subscription_repository.dart';

part 'access_control_provider.g.dart';

/// Provider to check if a lesson can be accessed
/// First lesson of each chapter (sortOrder == 1) is always free
@riverpod
Future<bool> canAccessLesson(CanAccessLessonRef ref, LessonEntity lesson) async {
  // First lesson of any chapter is always FREE
  if (lesson.sortOrder == 1) {
    return true;
  }

  // Non-premium content is always accessible
  if (!lesson.isPremium) {
    return true;
  }

  // Check subscription status for premium content
  final isSubscribed = await ref.watch(isSubscribedProvider.future);
  return isSubscribed;
}

/// Provider to check if user has premium access
@riverpod
Future<bool> hasPremiumAccess(HasPremiumAccessRef ref) async {
  return ref.watch(isSubscribedProvider.future);
}

/// Provider that returns whether a lesson at a given position is free
/// Position 1 (first lesson) is always free
@riverpod
bool isLessonPositionFree(IsLessonPositionFreeRef ref, int sortOrder) {
  return sortOrder == 1;
}

/// Extension to check lesson access synchronously when status is known
extension LessonAccessExtension on LessonEntity {
  /// Check if this lesson is accessible with the given subscription status
  bool isAccessibleWith({required bool isSubscribed}) {
    // First lesson is always free
    if (sortOrder == 1) return true;

    // Non-premium content is free
    if (!isPremium) return true;

    // Premium content requires subscription
    return isSubscribed;
  }

  /// Check if this lesson is free (first lesson or non-premium)
  bool get isFreeLesson => sortOrder == 1 || !isPremium;

  /// Check if this lesson requires subscription
  bool get requiresSubscription => isPremium && sortOrder != 1;
}
