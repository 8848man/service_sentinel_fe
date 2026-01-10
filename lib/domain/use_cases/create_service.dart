import 'package:dartz/dartz.dart';
import '../repositories/service_repository.dart';
import '../entities/service.dart';
import '../failures/failure.dart';

/// Use case for creating a new service
class CreateServiceUseCase {
  final ServiceRepository _repository;

  CreateServiceUseCase(this._repository);

  Future<Either<Failure, Service>> call(Map<String, dynamic> data) {
    return _repository.createService(data);
  }
}
