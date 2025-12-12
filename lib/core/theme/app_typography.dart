import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Typography system for Sinbool app
/// From Issue #2 - Design System & Issue #32 - Branding
class AppTypography {
  AppTypography._();

  /// Primary font for UI text (Latin scripts)
  static const String fontFamily = 'Poppins';

  /// Arabic/Urdu font for Quranic text
  static const String arabicFontFamily = 'Amiri';

  /// Light theme text theme
  static TextTheme get lightTextTheme => _buildTextTheme(AppColors.textPrimary);

  /// Dark theme text theme
  static TextTheme get darkTextTheme =>
      _buildTextTheme(AppColors.darkTextPrimary);

  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      // Display styles - for large hero text
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      // Headline styles - for section headers
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),

      // Title styles - for card titles, list items
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textColor,
      ),

      // Body styles - for content text
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.5,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: textColor,
      ),

      // Label styles - for buttons, chips
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textColor,
      ),
    );
  }

  /// Arabic text style for Quranic verses
  static TextStyle quranArabic({
    double fontSize = 24,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: arabicFontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 2.0,
      color: color ?? AppColors.textPrimary,
    );
  }

  /// Style for Quran verse translation
  static TextStyle quranTranslation({
    double fontSize = 16,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      height: 1.6,
      color: color ?? AppColors.textSecondary,
    );
  }

  /// Style for story content - child-friendly reading
  static TextStyle storyContent({
    required int readingLevel,
    Color? color,
  }) {
    // Adjust font size based on reading level
    final fontSize = switch (readingLevel) {
      1 => 20.0, // Early readers (5-7)
      2 => 18.0, // Developing readers (8-10)
      _ => 16.0, // Independent readers (11-12)
    };

    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      height: 1.8,
      color: color ?? AppColors.textPrimary,
    );
  }
}
