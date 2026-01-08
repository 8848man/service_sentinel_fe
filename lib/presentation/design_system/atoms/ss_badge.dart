import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../presentation/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Badge type for status indication
enum SSBadgeType {
  healthy,
  warning,
  critical,
  unknown,
  info,
}

/// ServiceSentinel Badge Component
///
/// A small badge component for displaying status or labels.
/// Colors are theme-aware and adapt to the current theme.
class SSBadge extends ConsumerWidget {
  final String text;
  final SSBadgeType type;
  final bool showDot;

  const SSBadge({
    super.key,
    required this.text,
    required this.type,
    this.showDot = true,
  });

  /// Healthy status badge
  const SSBadge.healthy({
    super.key,
    required this.text,
    this.showDot = true,
  }) : type = SSBadgeType.healthy;

  /// Warning status badge
  const SSBadge.warning({
    super.key,
    required this.text,
    this.showDot = true,
  }) : type = SSBadgeType.warning;

  /// Critical status badge
  const SSBadge.critical({
    super.key,
    required this.text,
    this.showDot = true,
  }) : type = SSBadgeType.critical;

  /// Unknown status badge
  const SSBadge.unknown({
    super.key,
    required this.text,
    this.showDot = true,
  }) : type = SSBadgeType.unknown;

  /// Info badge
  const SSBadge.info({
    super.key,
    required this.text,
    this.showDot = true,
  }) : type = SSBadgeType.info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);
    final badgeColor = _getBadgeColor(colors);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: badgeColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            text,
            style: AppTypography.label.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(AppColors colors) {
    switch (type) {
      case SSBadgeType.healthy:
        return colors.statusHealthy;
      case SSBadgeType.warning:
        return colors.statusWarning;
      case SSBadgeType.critical:
        return colors.statusCritical;
      case SSBadgeType.unknown:
        return colors.statusUnknown;
      case SSBadgeType.info:
        return colors.primary;
    }
  }
}
