import 'package:equatable/equatable.dart';

/// Authentication provider type
enum AuthProvider {
  apple,
  google,
}

/// Entity representing an authenticated user
class AuthUserEntity extends Equatable {
  const AuthUserEntity({
    required this.uid,
    required this.provider,
    this.email,
    this.displayName,
  });

  final String uid;
  final AuthProvider provider;
  final String? email;
  final String? displayName;

  @override
  List<Object?> get props => [uid, provider, email, displayName];
}
