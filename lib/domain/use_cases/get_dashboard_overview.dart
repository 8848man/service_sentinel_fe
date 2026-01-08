import 'package:dartz/dartz.dart';
import '../entities/service_status.dart';
import '../failures/failure.dart';
import '../repositories/dashboard_repository.dart';

/// Use case: Get dashboard overview with service statuses
class GetDashboardOverviewUseCase {
  final DashboardRepository _repository;

  GetDashboardOverviewUseCase(this._repository);

  Future<Either<Failure, DashboardOverview>> call() {
    return _repository.getDashboardOverview();
  }
}
