import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../presentation/providers/theme_provider.dart';
import 'ss_status_indicator.dart';

/// ServiceSentinel Service Tile Component
///
/// Displays a service item in a list.
/// Shows service name, status, and metadata.
class SSServiceTile extends ConsumerWidget {
  final String name;
  final String? description;
  final SSStatusType status;
  final String? lastCheckTime;
  final String? latency;
  final VoidCallback? onTap;
  final bool showBorder;

  const SSServiceTile({
    super.key,
    required this.name,
    this.description,
    required this.status,
    this.lastCheckTime,
    this.latency,
    this.onTap,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    final content = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: showBorder
            ? Border.all(
                color: colors.divider,
                width: 1,
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.bodyMedium.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (description != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description!,
                    style: AppTypography.caption.copyWith(
                      color: colors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    SSStatusIndicator(
                      status: status,
                      text: _getStatusText(status),
                      compact: true,
                    ),
                    if (latency != null) ...[
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        latency!,
                        style: AppTypography.label.copyWith(
                          color: colors.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (lastCheckTime != null) ...[
                Text(
                  lastCheckTime!,
                  style: AppTypography.label.copyWith(
                    color: colors.textTertiary,
                  ),
                ),
              ],
              if (onTap != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: colors.textTertiary,
                ),
              ],
            ],
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: content,
      );
    }

    return content;
  }

  String _getStatusText(SSStatusType status) {
    switch (status) {
      case SSStatusType.healthy:
        return 'Healthy';
      case SSStatusType.warning:
        return 'Warning';
      case SSStatusType.down:
        return 'Down';
      case SSStatusType.unknown:
        return 'Unknown';
    }
  }
}
