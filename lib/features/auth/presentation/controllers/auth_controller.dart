import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/auth_repository.dart';
import '../../domain/entities/auth_user_entity.dart';

part 'auth_controller.g.dart';

/// State for the auth controller
class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  final AuthUserEntity? user;
  final bool isLoading;
  final String? error;

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    AuthUserEntity? user,
    bool? isLoading,
    String? error,
    bool clearUser = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Controller for managing authentication state and actions
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    // Load current auth state
    final repo = ref.read(authRepositoryProvider);
    final currentUser = repo.currentUser;

    // Listen for auth state changes
    ref.listen(authStateChangesProvider, (previous, next) {
      next.whenData((user) {
        state = state.copyWith(user: user, clearUser: user == null);
      });
    });

    return AuthState(user: currentUser);
  }

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    if (state.isLoading) return false;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _repository.signInWithApple();
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      final message = _parseAuthError(e);
      state = state.copyWith(isLoading: false, error: message);
      return false;
    }
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    if (state.isLoading) return false;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _repository.signInWithGoogle();
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      final message = _parseAuthError(e);
      state = state.copyWith(isLoading: false, error: message);
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _repository.signOut();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to sign out');
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  String _parseAuthError(Object error) {
    final message = error.toString();
    if (message.contains('cancelled') || message.contains('canceled')) {
      return 'Sign-in was cancelled';
    }
    if (message.contains('network')) {
      return 'Network error. Please check your connection.';
    }
    return 'Sign-in failed. Please try again.';
  }
}
