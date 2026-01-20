import '../../domain/repositories/dashboard_repository.dart';

/// Abstract interface for dashboard data sources
/// v2 API - All operations are project-scoped
abstract class DashboardDataSource {
  /// Get dashboard overview for a project
  Future<DashboardOverview> getOverview({required String projectId});

  /// Get dashboard metrics for a time period
  Future<DashboardMetrics> getMetrics({
    required String projectId,
    String period = '24h',
  });
}

/// Remote data source interface (REST API)
/// Requires API key authentication via X-API-Key header
/// v2 API - All operations are project-scoped
abstract class RemoteDashboardDataSource extends DashboardDataSource {}

/// Local data source interface (Hive)
/// Note: Local dashboard computes metrics from local health checks and incidents
abstract class LocalDashboardDataSource extends DashboardDataSource {}
