import '../../../../core/error/result.dart';

/// Dashboard repository interface
/// Provides aggregated metrics for project overview
/// v2 API - All operations are project-scoped
abstract class DashboardRepository {
  /// Get dashboard overview for a project
  /// Returns aggregated health status for all services
  Future<Result<DashboardOverview>> getOverview({required String projectId});

  /// Get dashboard metrics for a time period
  Future<Result<DashboardMetrics>> getMetrics({
    required String projectId,
    String period = '24h',
  });
}

/// Dashboard overview model
class DashboardOverview {
  final int totalServices;
  final int healthyServices;
  final int unhealthyServices;
  final int totalOpenIncidents;
  final List<ServiceHealthSummary> services;
  final DateTime lastUpdated;

  DashboardOverview({
    required this.totalServices,
    required this.healthyServices,
    required this.unhealthyServices,
    required this.totalOpenIncidents,
    required this.services,
    required this.lastUpdated,
  });
}

/// Service health summary for dashboard
class ServiceHealthSummary {
  final String serviceId;
  final String serviceName;
  final String serviceType;
  final bool? isAlive;  // Nullable if no health check exists yet
  final DateTime? lastCheck;
  final int? latencyMs;
  final int openIncidents;

  ServiceHealthSummary({
    required this.serviceId,
    required this.serviceName,
    required this.serviceType,
    this.isAlive,
    this.lastCheck,
    this.latencyMs,
    required this.openIncidents,
  });
}

/// Dashboard metrics for a time period
class DashboardMetrics {
  final String period;
  final int totalHealthChecks;
  final int failedHealthChecks;
  final double uptimePercentage;
  final double averageLatencyMs;
  final int totalIncidents;
  final int openIncidents;
  final int aiAnalysesCount;
  final double aiTotalCostUsd;

  DashboardMetrics({
    required this.period,
    required this.totalHealthChecks,
    required this.failedHealthChecks,
    required this.uptimePercentage,
    required this.averageLatencyMs,
    required this.totalIncidents,
    required this.openIncidents,
    required this.aiAnalysesCount,
    required this.aiTotalCostUsd,
  });

  int get successfulChecks => totalHealthChecks - failedHealthChecks;
}
