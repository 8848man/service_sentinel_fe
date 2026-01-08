import 'package:dartz/dartz.dart';
import '../../domain/repositories/incident_repository.dart';
import '../../domain/entities/incident.dart';
import '../../domain/entities/ai_analysis.dart';
import '../../domain/failures/failure.dart';
import '../../core/network/api_exception.dart';
import '../data_sources/incident_remote_data_source.dart';
import '../models/mappers.dart';

/// Incident repository implementation
class IncidentRepositoryImpl implements IncidentRepository {
  final IncidentRemoteDataSource _remoteDataSource;

  IncidentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Incident>>> getIncidents({
    IncidentStatus? status,
    IncidentSeverity? severity,
    int? skip,
    int? limit,
  }) async {
    try {
      final dtos = await _remoteDataSource.getIncidents(
        status: status?.name,
        severity: severity?.name,
        skip: skip,
        limit: limit,
      );
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return Right(entities);
    } on ApiException catch (e) {
      return Left(_mapException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Incident>> getIncidentById(int id) async {
    try {
      final dto = await _remoteDataSource.getIncidentById(id);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Incident>>> getServiceIncidents(int serviceId) async {
    try {
      final dtos = await _remoteDataSource.getServiceIncidents(serviceId);
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return Right(entities);
    } on ApiException catch (e) {
      return Left(_mapException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Incident>> updateIncident(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final dto = await _remoteDataSource.updateIncident(id, data);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Incident>> acknowledgeIncident(int id) async {
    try {
      final dto = await _remoteDataSource.acknowledgeIncident(id);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Incident>> resolveIncident(int id) async {
    try {
      final dto = await _remoteDataSource.resolveIncident(id);
      return Right(dto.toEntity());
    } on ApiException catch (e) {
      return Left(_mapException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AIAnalysis?>> getAIAnalysis(int incidentId) async {
    try {
      final dto = await _remoteDataSource.getAIAnalysis(incidentId);
      return Right(dto?.toEntity());
    } on ApiException catch (e) {
      return Left(_mapException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AIAnalysis>> requestAIAnalysis(
    int incidentId, {
    bool forceReanalyze = false,
  }) async {
    try {
      final dto = await _remoteDataSource.requestAIAnalysis(
        incidentId,
        forceReanalyze: forceReanalyze,
      );
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
