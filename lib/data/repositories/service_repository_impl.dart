import 'package:dartz/dartz.dart';
import '../../domain/repositories/service_repository.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/health_check.dart';
import '../../domain/entities/service_status.dart';
import '../../domain/failures/failure.dart';
import '../../core/network/api_exception.dart';
import '../data_sources/service_remote_data_source.dart';
import '../models/mappers.dart';

/// Service repository implementation
class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource _remoteDataSource;

  ServiceRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Service>>> getServices() async {
    try {
      final dtos = await _remoteDataSource.getServices();
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return Right(entities);
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Service>> getServiceById(int id) async {
    try {
      final dto = await _remoteDataSource.getServiceById(id);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Service>> createService(Map<String, dynamic> data) async {
    try {
      final dto = await _remoteDataSource.createService(data);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Service>> updateService(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final dto = await _remoteDataSource.updateService(id, data);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteService(int id) async {
    try {
      await _remoteDataSource.deleteService(id);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Service>> activateService(int id) async {
    try {
      final dto = await _remoteDataSource.activateService(id);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Service>> deactivateService(int id) async {
    try {
      final dto = await _remoteDataSource.deactivateService(id);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HealthCheck>> triggerHealthCheck(int id) async {
    try {
      final dto = await _remoteDataSource.triggerHealthCheck(id);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HealthCheck>>> getHealthChecks(
    int id, {
    int? limit,
    int? offset,
  }) async {
    try {
      final dtos = await _remoteDataSource.getHealthChecks(
        id,
        limit: limit,
        offset: offset,
      );
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return Right(entities);
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceStats>> getServiceStats(
    int id, {
    String period = '24h',
  }) async {
    try {
      final dto = await _remoteDataSource.getServiceStats(id, period);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapApiExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _mapApiExceptionToFailure(ApiException exception) {
    switch (exception.type) {
      case ApiExceptionType.network:
        return NetworkFailure(exception.message);
      case ApiExceptionType.timeout:
        return NetworkFailure(exception.message);
      default:
        return ServerFailure(exception.message);
    }
  }
}
