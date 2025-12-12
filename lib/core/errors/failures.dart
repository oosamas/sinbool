import 'package:equatable/equatable.dart';

/// Base failure class for domain layer error handling
/// From Issue #92 - Error Handling Patterns
abstract class Failure extends Equatable {
  const Failure({required this.message, this.code});

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

/// Server-side error
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred'})
      : super(code: 'SERVER_ERROR');
}

/// Network connectivity error
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'})
      : super(code: 'NETWORK_ERROR');
}

/// Local cache/storage error
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Failed to load cached data'})
      : super(code: 'CACHE_ERROR');
}

/// Authentication related errors
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});

  factory AuthFailure.invalidCredentials() => const AuthFailure(
        message: 'Invalid email or password',
        code: 'INVALID_CREDENTIALS',
      );

  factory AuthFailure.sessionExpired() => const AuthFailure(
        message: 'Session expired. Please login again',
        code: 'SESSION_EXPIRED',
      );

  factory AuthFailure.unauthorized() => const AuthFailure(
        message: 'You are not authorized to perform this action',
        code: 'UNAUTHORIZED',
      );

  factory AuthFailure.emailAlreadyInUse() => const AuthFailure(
        message: 'This email is already registered',
        code: 'EMAIL_IN_USE',
      );
}

/// Input validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Validation failed',
    this.fieldErrors = const {},
  }) : super(code: 'VALIDATION_ERROR');

  final Map<String, String> fieldErrors;

  @override
  List<Object?> get props => [message, code, fieldErrors];
}

/// Resource not found
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Resource not found'})
      : super(code: 'NOT_FOUND');
}

/// Rate limiting error
class RateLimitFailure extends Failure {
  const RateLimitFailure({super.message = 'Too many requests. Please wait.'})
      : super(code: 'RATE_LIMITED');
}

/// Permission denied
class PermissionFailure extends Failure {
  const PermissionFailure({super.message = 'Permission denied'})
      : super(code: 'PERMISSION_DENIED');
}
