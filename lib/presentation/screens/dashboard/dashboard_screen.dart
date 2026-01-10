import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../domain/entities/service_status.dart';
import '../../design_system/atoms/ss_loading.dart';
import '../../design_system/atoms/ss_empty_state.dart';
import '../../design_system/molecules/ss_metric_card.dart';
import '../../design_system/molecules/ss_service_tile.dart';
import '../../design_system/molecules/ss_status_indicator.dart';
import '../../design_system/organisms/ss_app_bar.dart';
import '../../providers/theme_provider.dart';
import '../../../shared/error_view.dart';
import '../../../shared/refresh_wrapper.dart';
import 'dashboard_viewmodel.dart';

/// Dashboard Screen
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Load dashboard data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardViewModelProvider.notifier).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(dashboardViewModelProvider);

    return Scaffold(
      appBar: SSAppBar(title: l10n.dashboard),
      body: RefreshWrapper(
        onRefresh: () =>
            ref.read(dashboardViewModelProvider.notifier).refreshDashboard(),
        child: state.when(
          initial: () => const Center(child: SSLoading()),
          loading: () => const Center(child: SSLoading()),
          loaded: (overview) => _buildLoadedContent(context, overview),
          error: (message) => ErrorView(
            message: message,
            onRetry: () =>
                ref.read(dashboardViewModelProvider.notifier).loadDashboard(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedContent(
    BuildContext context,
    DashboardOverview overview,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return CustomScrollView(
      slivers: [
        // Overview metrics
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.overviewTotalServices,
                  style: AppTypography.headingMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildMetricsGrid(context, overview),
              ],
            ),
          ),
        ),

        // Services list
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              l10n.services,
              style: AppTypography.headingMedium.copyWith(
                color: colors.textPrimary,
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // Service tiles
        if (overview.services.isEmpty)
          SliverFillRemaining(
            child: SSEmptyState(
              icon: Icons.dns_outlined,
              title: l10n.emptyServices,
              description: l10n.emptyServicesDescription,
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final service = overview.services[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: SSServiceTile(
                      name: service.name,
                      status: _mapServiceStatusToIndicatorStatus(service.status),
                      lastCheckTime: service.lastCheckedAt != null
                          ? _formatRelativeTime(service.lastCheckedAt!)
                          : null,
                      latency: service.lastCheckLatencyMs != null
                          ? '${service.lastCheckLatencyMs}ms'
                          : null,
                      onTap: () {
                        // TODO: Navigate to service detail
                      },
                    ),
                  );
                },
                childCount: overview.services.length,
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
      ],
    );
  }

  Widget _buildMetricsGrid(BuildContext context, DashboardOverview overview) {
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
          label: l10n.overviewTotalServices,
          value: overview.totalServices.toString(),
          icon: Icons.dns,
          color: colors.primary,
        ),
        SSMetricCard(
          label: l10n.overviewHealthyServices,
          value: overview.servicesHealthy.toString(),
          icon: Icons.check_circle,
          color: colors.statusHealthy,
        ),
        SSMetricCard(
          label: l10n.overviewServicesDown,
          value: overview.servicesDown.toString(),
          icon: Icons.error,
          color: colors.statusCritical,
        ),
        SSMetricCard(
          label: l10n.overviewOpenIncidents,
          value: overview.openIncidents.toString(),
          icon: Icons.warning,
          color: colors.statusWarning,
        ),
      ],
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

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
