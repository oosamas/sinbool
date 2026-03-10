import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/auth_user_entity.dart';
import '../services/apple_sign_in_service.dart';
import '../services/google_sign_in_service.dart';

part 'auth_repository.g.dart';

/// Repository for authentication operations
class AuthRepository {
  AuthRepository(this._firebaseAuth, this._appleService, this._googleService);

  final FirebaseAuth _firebaseAuth;
  final AppleSignInService _appleService;
  final GoogleSignInService _googleService;

  /// Get the current authenticated user, or null
  AuthUserEntity? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return _mapFirebaseUser(user);
  }

  /// Watch authentication state changes
  Stream<AuthUserEntity?> watchAuthState() {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return _mapFirebaseUser(user);
    });
  }

  /// Sign in with Apple
  Future<AuthUserEntity> signInWithApple() async {
    final credential = await _appleService.getCredential();
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return _mapFirebaseUser(userCredential.user!);
  }

  /// Sign in with Google
  Future<AuthUserEntity> signInWithGoogle() async {
    final credential = await _googleService.getCredential();
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return _mapFirebaseUser(userCredential.user!);
  }

  /// Sign out
  Future<void> signOut() async {
    await _googleService.signOut();
    await _firebaseAuth.signOut();
  }

  /// Map Firebase User to our entity
  AuthUserEntity _mapFirebaseUser(User user) {
    final providerData = user.providerData;
    AuthProvider provider = AuthProvider.google;

    for (final info in providerData) {
      if (info.providerId == 'apple.com') {
        provider = AuthProvider.apple;
        break;
      }
    }

    return AuthUserEntity(
      uid: user.uid,
      provider: provider,
      email: user.email,
      displayName: user.displayName,
    );
  }
}

/// Firebase Auth instance provider
@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

/// Auth repository provider
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRepository(
    firebaseAuth,
    AppleSignInService(),
    GoogleSignInService(),
  );
}

/// Auth state stream provider
@riverpod
Stream<AuthUserEntity?> authStateChanges(AuthStateChangesRef ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.watchAuthState();
}
