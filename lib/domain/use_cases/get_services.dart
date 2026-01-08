import 'package:dartz/dartz.dart';
import '../entities/service.dart';
import '../failures/failure.dart';
import '../repositories/service_repository.dart';

/// Use case: Get all services
class GetServicesUseCase {
  final ServiceRepository _repository;

  GetServicesUseCase(this._repository);

  Future<Either<Failure, List<Service>>> call() {
    return _repository.getServices();
  }
}
