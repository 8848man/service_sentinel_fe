import 'package:dartz/dartz.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/entities/service_status.dart';
import '../../domain/failures/failure.dart';
import '../../core/network/api_exception.dart';
import '../data_sources/dashboard_remote_data_source.dart';
import '../models/mappers.dart';

/// Dashboard repository implementation
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, DashboardOverview>> getDashboardOverview() async {
    try {
      final dto = await _remoteDataSource.getDashboardOverview();
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _mapException(ApiException e) {
    return e.type == ApiExceptionType.network || e.type == ApiExceptionType.timeout
        ? NetworkFailure(e.message)
        : ServerFailure(e.message);
  }
}
