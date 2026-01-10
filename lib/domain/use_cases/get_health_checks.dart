import 'package:dartz/dartz.dart';
import '../repositories/service_repository.dart';
import '../entities/health_check.dart';
import '../failures/failure.dart';

/// Use case for getting health check history for a service
class GetHealthChecksUseCase {
  final ServiceRepository _repository;

  GetHealthChecksUseCase(this._repository);

  Future<Either<Failure, List<HealthCheck>>> call(
    int serviceId, {
    int? limit,
    int? offset,
  }) {
    return _repository.getHealthChecks(serviceId, limit: limit, offset: offset);
  }
}
