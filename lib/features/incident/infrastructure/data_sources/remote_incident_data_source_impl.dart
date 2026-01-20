import 'package:dio/dio.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/error/app_error.dart';
import '../../domain/entities/incident.dart';
import '../../domain/entities/ai_analysis.dart';
import '../models/incident_dto.dart';
import '../models/ai_analysis_dto.dart';
import 'incident_data_source.dart';

/// Remote incident data source implementation using REST API
/// Requires authentication with API key
///
/// API Endpoints (v2 - Project-scoped):
/// - GET    /api/v2/projects/:project_id/incidents                       - Get all incidents (with filters)
/// - GET    /api/v2/projects/:project_id/incidents/:id                   - Get incident by ID
/// - PATCH  /api/v2/projects/:project_id/incidents/:id                   - Update incident
/// - POST   /api/v2/projects/:project_id/incidents/:id/acknowledge       - Acknowledge incident
/// - POST   /api/v2/projects/:project_id/incidents/:id/resolve           - Resolve incident
/// - GET    /api/v2/projects/:project_id/incidents/:id/analysis          - Get AI analysis
/// - POST   /api/v2/projects/:project_id/incidents/:id/analysis          - Request AI analysis
class RemoteIncidentDataSourceImpl implements RemoteIncidentDataSource {
  final Dio _dio;

  RemoteIncidentDataSourceImpl(this._dio);

  String _baseUrl(String projectId) =>
      '${AppConfig.apiUrl}/projects/$projectId/incidents';

  @override
  Future<List<Incident>> getAll({
    required int projectId,
    IncidentStatus? status,
    IncidentSeverity? severity,
    int? serviceId,
    int skip = 0,
    int limit = 100,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'skip': skip,
        'limit': limit,
      };
      if (status != null) queryParams['status'] = status.name;
      if (severity != null) queryParams['severity'] = severity.name;
      if (serviceId != null) queryParams['service_id'] = serviceId;

      final response = await _dio.get(_baseUrl(projectId.toString()),
          queryParameters: queryParams);

      print('test003, resp is $response'); // --- IGNORE ---

      // Response structure: { total, items: [...] }
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      print('test004, responseData is $responseData'); // --- IGNORE ---
      final List<dynamic> items = responseData['items'] as List<dynamic>;
      print('test005, items is $items'); // --- IGNORE ---
      return items
          .map((json) =>
              IncidentDto.fromJson(json as Map<String, dynamic>).toDomain())
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Incident> getById({
    required int projectId,
    required int incidentId,
  }) async {
    try {
      final response =
          await _dio.get('${_baseUrl(projectId.toString())}/$incidentId');
      final dto = IncidentDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Incident> update({
    required int projectId,
    required int incidentId,
    required IncidentUpdate data,
  }) async {
    try {
      final dto = IncidentUpdateDto.fromDomain(data);
      final response = await _dio.patch(
        // Changed from PUT to PATCH
        '${_baseUrl(projectId.toString())}/$incidentId',
        data: dto.toJson(),
      );
      final incidentDto =
          IncidentDto.fromJson(response.data as Map<String, dynamic>);
      return incidentDto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<Incident>> getByService({
    required int projectId,
    required int serviceId,
    int skip = 0,
    int limit = 100,
  }) async {
    try {
      // Use getAll with serviceId filter
      return await getAll(
        projectId: projectId,
        serviceId: serviceId,
        skip: skip,
        limit: limit,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Incident> acknowledge({
    required int projectId,
    required int incidentId,
  }) async {
    try {
      final response = await _dio
          .post('${_baseUrl(projectId.toString())}/$incidentId/acknowledge');
      final dto = IncidentDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Incident> resolve({
    required int projectId,
    required int incidentId,
  }) async {
    try {
      final response = await _dio
          .post('${_baseUrl(projectId.toString())}/$incidentId/resolve');
      final dto = IncidentDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AiAnalysis?> getAnalysis({
    required int projectId,
    required int incidentId,
  }) async {
    try {
      final response = await _dio
          .get('${_baseUrl(projectId.toString())}/$incidentId/analysis');
      // If no analysis exists, backend returns 404 or null
      if (response.data == null) {
        return null;
      }

      final dto = AiAnalysisDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      // 404 means no analysis exists yet
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw _handleError(e);
    }
  }

  @override
  Future<AiAnalysis> requestAnalysis({
    required int projectId,
    required int incidentId,
    bool forceReanalyze = false,
  }) async {
    try {
      final response = await _dio.post(
        '${_baseUrl(projectId.toString())}/$incidentId/analysis',
        data: {'force_reanalyze': forceReanalyze},
      );
      final dto = AiAnalysisDto.fromJson(response.data as Map<String, dynamic>);
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
          return NotFoundError(message: message ?? 'Incident not found');
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
