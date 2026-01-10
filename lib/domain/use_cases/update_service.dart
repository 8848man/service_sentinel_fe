import 'package:dartz/dartz.dart';
import '../repositories/service_repository.dart';
import '../entities/service.dart';
import '../failures/failure.dart';

/// Use case for updating an existing service
class UpdateServiceUseCase {
  final ServiceRepository _repository;

  UpdateServiceUseCase(this._repository);

  Future<Either<Failure, Service>> call(int serviceId, Map<String, dynamic> data) {
    return _repository.updateService(serviceId, data);
  }
}
