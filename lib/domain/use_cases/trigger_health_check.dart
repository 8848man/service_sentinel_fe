import 'package:dartz/dartz.dart';
import '../repositories/service_repository.dart';
import '../entities/health_check.dart';
import '../failures/failure.dart';

/// Use case for triggering manual health check
class TriggerHealthCheckUseCase {
  final ServiceRepository _repository;

  TriggerHealthCheckUseCase(this._repository);

  Future<Either<Failure, HealthCheck>> call(int serviceId) {
    return _repository.triggerHealthCheck(serviceId);
  }
}
