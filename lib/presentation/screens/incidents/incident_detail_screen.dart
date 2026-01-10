import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../domain/entities/incident.dart';
import '../../../domain/entities/ai_analysis.dart';
import '../../design_system/atoms/ss_loading.dart';
import '../../design_system/atoms/ss_button.dart';
import '../../design_system/atoms/ss_badge.dart';
import '../../design_system/molecules/ss_card.dart';
import '../../design_system/organisms/ss_app_bar.dart';
import '../../providers/theme_provider.dart';
import '../../../shared/error_view.dart';
import '../../../shared/refresh_wrapper.dart';
import 'incident_detail_viewmodel.dart';

/// Incident Detail Screen
class IncidentDetailScreen extends ConsumerWidget {
  final int incidentId;

  const IncidentDetailScreen({super.key, required this.incidentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(incidentDetailViewModelProvider(incidentId));

    return Scaffold(
      appBar: SSAppBar(title: l10n.incidentDetail),
      body: RefreshWrapper(
        onRefresh: () => ref
            .read(incidentDetailViewModelProvider(incidentId).notifier)
            .refreshIncidentDetail(incidentId),
        child: state.when(
          initial: () => const Center(child: SSLoading()),
          loading: () => const Center(child: SSLoading()),
          loaded: (incident, aiAnalysis) =>
              _buildLoadedContent(context, ref, incident, aiAnalysis),
          error: (message) => ErrorView(
            message: message,
            onRetry: () => ref
                .read(incidentDetailViewModelProvider(incidentId).notifier)
                .loadIncidentDetail(incidentId),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedContent(
    BuildContext context,
    WidgetRef ref,
    Incident incident,
    AIAnalysis? aiAnalysis,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return CustomScrollView(
      slivers: [
        // Incident Info Card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: SSCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status and Severity badges
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
                  const SizedBox(height: AppSpacing.md),

                  // Title
                  Text(
                    incident.title,
                    style: AppTypography.headingMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Service name
                  Text(
                    incident.serviceName ?? 'Unknown Service',
                    style: AppTypography.body.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Description
                  if (incident.description.isNotEmpty) ...[
                    Text(
                      incident.description,
                      style: AppTypography.body.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // Metadata
                  _buildMetadataRow(
                    context,
                    ref,
                    l10n.detectedAt,
                    _formatDateTime(incident.detectedAt),
                  ),
                  if (incident.acknowledgedAt != null) ...[
                    _buildMetadataRow(
                      context,
                      ref,
                      l10n.acknowledgedAt,
                      _formatDateTime(incident.acknowledgedAt!),
                    ),
                  ],
                  if (incident.resolvedAt != null) ...[
                    _buildMetadataRow(
                      context,
                      ref,
                      l10n.resolvedAt,
                      _formatDateTime(incident.resolvedAt!),
                    ),
                  ],
                  _buildMetadataRow(
                    context,
                    ref,
                    l10n.consecutiveFailures,
                    incident.consecutiveFailures.toString(),
                  ),
                  _buildMetadataRow(
                    context,
                    ref,
                    l10n.totalAffectedChecks,
                    incident.totalAffectedChecks.toString(),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Action Buttons
        if (incident.status != IncidentStatus.resolved)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  if (incident.status == IncidentStatus.open)
                    Expanded(
                      child: SSButton.primary(
                        text: l10n.incidentAcknowledge,
                        icon: Icons.check_circle_outline,
                        onPressed: () async {
                          final success = await ref
                              .read(incidentDetailViewModelProvider(incidentId)
                                  .notifier)
                              .acknowledgeIncident(incidentId);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? l10n.incidentAcknowledged_success
                                      : l10n.errorServer,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  if (incident.status == IncidentStatus.open)
                    const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: SSButton.primary(
                      text: l10n.incidentResolve,
                      icon: Icons.done_all,
                      onPressed: () async {
                        final success = await ref
                            .read(
                                incidentDetailViewModelProvider(incidentId).notifier)
                            .resolveIncident(incidentId);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? l10n.incidentResolved_success
                                    : l10n.errorServer,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // AI Analysis Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              l10n.aiAnalysis,
              style: AppTypography.headingMedium.copyWith(
                color: colors.textPrimary,
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // AI Analysis Content or Request Button
        if (aiAnalysis != null)
          _buildAIAnalysisContent(context, ref, aiAnalysis)
        else
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  Text(
                    l10n.noAiAnalysis,
                    style: AppTypography.body.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SSButton.secondary(
                    text: l10n.incidentRequestAnalysis,
                    icon: Icons.psychology,
                    onPressed: () async {
                      final success = await ref
                          .read(
                              incidentDetailViewModelProvider(incidentId).notifier)
                          .requestAIAnalysis(incidentId);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? l10n.aiAnalysisRequested
                                  : l10n.aiAnalysisFailed,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
      ],
    );
  }

  Widget _buildMetadataRow(
    BuildContext context,
    WidgetRef ref,
    String label,
    String value,
  ) {
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: AppTypography.body.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.body.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIAnalysisContent(
    BuildContext context,
    WidgetRef ref,
    AIAnalysis aiAnalysis,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: SSCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Root Cause
              Text(
                l10n.rootCause,
                style: AppTypography.body.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                aiAnalysis.rootCauseHypothesis,
                style: AppTypography.body.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Confidence
              Row(
                children: [
                  Text(
                    '${l10n.confidence}: ',
                    style: AppTypography.caption.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  Text(
                    '${(aiAnalysis.confidenceScore * 100).toStringAsFixed(0)}%',
                    style: AppTypography.caption.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Debug Checklist
              Text(
                l10n.debugChecklist,
                style: AppTypography.body.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              ...aiAnalysis.debugChecklist.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: TextStyle(color: colors.textPrimary)),
                        Expanded(
                          child: Text(
                            item,
                            style: AppTypography.body.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: AppSpacing.md),

              // Suggested Actions
              Text(
                l10n.suggestedActions,
                style: AppTypography.body.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              ...aiAnalysis.suggestedActions.map((action) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: colors.primary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                action.action,
                                style: AppTypography.body.copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (action.estimatedImpact.isNotEmpty) ...[
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  action.estimatedImpact,
                                  style: AppTypography.caption.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
