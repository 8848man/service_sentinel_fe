import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../presentation/providers/theme_provider.dart';

/// Status type for services
enum SSStatusType {
  healthy,
  warning,
  down,
  unknown,
}

/// ServiceSentinel Status Indicator Component
///
/// Displays a status with icon and text.
/// Used for service health status display.
class SSStatusIndicator extends ConsumerWidget {
  final SSStatusType status;
  final String text;
  final bool showIcon;
  final bool compact;

  const SSStatusIndicator({
    super.key,
    required this.status,
    required this.text,
    this.showIcon = true,
    this.compact = false,
  });

  /// Healthy status indicator
  const SSStatusIndicator.healthy({
    super.key,
    required this.text,
    this.showIcon = true,
    this.compact = false,
  }) : status = SSStatusType.healthy;

  /// Warning status indicator
  const SSStatusIndicator.warning({
    super.key,
    required this.text,
    this.showIcon = true,
    this.compact = false,
  }) : status = SSStatusType.warning;

  /// Down status indicator
  const SSStatusIndicator.down({
    super.key,
    required this.text,
    this.showIcon = true,
    this.compact = false,
  }) : status = SSStatusType.down;

  /// Unknown status indicator
  const SSStatusIndicator.unknown({
    super.key,
    required this.text,
    this.showIcon = true,
    this.compact = false,
  }) : status = SSStatusType.unknown;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);
    final statusColor = _getStatusColor(colors);
    final statusIcon = _getStatusIcon();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Icon(
            statusIcon,
            size: compact ? 16 : 20,
            color: statusColor,
          ),
          SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
        ],
        Text(
          text,
          style: (compact ? AppTypography.label : AppTypography.body).copyWith(
            color: statusColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(AppColors colors) {
    switch (status) {
      case SSStatusType.healthy:
        return colors.statusHealthy;
      case SSStatusType.warning:
        return colors.statusWarning;
      case SSStatusType.down:
        return colors.statusCritical;
      case SSStatusType.unknown:
        return colors.statusUnknown;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case SSStatusType.healthy:
        return Icons.check_circle;
      case SSStatusType.warning:
        return Icons.warning;
      case SSStatusType.down:
        return Icons.error;
      case SSStatusType.unknown:
        return Icons.help_outline;
    }
  }
}
