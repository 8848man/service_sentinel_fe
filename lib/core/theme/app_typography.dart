import 'package:flutter/material.dart';

/// Typography system for ServiceSentinel
class AppTypography {
  AppTypography._();

  /// Heading Large - 28sp, bold
  /// Used for: Screen titles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  /// Heading Large Web - 36sp, bold
  /// Used for: Screen titles on web
  static const TextStyle headingLargeWeb = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  /// Heading Medium - 20sp, semibold
  /// Used for: Section headers
  static const TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Heading Small - 18sp, semibold
  /// Used for: Card titles
  static const TextStyle headingSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Body - 16sp, regular
  /// Used for: Primary text content
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Body Medium - 16sp, medium
  /// Used for: Emphasized body text
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  /// Body Small - 14sp, regular
  /// Used for: Secondary text content
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Caption - 14sp, regular
  /// Used for: Descriptions, metadata
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Label - 12sp, medium
  /// Used for: Input labels, badges, chips
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
  );

  /// Label Small - 10sp, medium
  /// Used for: Very small labels, timestamps
  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.5,
  );

  /// Button - 14sp, medium
  /// Used for: Button text
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.5,
  );

  /// Button Large - 16sp, medium
  /// Used for: Large button text
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.5,
  );
}
