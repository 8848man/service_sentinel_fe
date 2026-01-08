import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../models/dashboard_dto.dart';

/// Dashboard remote data source
class DashboardRemoteDataSource {
  final ApiClient _apiClient;

  DashboardRemoteDataSource(this._apiClient);

  /// Get dashboard overview
  Future<DashboardOverviewDto> getDashboardOverview() async {
    try {
      final response = await _apiClient.get('/dashboard/overview');
      return DashboardOverviewDto.fromJson(response.data);
    } catch (e) {
      throw ApiException.fromDioError(e as dynamic);
    }
  }
}
