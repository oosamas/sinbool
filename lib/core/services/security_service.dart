import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Security service for handling sensitive data and security features
/// COPPA compliant - no personal data collection from children
class SecurityService {
  SecurityService._();

  static final SecurityService _instance = SecurityService._();
  static SecurityService get instance => _instance;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: 'sinbool_secure_prefs',
      preferencesKeyPrefix: 'sinbool_',
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
      accountName: 'sinbool_account',
    ),
  );

  /// Hash a string using SHA-256 (for PIN storage)
  String hashString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verify a hashed string
  bool verifyHash(String input, String hash) {
    return hashString(input) == hash;
  }

  /// Store a value securely
  Future<void> storeSecure(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      if (kDebugMode) {
        print('SecurityService: Failed to store secure value: $e');
      }
    }
  }

  /// Read a secure value
  Future<String?> readSecure(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      if (kDebugMode) {
        print('SecurityService: Failed to read secure value: $e');
      }
      return null;
    }
  }

  /// Delete a secure value
  Future<void> deleteSecure(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      if (kDebugMode) {
        print('SecurityService: Failed to delete secure value: $e');
      }
    }
  }

  /// Clear all secure storage
  Future<void> clearAllSecure() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      if (kDebugMode) {
        print('SecurityService: Failed to clear secure storage: $e');
      }
    }
  }

  /// Validate parental PIN format (4-6 digits)
  bool isValidPin(String pin) {
    if (pin.length < 4 || pin.length > 6) return false;
    return RegExp(r'^\d+$').hasMatch(pin);
  }

  /// Store parental PIN (hashed)
  Future<void> storeParentalPin(String pin) async {
    if (!isValidPin(pin)) {
      throw ArgumentError('Invalid PIN format. Must be 4-6 digits.');
    }
    final hashedPin = hashString(pin);
    await storeSecure('parental_pin', hashedPin);
  }

  /// Verify parental PIN
  Future<bool> verifyParentalPin(String pin) async {
    final storedHash = await readSecure('parental_pin');
    if (storedHash == null) return false;
    return verifyHash(pin, storedHash);
  }

  /// Check if parental PIN is set
  Future<bool> hasParentalPin() async {
    final storedHash = await readSecure('parental_pin');
    return storedHash != null;
  }

  /// Remove parental PIN
  Future<void> removeParentalPin() async {
    await deleteSecure('parental_pin');
  }

  /// Sanitize user input to prevent injection attacks
  String sanitizeInput(String input) {
    // Remove potentially dangerous characters
    return input
        .replaceAll(RegExp(r'[<>"' "'" r']'), '')
        .replaceAll(RegExp(r'[\x00-\x1f\x7f]'), '')
        .trim();
  }

  /// Check if app is running in a secure environment
  bool get isSecureEnvironment {
    // In debug mode, we're not in a secure environment
    if (kDebugMode) return false;

    // In release mode, assume secure
    return kReleaseMode;
  }
}

/// Security keys for secure storage
class SecureStorageKeys {
  SecureStorageKeys._();

  static const String parentalPin = 'parental_pin';
  static const String deviceId = 'device_id';
  static const String sessionToken = 'session_token';
  static const String lastSyncTime = 'last_sync_time';
}
