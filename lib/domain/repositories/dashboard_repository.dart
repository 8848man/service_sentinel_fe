import 'package:dartz/dartz.dart';
import '../entities/service_status.dart';
import '../failures/failure.dart';

/// Dashboard repository interface
abstract class DashboardRepository {
  /// Get dashboard overview with service statuses and metrics
  Future<Either<Failure, DashboardOverview>> getDashboardOverview();
}
