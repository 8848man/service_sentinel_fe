import 'package:dartz/dartz.dart';
import '../repositories/service_repository.dart';
import '../entities/service.dart';
import '../failures/failure.dart';

/// Use case for getting a service by ID
class GetServiceByIdUseCase {
  final ServiceRepository _repository;

  GetServiceByIdUseCase(this._repository);

  Future<Either<Failure, Service>> call(int serviceId) {
    return _repository.getServiceById(serviceId);
  }
}
