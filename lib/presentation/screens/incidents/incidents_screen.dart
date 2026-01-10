import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../domain/entities/incident.dart';
import '../../design_system/atoms/ss_loading.dart';
import '../../design_system/atoms/ss_empty_state.dart';
import '../../design_system/atoms/ss_badge.dart';
import '../../design_system/molecules/ss_card.dart';
import '../../design_system/organisms/ss_app_bar.dart';
import '../../providers/theme_provider.dart';
import '../../../shared/error_view.dart';
import '../../../shared/refresh_wrapper.dart';
import 'incidents_viewmodel.dart';
import 'incident_detail_screen.dart';

/// Incidents List Screen
class IncidentsScreen extends ConsumerStatefulWidget {
  const IncidentsScreen({super.key});

  @override
  ConsumerState<IncidentsScreen> createState() => _IncidentsScreenState();
}

class _IncidentsScreenState extends ConsumerState<IncidentsScreen> {
  String? _selectedStatus;
  String? _selectedSeverity;

  @override
  void initState() {
    super.initState();
    // Load incidents on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(incidentsViewModelProvider.notifier).loadIncidents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(incidentsViewModelProvider);

    return Scaffold(
      appBar: SSAppBar(title: l10n.incidents),
      body: RefreshWrapper(
        onRefresh: () => ref
            .read(incidentsViewModelProvider.notifier)
            .refreshIncidents(
              status: _selectedStatus,
              severity: _selectedSeverity,
            ),
        child: Column(
          children: [
            // Filters
            _buildFilters(context, l10n),

            // Content
            Expanded(
              child: state.when(
                initial: () => const Center(child: SSLoading()),
                loading: () => const Center(child: SSLoading()),
                loaded: (incidents) => _buildLoadedContent(context, incidents),
                error: (message) => ErrorView(
                  message: message,
                  onRetry: () => ref
                      .read(incidentsViewModelProvider.notifier)
                      .loadIncidents(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context, AppLocalizations l10n) {
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(color: colors.textSecondary.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          // Status filter
          Expanded(
            child: DropdownButtonFormField<String?>(
              value: _selectedStatus,
              decoration: InputDecoration(
                labelText: l10n.status,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.all)),
                DropdownMenuItem(value: 'open', child: Text(l10n.incidentOpen)),
                DropdownMenuItem(
                    value: 'acknowledged', child: Text(l10n.incidentAcknowledged)),
                DropdownMenuItem(
                    value: 'resolved', child: Text(l10n.incidentResolved)),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
                ref
                    .read(incidentsViewModelProvider.notifier)
                    .loadIncidents(
                      status: _selectedStatus,
                      severity: _selectedSeverity,
                    );
              },
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Severity filter
          Expanded(
            child: DropdownButtonFormField<String?>(
              value: _selectedSeverity,
              decoration: InputDecoration(
                labelText: l10n.severity,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.all)),
                DropdownMenuItem(value: 'low', child: Text(l10n.severityLow)),
                DropdownMenuItem(value: 'medium', child: Text(l10n.severityMedium)),
                DropdownMenuItem(value: 'high', child: Text(l10n.severityHigh)),
                DropdownMenuItem(
                    value: 'critical', child: Text(l10n.severityCritical)),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSeverity = value;
                });
                ref
                    .read(incidentsViewModelProvider.notifier)
                    .loadIncidents(
                      status: _selectedStatus,
                      severity: _selectedSeverity,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context, List<Incident> incidents) {
    final l10n = AppLocalizations.of(context)!;

    if (incidents.isEmpty) {
      return SSEmptyState(
        icon: Icons.warning_amber_outlined,
        title: l10n.emptyIncidents,
        description: l10n.emptyIncidentsDescription,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: incidents.length,
      itemBuilder: (context, index) {
        final incident = incidents[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: _buildIncidentTile(context, l10n, incident),
        );
      },
    );
  }

  Widget _buildIncidentTile(
    BuildContext context,
    AppLocalizations l10n,
    Incident incident,
  ) {
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return SSCard(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IncidentDetailScreen(incidentId: incident.id),
          ),
        );
        // Refresh list after viewing detail
        if (mounted) {
          ref.read(incidentsViewModelProvider.notifier).refreshIncidents(
                status: _selectedStatus,
                severity: _selectedSeverity,
              );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with status and severity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SSBadge(
                text: _getStatusText(incident.status, l10n),
                type: _getStatusBadgeType(incident.status),
              ),
              SSBadge(
                text: _getSeverityText(incident.severity, l10n),
                type: _getSeverityBadgeType(incident.severity),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Title
          Text(
            incident.title,
            style: AppTypography.body.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          // Service name
          Text(
            incident.serviceName ?? 'Unknown Service',
            style: AppTypography.caption.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Metadata row
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: colors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                _formatRelativeTime(incident.detectedAt),
                style: AppTypography.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(
                Icons.error_outline,
                size: 14,
                color: colors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '${incident.consecutiveFailures} failures',
                style: AppTypography.caption.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusText(IncidentStatus status, AppLocalizations l10n) {
    switch (status) {
      case IncidentStatus.open:
        return l10n.incidentOpen;
      case IncidentStatus.acknowledged:
        return l10n.incidentAcknowledged;
      case IncidentStatus.resolved:
        return l10n.incidentResolved;
    }
  }

  SSBadgeType _getStatusBadgeType(IncidentStatus status) {
    switch (status) {
      case IncidentStatus.open:
        return SSBadgeType.critical;
      case IncidentStatus.acknowledged:
        return SSBadgeType.warning;
      case IncidentStatus.resolved:
        return SSBadgeType.healthy;
    }
  }

  String _getSeverityText(IncidentSeverity severity, AppLocalizations l10n) {
    switch (severity) {
      case IncidentSeverity.low:
        return l10n.severityLow;
      case IncidentSeverity.medium:
        return l10n.severityMedium;
      case IncidentSeverity.high:
        return l10n.severityHigh;
      case IncidentSeverity.critical:
        return l10n.severityCritical;
    }
  }

  SSBadgeType _getSeverityBadgeType(IncidentSeverity severity) {
    switch (severity) {
      case IncidentSeverity.low:
        return SSBadgeType.info;
      case IncidentSeverity.medium:
        return SSBadgeType.warning;
      case IncidentSeverity.high:
        return SSBadgeType.warning;
      case IncidentSeverity.critical:
        return SSBadgeType.critical;
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
