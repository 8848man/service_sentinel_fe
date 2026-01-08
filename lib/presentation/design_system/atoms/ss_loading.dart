import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// ServiceSentinel Loading Component
///
/// A themed loading indicator with optional message.
class SSLoading extends StatelessWidget {
  final String? message;
  final double? size;
  final bool center;

  const SSLoading({
    super.key,
    this.message,
    this.size,
    this.center = true,
  });

  /// Small loading indicator
  const SSLoading.small({
    super.key,
    this.message,
    this.center = true,
  }) : size = 16;

  /// Medium loading indicator
  const SSLoading.medium({
    super.key,
    this.message,
    this.center = true,
  }) : size = 24;

  /// Large loading indicator
  const SSLoading.large({
    super.key,
    this.message,
    this.center = true,
  }) : size = 32;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size ?? 24,
          height: size ?? 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            message!,
            style: AppTypography.body.copyWith(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (center) {
      return Center(child: content);
    }

    return content;
  }
}
