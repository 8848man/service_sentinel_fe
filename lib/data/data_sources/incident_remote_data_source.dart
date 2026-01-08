import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../models/incident_dto.dart';
import '../models/ai_analysis_dto.dart';

/// Incident remote data source
class IncidentRemoteDataSource {
  final ApiClient _apiClient;

  IncidentRemoteDataSource(this._apiClient);

  /// Get all incidents with filters
  Future<List<IncidentDto>> getIncidents({
    String? status,
    String? severity,
    int? skip,
    int? limit,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (status != null) queryParams['status'] = status;
      if (severity != null) queryParams['severity'] = severity;
      if (skip != null) queryParams['skip'] = skip;
      if (limit != null) queryParams['limit'] = limit;

      final response = await _apiClient.get(
        '/incidents',
        queryParameters: queryParams,
      );

      // Backend returns {total: int, items: [...]}
      final data = response.data;
      if (data is Map && data.containsKey('items')) {
        return (data['items'] as List)
            .map((json) => IncidentDto.fromJson(json))
            .toList();
      }

      // Fallback: assume direct list
      return (data as List).map((json) => IncidentDto.fromJson(json)).toList();
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }

  /// Get incident by ID
  Future<IncidentDto> getIncidentById(int id) async {
    try {
      final response = await _apiClient.get('/incidents/$id');
      return IncidentDto.fromJson(response.data);
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }

  /// Get incidents for service
  Future<List<IncidentDto>> getServiceIncidents(int serviceId) async {
    try {
      final response = await _apiClient.get('/services/$serviceId/incidents');
      return (response.data as List)
          .map((json) => IncidentDto.fromJson(json))
          .toList();
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }

  /// Update incident
  Future<IncidentDto> updateIncident(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.patch('/incidents/$id', data: data);
      return IncidentDto.fromJson(response.data);
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }

  /// Acknowledge incident
  Future<IncidentDto> acknowledgeIncident(int id) async {
    try {
      final response = await _apiClient.post('/incidents/$id/acknowledge');
      return IncidentDto.fromJson(response.data);
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }

  /// Resolve incident
  Future<IncidentDto> resolveIncident(int id) async {
    try {
      final response = await _apiClient.post('/incidents/$id/resolve');
      return IncidentDto.fromJson(response.data);
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }

  /// Get AI analysis
  Future<AIAnalysisDto?> getAIAnalysis(int incidentId) async {
    try {
      final response = await _apiClient.get('/incidents/$incidentId/analysis');
      if (response.data == null) return null;
      return AIAnalysisDto.fromJson(response.data);
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }

  /// Request AI analysis
  Future<AIAnalysisDto> requestAIAnalysis(
    int incidentId, {
    bool forceReanalyze = false,
  }) async {
    try {
      final response = await _apiClient.post(
        '/incidents/$incidentId/analysis',
        data: {'force_reanalyze': forceReanalyze},
      );
      return AIAnalysisDto.fromJson(response.data);
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }
}
