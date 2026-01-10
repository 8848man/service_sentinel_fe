import 'package:dartz/dartz.dart';
import '../repositories/service_repository.dart';
import '../failures/failure.dart';

/// Use case for deleting a service
class DeleteServiceUseCase {
  final ServiceRepository _repository;

  DeleteServiceUseCase(this._repository);

  Future<Either<Failure, void>> call(int serviceId) {
    return _repository.deleteService(serviceId);
  }
}
