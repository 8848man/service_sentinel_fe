import 'package:flutter/material.dart';

/// Color token system for ServiceSentinel
/// Supports three themes: White (Light), Black (Dark), Blue (Brand)
class AppColors {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color primary;
  final Color primaryVariant;
  final Color statusHealthy;
  final Color statusWarning;
  final Color statusCritical;
  final Color statusUnknown;
  final Color divider;
  final Color shadow;
  final Color onPrimary;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.primary,
    required this.primaryVariant,
    required this.statusHealthy,
    required this.statusWarning,
    required this.statusCritical,
    required this.statusUnknown,
    required this.divider,
    required this.shadow,
    required this.onPrimary,
  });

  /// White Theme (Light Mode)
  static const AppColors white = AppColors(
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF5F5F5),
    surfaceVariant: Color(0xFFEEEEEE),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF666666),
    textTertiary: Color(0xFF999999),
    primary: Color(0xFF2196F3),
    primaryVariant: Color(0xFF1976D2),
    statusHealthy: Color(0xFF4CAF50),
    statusWarning: Color(0xFFFF9800),
    statusCritical: Color(0xFFF44336),
    statusUnknown: Color(0xFF9E9E9E),
    divider: Color(0xFFE0E0E0),
    shadow: Color(0x1A000000),
    onPrimary: Color(0xFFFFFFFF),
  );

  /// Black Theme (Dark Mode)
  static const AppColors black = AppColors(
    background: Color(0xFF000000),
    surface: Color(0xFF1A1A1A),
    surfaceVariant: Color(0xFF2A2A2A),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF999999),
    textTertiary: Color(0xFF666666),
    primary: Color(0xFF64B5F6),
    primaryVariant: Color(0xFF42A5F5),
    statusHealthy: Color(0xFF66BB6A),
    statusWarning: Color(0xFFFFA726),
    statusCritical: Color(0xFFEF5350),
    statusUnknown: Color(0xFFBDBDBD),
    divider: Color(0xFF333333),
    shadow: Color(0x33000000),
    onPrimary: Color(0xFF000000),
  );

  /// Blue Theme (Brand Mode)
  static const AppColors blue = AppColors(
    background: Color(0xFF0D47A1),
    surface: Color(0xFF1565C0),
    surfaceVariant: Color(0xFF1976D2),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB3D9FF),
    textTertiary: Color(0xFF80B3E6),
    primary: Color(0xFF42A5F5),
    primaryVariant: Color(0xFF64B5F6),
    statusHealthy: Color(0xFF66BB6A),
    statusWarning: Color(0xFFFFB74D),
    statusCritical: Color(0xFFEF5350),
    statusUnknown: Color(0xFFE0E0E0),
    divider: Color(0xFF2979CC),
    shadow: Color(0x33000000),
    onPrimary: Color(0xFFFFFFFF),
  );
}
