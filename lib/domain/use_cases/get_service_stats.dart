import 'package:dartz/dartz.dart';
import '../repositories/service_repository.dart';
import '../entities/service_status.dart';
import '../failures/failure.dart';

/// Use case for getting service statistics
class GetServiceStatsUseCase {
  final ServiceRepository _repository;

  GetServiceStatsUseCase(this._repository);

  Future<Either<Failure, ServiceStats>> call(
    int serviceId, {
    String period = '24h',
  }) {
    return _repository.getServiceStats(serviceId, period: period);
  }
}
