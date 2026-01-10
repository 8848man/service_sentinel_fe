import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../models/service_dto.dart';
import '../models/health_check_dto.dart';
import '../models/dashboard_dto.dart';

/// Service remote data source
class ServiceRemoteDataSource {
  final ApiClient _apiClient;

  ServiceRemoteDataSource(this._apiClient);

  /// Handle exceptions from API calls
  Never _handleError(dynamic error) {
    if (error is DioException) {
      throw ApiException.fromDioError(error);
    } else if (error is TypeError || error is FormatException) {
      throw ApiException.parseError();
    } else {
      throw ApiException(
        message: error.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  /// Get all services
  Future<List<ServiceDto>> getServices() async {
    try {
      final response = await _apiClient.get('/services');

      // Handle paginated response with "items" array
      final data = response.data;
      if (data is Map<String, dynamic> && data.containsKey('items')) {
        return (data['items'] as List)
            .map((json) => ServiceDto.fromJson(json))
            .toList();
      } else if (data is List) {
        // Fallback for direct array response
        return data.map((json) => ServiceDto.fromJson(json)).toList();
      } else {
        throw ApiException.parseError('Unexpected response format for services');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  /// Get service by ID
  Future<ServiceDto> getServiceById(int id) async {
    try {
      final response = await _apiClient.get('/services/$id');
      return ServiceDto.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Create new service
  Future<ServiceDto> createService(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post('/services', data: data);
      return ServiceDto.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Update service
  Future<ServiceDto> updateService(int id, Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.patch('/services/$id', data: data);
      return ServiceDto.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Delete service
  Future<void> deleteService(int id) async {
    try {
      await _apiClient.delete('/services/$id');
    } catch (e) {
      _handleError(e);
    }
  }

  /// Activate service
  Future<ServiceDto> activateService(int id) async {
    try {
      final response = await _apiClient.post('/services/$id/activate');
      return ServiceDto.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Deactivate service
  Future<ServiceDto> deactivateService(int id) async {
    try {
      final response = await _apiClient.post('/services/$id/deactivate');
      return ServiceDto.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Trigger health check
  Future<HealthCheckDto> triggerHealthCheck(int id) async {
    try {
      final response = await _apiClient.post('/services/$id/check-now');
      return HealthCheckDto.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Get health check history
  Future<List<HealthCheckDto>> getHealthChecks(
    int id, {
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;

      final response = await _apiClient.get(
        '/services/$id/health-checks',
        queryParameters: queryParams,
      );

      // Handle paginated response with "items" array
      final data = response.data;
      if (data is Map<String, dynamic> && data.containsKey('items')) {
        return (data['items'] as List)
            .map((json) => HealthCheckDto.fromJson(json))
            .toList();
      } else if (data is List) {
        // Fallback for direct array response
        return data.map((json) => HealthCheckDto.fromJson(json)).toList();
      } else {
        throw ApiException.parseError('Unexpected response format for health checks');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  /// Get service statistics
  Future<ServiceStatsDto> getServiceStats(int id, String period) async {
    try {
      final response = await _apiClient.get(
        '/services/$id/stats',
        queryParameters: {'period': period},
      );
      return ServiceStatsDto.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }
}
