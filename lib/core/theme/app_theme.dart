import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Theme mode enum for ServiceSentinel
enum AppThemeMode {
  white,
  black,
  blue,
}

/// App theme configuration
class AppTheme {
  AppTheme._();

  /// Get ThemeData for a specific theme mode
  static ThemeData getTheme(AppThemeMode mode) {
    final colors = _getColors(mode);

    return ThemeData(
      useMaterial3: true,
      brightness: mode == AppThemeMode.white ? Brightness.light : Brightness.dark,

      // Color scheme
      colorScheme: ColorScheme(
        brightness: mode == AppThemeMode.white ? Brightness.light : Brightness.dark,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.primaryVariant,
        onSecondary: colors.onPrimary,
        error: colors.statusCritical,
        onError: Colors.white,
        surface: colors.surface,
        onSurface: colors.textPrimary,
      ),

      // Scaffold
      scaffoldBackgroundColor: colors.background,

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        titleTextStyle: AppTypography.headingMedium.copyWith(
          color: colors.textPrimary,
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTypography.headingLarge.copyWith(color: colors.textPrimary),
        displayMedium: AppTypography.headingMedium.copyWith(color: colors.textPrimary),
        displaySmall: AppTypography.headingSmall.copyWith(color: colors.textPrimary),
        bodyLarge: AppTypography.body.copyWith(color: colors.textPrimary),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: colors.textPrimary),
        bodySmall: AppTypography.bodySmall.copyWith(color: colors.textSecondary),
        labelLarge: AppTypography.label.copyWith(color: colors.textSecondary),
        labelMedium: AppTypography.labelSmall.copyWith(color: colors.textTertiary),
      ),

      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: BorderSide(color: colors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.statusCritical),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: AppTypography.body.copyWith(color: colors.textSecondary),
        hintStyle: AppTypography.body.copyWith(color: colors.textTertiary),
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),

      // Icon theme
      iconTheme: IconThemeData(
        color: colors.textSecondary,
        size: 24,
      ),

      // Bottom navigation bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Navigation rail
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surface,
        selectedIconTheme: IconThemeData(color: colors.primary),
        unselectedIconTheme: IconThemeData(color: colors.textSecondary),
        selectedLabelTextStyle: AppTypography.label.copyWith(color: colors.primary),
        unselectedLabelTextStyle: AppTypography.label.copyWith(color: colors.textSecondary),
      ),
    );
  }

  /// Get AppColors for a specific theme mode
  static AppColors _getColors(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.white:
        return AppColors.white;
      case AppThemeMode.black:
        return AppColors.black;
      case AppThemeMode.blue:
        return AppColors.blue;
    }
  }

  /// Get AppColors for current theme mode
  static AppColors getColorsForMode(AppThemeMode mode) {
    return _getColors(mode);
  }
}
