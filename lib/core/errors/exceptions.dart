/// Base exception for data layer errors
/// From Issue #92 - Error Handling Patterns
abstract class AppException implements Exception {
  const AppException({required this.message, this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Server-side exception
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    this.statusCode,
  });

  final int? statusCode;
}

/// Network connectivity exception
class NetworkException extends AppException {
  const NetworkException({super.message = 'No internet connection'})
      : super(code: 'NETWORK_ERROR');
}

/// Local cache/storage exception
class CacheException extends AppException {
  const CacheException({super.message = 'Cache operation failed'})
      : super(code: 'CACHE_ERROR');
}

/// Authentication exception
class AuthException extends AppException {
  const AuthException({required super.message, super.code});
}

/// Validation exception
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    this.fieldErrors = const {},
  }) : super(code: 'VALIDATION_ERROR');

  final Map<String, String> fieldErrors;
}

/// Resource not found exception
class NotFoundException extends AppException {
  const NotFoundException({super.message = 'Resource not found'})
      : super(code: 'NOT_FOUND');
}

/// Timeout exception
class TimeoutException extends AppException {
  const TimeoutException({super.message = 'Request timed out'})
      : super(code: 'TIMEOUT');
}
