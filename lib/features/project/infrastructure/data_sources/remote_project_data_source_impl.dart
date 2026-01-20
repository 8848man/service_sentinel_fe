import 'package:dio/dio.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/error/app_error.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/project.dart';
import '../models/project_dto.dart';
import 'project_data_source.dart';

/// Remote project data source implementation using REST API
/// Requires authentication with API key
///
/// API Endpoints:
/// - GET    /api/v2/projects        - Get all projects
/// - GET    /api/v2/projects/:id    - Get project by ID
/// - POST   /api/v2/projects        - Create project
/// - PUT    /api/v2/projects/:id    - Update project
/// - DELETE /api/v2/projects/:id    - Delete project
/// - GET    /api/v2/projects/:id/stats - Get project statistics
class RemoteProjectDataSourceImpl implements RemoteProjectDataSource {
  final Dio _dio;

  RemoteProjectDataSourceImpl(this._dio);

  String get _baseUrl => '${AppConfig.apiUrl}/projects';

  @override
  Future<List<Project>> getAll() async {
    try {
      final response = await _dio.get(_baseUrl);
      final List<dynamic> data = response.data as List<dynamic>;

      return data
          .map((json) => ProjectDto.fromJson(json as Map<String, dynamic>).toDomain())
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Project> getById(String id) async {
    try {
      final response = await _dio.get('$_baseUrl/$id');
      final dto = ProjectDto.fromJson(response.data as Map<String, dynamic>);
      return dto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Project> create(ProjectCreate data) async {
    try {
      final dto = ProjectCreateDto.fromDomain(data);
      final response = await _dio.post(
        _baseUrl,
        data: dto.toJson(),
      );
      final projectDto = ProjectDto.fromJson(response.data as Map<String, dynamic>);
      return projectDto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Project> update(String id, ProjectUpdate data) async {
    try {
      final dto = ProjectUpdateDto.fromDomain(data);
      final response = await _dio.put(
        '$_baseUrl/$id',
        data: dto.toJson(),
      );
      final projectDto = ProjectDto.fromJson(response.data as Map<String, dynamic>);
      return projectDto.toDomain();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('$_baseUrl/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<bool> existsByName(String name) async {
    try {
      // Check by querying all projects and looking for name match
      // In production, this should be a dedicated API endpoint
      final projects = await getAll();
      return projects.any((p) => p.name.toLowerCase() == name.toLowerCase());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<ProjectStats> getStats(String id) async {
    try {
      final response = await _dio.get('$_baseUrl/$id/stats');
      final dto = ProjectStatsDto.fromJson(response.data as Map<String, dynamic>);
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
