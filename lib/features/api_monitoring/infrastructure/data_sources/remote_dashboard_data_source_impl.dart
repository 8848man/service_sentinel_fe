import 'package:dio/dio.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/error/app_error.dart';
import '../../domain/repositories/dashboard_repository.dart';
import 'dashboard_data_source.dart';

/// Remote dashboard data source implementation using REST API
/// Requires authentication with API key
///
/// API Endpoints (v2 - Project-scoped):
/// - GET /api/v2/projects/:project_id/dashboard/overview - Get dashboard overview
/// - GET /api/v2/projects/:project_id/dashboard/metrics  - Get dashboard metrics
class RemoteDashboardDataSourceImpl implements RemoteDashboardDataSource {
  final Dio _dio;

  RemoteDashboardDataSourceImpl(this._dio);

  String _baseUrl(String projectId) => '${AppConfig.apiUrl}/projects/$projectId/dashboard';

  @override
  Future<DashboardOverview> getOverview({required String projectId}) async {
    try {
      final response = await _dio.get('${_baseUrl(projectId)}/overview');
      final data = response.data as Map<String, dynamic>;

      return DashboardOverview(
        totalServices: data['total_services'] as int,
        healthyServices: data['healthy_services'] as int,
        unhealthyServices: data['unhealthy_services'] as int,
        totalOpenIncidents: data['total_open_incidents'] as int,
        services: (data['services'] as List<dynamic>)
            .map((json) => _parseServiceHealthSummary(json as Map<String, dynamic>))
            .toList(),
        lastUpdated: DateTime.parse(data['last_updated'] as String),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<DashboardMetrics> getMetrics({
    required String projectId,
    String period = '24h',
  }) async {
    try {
      final response = await _dio.get(
        '${_baseUrl(projectId)}/metrics',
        queryParameters: {'period': period},
      );
      final data = response.data as Map<String, dynamic>;

      return DashboardMetrics(
        period: data['period'] as String,
        totalHealthChecks: data['total_health_checks'] as int,
        failedHealthChecks: data['failed_health_checks'] as int,
        uptimePercentage: (data['uptime_percentage'] as num).toDouble(),
        averageLatencyMs: (data['average_latency_ms'] as num).toDouble(),
        totalIncidents: data['total_incidents'] as int,
        openIncidents: data['open_incidents'] as int,
        aiAnalysesCount: data['ai_analyses_count'] as int,
        aiTotalCostUsd: (data['ai_total_cost_usd'] as num).toDouble(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ServiceHealthSummary _parseServiceHealthSummary(Map<String, dynamic> json) {
    return ServiceHealthSummary(
      serviceId: json['service_id'].toString(),
      serviceName: json['service_name'] as String,
      serviceType: json['service_type'] as String,
      isAlive: json['is_alive'] as bool?,
      lastCheck: json['last_check'] != null
          ? DateTime.parse(json['last_check'] as String)
          : null,
      latencyMs: json['latency_ms'] as int?,
      openIncidents: json['open_incidents'] as int,
    );
  }

  AppError _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data?['message'] as String? ??
          error.response!.data?['detail'] as String? ??
          error.message;

      switch (statusCode) {
        case 401:
          return UnauthorizedError(message: message ?? 'Unauthorized');
        case 404:
          return NotFoundError(message: message ?? 'Project not found');
        default:
          return ServerError(
            message: message ?? 'Server error',
            statusCode: statusCode,
          );
      }
    }

    // Network error
    return NetworkError(message: error.message ?? 'Network error');
  }
}
