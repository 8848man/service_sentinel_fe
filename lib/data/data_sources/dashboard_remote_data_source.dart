import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../models/dashboard_dto.dart';

/// Dashboard remote data source
class DashboardRemoteDataSource {
  final ApiClient _apiClient;

  DashboardRemoteDataSource(this._apiClient);

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

  /// Get dashboard overview
  Future<DashboardOverviewDto> getDashboardOverview() async {
    try {
      final response = await _apiClient.get('/dashboard/overview');
      return DashboardOverviewDto.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }
}
