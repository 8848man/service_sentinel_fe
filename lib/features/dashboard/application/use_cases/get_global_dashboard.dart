import '../../../../core/error/result.dart';
import '../../domain/entities/global_dashboard_metrics.dart';
import '../../domain/repositories/dashboard_repository.dart';

class GetGlobalDashboard {
  final DashboardRepository _repository;

  GetGlobalDashboard(this._repository);

  /// Execute use case
  /// @return Result containing GlobalDashboardMetrics or AppError
  Future<Result<GlobalDashboardMetrics>> execute() {
    return _repository.getGlobalMetrics();
  }
}
