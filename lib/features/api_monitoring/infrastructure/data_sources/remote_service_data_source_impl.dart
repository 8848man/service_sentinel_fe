import 'package:dio/dio.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/error/app_error.dart';
import '../../domain/entities/health_check.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/service_repository.dart';
import '../models/health_check_dto.dart';
import '../models/service_dto.dart';
import '../models/service_stats_dto.dart';
import 'service_data_source.dart';

/// Remote service data source implementation using REST API
/// Requires authentication with API key
///
/// API Endpoints (v2 - Project-scoped):
/// - GET    /api/v2/projects/:project_id/services                    - Get all services
/// - GET    /api/v2/projects/:project_id/services/:id                - Get service by ID
/// - POST   /api/v2/projects/:project_id/services                    - Create service
/// - PATCH  /api/v2/projects/:project_id/services/:id                - Update service
/// - DELETE /api/v2/projects/:project_id/services/:id                - Delete service
/// - POST   /api/v2/projects/:project_id/services/:id/activate       - Activate service
/// - POST   /api/v2/projects/:project_id/services/:id/deactivate     - Deactivate service
/// - POST   /api/v2/projects/:project_id/services/:id/check-now      - Trigger manual check
/// - GET    /api/v2/projects/:project_id/services/:id/health-checks  - Get health check history
/// - GET    /api/v2/projects/:project_id/services/:id/health-checks/latest - Get latest health check
/// - GET    /api/v2/projects/:project_id/services/:id/stats          - Get service statistics
/// - GET    /api/v2/projects/:project_id/services/:id/incidents      - Get service incidents
class RemoteServiceDataSourceImpl implements RemoteServiceDataSource {
  final Dio _dio;

  RemoteServiceDataSourceImpl(this._dio);

  String _baseUrl(String projectId) =>
      '${AppConfig.apiUrl}/projects/$projectId/services';

  @override
  Future<List<Service>> getAll({
    required int projectId,
    bool? isActive,
    int skip = 0,
    int limit = 100,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'skip': skip,
        'limit': limit,
      };
      if (isActive != null) {
        queryParams['is_active'] = isActive;
      }

      final response = await _dio.get(
        _baseUrl(projectId.toString()),
        queryParameters: queryParams,
      );
      final List<dynamic> data = response.data as List<dynamic>;
      final retData = data
          .map((json) =>
              ServiceDto.fromJson(json as Map<String, dynamic>).toDomain())
          .toList();

      return retData;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Service> getById({
    required int projectId,
    required int serviceId,
  }) async {
    try {
      final response =
          await _dio.get('${_baseUrl(projectId.toString())}/$serviceId');
      final dto = ServiceDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Service> create({
    required int projectId,
    required ServiceCreate data,
  }) async {
    try {
      final dto = ServiceCreateDto.fromDomain(data);
      final response = await _dio.post(
        _baseUrl(projectId.toString()),
        data: dto.toJson(),
      );
      final serviceDto =
          ServiceDto.fromJson(response.data as Map<String, dynamic>);
      return serviceDto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Service> update({
    required int projectId,
    required int serviceId,
    required ServiceUpdate data,
  }) async {
    try {
      final dto = ServiceUpdateDto.fromDomain(data);
      final response = await _dio.patch(
        // Changed from PUT to PATCH
        '${_baseUrl(projectId.toString())}/$serviceId',
        data: dto.toJson(),
      );
      final serviceDto =
          ServiceDto.fromJson(response.data as Map<String, dynamic>);
      return serviceDto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> delete({
    required int projectId,
    required int serviceId,
  }) async {
    try {
      await _dio.delete('${_baseUrl(projectId.toString())}/$serviceId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<HealthCheck>> getHealthChecks({
    required int projectId,
    required int serviceId,
    int skip = 0,
    int limit = 100,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'skip': skip,
        'limit': limit,
      };

      final response = await _dio.get(
        '${_baseUrl(projectId.toString())}/$serviceId/health-checks',
        queryParameters: queryParams,
      );

      // Response structure: { service_id, total, items: [...] }
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final List<dynamic> items = responseData['items'] as List<dynamic>;

      return items
          .map((json) =>
              HealthCheckDto.fromJson(json as Map<String, dynamic>).toDomain())
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HealthCheck?> getLatestHealthCheck({
    required int projectId,
    required int serviceId,
  }) async {
    try {
      final response = await _dio.get(
        '${_baseUrl(projectId.toString())}/$serviceId/health-checks/latest',
      );
      final dto =
          HealthCheckDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null; // No health checks found
      }
      throw _handleError(e);
    }
  }

  @override
  Future<Service> activate({
    required int projectId,
    required int serviceId,
  }) async {
    try {
      final response = await _dio
          .post('${_baseUrl(projectId.toString())}/$serviceId/activate');
      final dto = ServiceDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Service> deactivate({
    required int projectId,
    required int serviceId,
  }) async {
    try {
      final response = await _dio
          .post('${_baseUrl(projectId.toString())}/$serviceId/deactivate');
      final dto = ServiceDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HealthCheck> checkNow({
    required int projectId,
    required int serviceId,
  }) async {
    try {
      final response = await _dio
          .post('${_baseUrl(projectId.toString())}/$serviceId/check-now');
      final dto =
          HealthCheckDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<ServiceStats> getStats({
    required int projectId,
    required int serviceId,
    String period = '24h',
  }) async {
    try {
      final response = await _dio.get(
        '${_baseUrl(projectId.toString())}/$serviceId/stats',
        queryParameters: {'period': period},
      );
      final dto =
          ServiceStatsDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
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
          return NotFoundError(message: message ?? 'Service not found');
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
