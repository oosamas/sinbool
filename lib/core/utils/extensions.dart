import 'package:flutter/material.dart';

/// String extensions
extension StringExtension on String {
  /// Capitalizes the first letter of the string
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes the first letter of each word
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Checks if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Truncates string to specified length with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

/// DateTime extensions
extension DateTimeExtension on DateTime {
  /// Checks if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Returns relative time string (e.g., "2 hours ago")
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year(s) ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month(s) ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    } else {
      return 'Just now';
    }
  }
}

/// BuildContext extensions for easy access to theme and media query
extension BuildContextExtension on BuildContext {
  /// Access theme data
  ThemeData get theme => Theme.of(this);

  /// Access text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Access color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Access media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen width
  double get screenWidth => mediaQuery.size.width;

  /// Screen height
  double get screenHeight => mediaQuery.size.height;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;

  /// Check if dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if RTL
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}

/// Nullable extensions
extension NullableExtension<T> on T? {
  /// Returns the value or a default
  T orDefault(T defaultValue) => this ?? defaultValue;
}

/// List extensions
extension ListExtension<T> on List<T> {
  /// Safe get at index, returns null if out of bounds
  T? safeGet(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}
