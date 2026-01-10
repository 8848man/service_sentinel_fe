import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/service_status.dart';
import '../../../domain/entities/health_check.dart';
import '../../design_system/atoms/ss_loading.dart';
import '../../design_system/atoms/ss_button.dart';
import '../../design_system/molecules/ss_card.dart';
import '../../design_system/molecules/ss_status_indicator.dart';
import '../../design_system/molecules/ss_metric_card.dart';
import '../../design_system/organisms/ss_app_bar.dart';
import '../../providers/theme_provider.dart';
import '../../../shared/error_view.dart';
import '../../../shared/refresh_wrapper.dart';
import 'service_detail_viewmodel.dart';
import 'service_form_screen.dart';

/// Service Detail Screen
class ServiceDetailScreen extends ConsumerWidget {
  final int serviceId;

  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(serviceDetailViewModelProvider(serviceId));

    return Scaffold(
      appBar: SSAppBar(title: l10n.serviceDetail),
      body: RefreshWrapper(
        onRefresh: () => ref
            .read(serviceDetailViewModelProvider(serviceId).notifier)
            .refreshServiceDetail(serviceId),
        child: state.when(
          initial: () => const Center(child: SSLoading()),
          loading: () => const Center(child: SSLoading()),
          loaded: (service, healthChecks, stats) =>
              _buildLoadedContent(context, ref, service, healthChecks, stats),
          error: (message) => ErrorView(
            message: message,
            onRetry: () => ref
                .read(serviceDetailViewModelProvider(serviceId).notifier)
                .loadServiceDetail(serviceId),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedContent(
    BuildContext context,
    WidgetRef ref,
    Service service,
    List<HealthCheck> healthChecks,
    ServiceStats stats,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return CustomScrollView(
      slivers: [
        // Service Info Card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: SSCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service name and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          service.name,
                          style: AppTypography.headingMedium.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                      SSStatusIndicator(
                        status: _mapServiceStatusToIndicatorStatus(
                          service.status ?? ServiceStatus.unknown,
                        ),
                        text: _getStatusText(
                          service.status ?? ServiceStatus.unknown,
                          l10n,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Service type
                  Text(
                    service.serviceType,
                    style: AppTypography.caption.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Endpoint URL
                  Text(
                    l10n.serviceEndpointLabel,
                    style: AppTypography.label.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    service.endpointUrl,
                    style: AppTypography.body.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Active status
                  Row(
                    children: [
                      Icon(
                        service.isActive
                            ? Icons.play_circle
                            : Icons.pause_circle,
                        size: 16,
                        color: service.isActive
                            ? colors.statusHealthy
                            : colors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        service.isActive
                            ? l10n.serviceActive
                            : l10n.serviceInactive,
                        style: AppTypography.body.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Action Buttons
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: SSButton.primary(
                    text: l10n.checkNow,
                    icon: Icons.refresh,
                    onPressed: () async {
                      final success = await ref
                          .read(
                            serviceDetailViewModelProvider(serviceId).notifier,
                          )
                          .triggerHealthCheck(serviceId);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? l10n.healthCheckTriggered
                                  : l10n.healthCheckFailed,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: SSButton.secondary(
                    text: l10n.edit,
                    icon: Icons.edit,
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ServiceFormScreen(service: service),
                        ),
                      );
                      // Refresh detail if service was updated
                      if (result != null && context.mounted) {
                        ref
                            .read(
                              serviceDetailViewModelProvider(
                                serviceId,
                              ).notifier,
                            )
                            .refreshServiceDetail(serviceId);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // Statistics
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.statistics,
                  style: AppTypography.headingMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildStatisticsGrid(context, ref, stats),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

        // Health Check History
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              l10n.healthCheckHistory,
              style: AppTypography.headingMedium.copyWith(
                color: colors.textPrimary,
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // Health Check List
        if (healthChecks.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                l10n.noHealthChecks,
                style: AppTypography.body.copyWith(color: colors.textSecondary),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final check = healthChecks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _buildHealthCheckTile(context, ref, check),
                );
              }, childCount: healthChecks.length),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

        // Delete Button
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: SSButton.danger(
              text: l10n.deleteService,
              icon: Icons.delete,
              onPressed: () async {
                final confirmed = await _showDeleteConfirmation(context, l10n);
                if (confirmed == true) {
                  final success = await ref
                      .read(serviceDetailViewModelProvider(serviceId).notifier)
                      .deleteService(serviceId);

                  if (context.mounted) {
                    if (success) {
                      Navigator.of(context).pop('deleted');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.deleteServiceFailed)),
                      );
                    }
                  }
                }
              },
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
      ],
    );
  }

  Widget _buildStatisticsGrid(BuildContext context, WidgetRef ref, ServiceStats stats) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.5,
      children: [
        SSMetricCard(
          label: l10n.uptimePercentage,
          value: '${stats.uptimePercentage.toStringAsFixed(1)}%',
          icon: Icons.check_circle,
          color: colors.statusHealthy,
        ),
        SSMetricCard(
          label: l10n.avgLatency,
          value: '${stats.avgLatencyMs.toStringAsFixed(0)}ms',
          icon: Icons.timer,
          color: colors.primary,
        ),
        SSMetricCard(
          label: l10n.totalChecks,
          value: stats.totalChecks.toString(),
          icon: Icons.fact_check,
          color: colors.primary,
        ),
        SSMetricCard(
          label: l10n.failedChecks,
          value: stats.failedChecks.toString(),
          icon: Icons.error,
          color: colors.statusCritical,
        ),
      ],
    );
  }

  Widget _buildHealthCheckTile(
    BuildContext context,
    WidgetRef ref,
    HealthCheck check,
  ) {
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return SSCard(
      child: Row(
        children: [
          Icon(
            check.isAlive ? Icons.check_circle : Icons.error,
            color: check.isAlive ? colors.statusHealthy : colors.statusCritical,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  check.latencyMs != null ? '${check.latencyMs}ms' : 'N/A',
                  style: AppTypography.body.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _formatDateTime(check.checkedAt),
                  style: AppTypography.caption.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'HTTP ${check.statusCode ?? 0}',
            style: AppTypography.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  SSStatusType _mapServiceStatusToIndicatorStatus(ServiceStatus status) {
    switch (status) {
      case ServiceStatus.healthy:
        return SSStatusType.healthy;
      case ServiceStatus.warning:
        return SSStatusType.warning;
      case ServiceStatus.down:
        return SSStatusType.down;
      case ServiceStatus.unknown:
        return SSStatusType.unknown;
    }
  }

  String _getStatusText(ServiceStatus status, AppLocalizations l10n) {
    switch (status) {
      case ServiceStatus.healthy:
        return l10n.statusHealthy;
      case ServiceStatus.warning:
        return l10n.statusWarning;
      case ServiceStatus.down:
        return l10n.statusDown;
      case ServiceStatus.unknown:
        return l10n.statusUnknown;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.month}/${dateTime.day} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  Future<bool?> _showDeleteConfirmation(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteServiceConfirmTitle),
        content: Text(l10n.deleteServiceConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
