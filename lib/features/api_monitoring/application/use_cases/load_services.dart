import '../../../../core/error/result.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/service_repository.dart';

/// Use case: Load Services
/// Loads all services for current project
/// Automatically scoped by auth state and project context
class LoadServices {
  final ServiceRepository _repository;

  LoadServices({
    required ServiceRepository repository,
  }) : _repository = repository;

  /// Load all services
  Future<Result<List<Service>>> execute() async {
    return await _repository.getAll();
  }

  /// Load only active services
  Future<Result<List<Service>>> executeActive() async {
    return await _repository.getAll(isActive: true);
  }

  /// Load only inactive services
  Future<Result<List<Service>>> executeInactive() async {
    return await _repository.getAll(isActive: false);
  }
}
