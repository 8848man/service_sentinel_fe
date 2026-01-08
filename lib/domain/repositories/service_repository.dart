import 'package:dartz/dartz.dart';
import '../entities/service.dart';
import '../entities/health_check.dart';
import '../entities/service_status.dart';
import '../failures/failure.dart';

/// Service repository interface
abstract class ServiceRepository {
  /// Get all services
  Future<Either<Failure, List<Service>>> getServices();

  /// Get service by ID
  Future<Either<Failure, Service>> getServiceById(int id);

  /// Create new service
  Future<Either<Failure, Service>> createService(Map<String, dynamic> data);

  /// Update service
  Future<Either<Failure, Service>> updateService(int id, Map<String, dynamic> data);

  /// Delete service
  Future<Either<Failure, void>> deleteService(int id);

  /// Activate service monitoring
  Future<Either<Failure, Service>> activateService(int id);

  /// Deactivate service monitoring
  Future<Either<Failure, Service>> deactivateService(int id);

  /// Trigger manual health check
  Future<Either<Failure, HealthCheck>> triggerHealthCheck(int id);

  /// Get health check history for service
  Future<Either<Failure, List<HealthCheck>>> getHealthChecks(
    int id, {
    int? limit,
    int? offset,
  });

  /// Get service statistics
  Future<Either<Failure, ServiceStats>> getServiceStats(
    int id, {
    String period = '24h',
  });
}
