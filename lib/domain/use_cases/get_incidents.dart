import 'package:dartz/dartz.dart';
import '../entities/incident.dart';
import '../failures/failure.dart';
import '../repositories/incident_repository.dart';

/// Use case: Get incidents with optional filters
class GetIncidentsUseCase {
  final IncidentRepository _repository;

  GetIncidentsUseCase(this._repository);

  Future<Either<Failure, List<Incident>>> call({
    IncidentStatus? status,
    IncidentSeverity? severity,
    int? skip,
    int? limit,
  }) {
    return _repository.getIncidents(
      status: status,
      severity: severity,
      skip: skip,
      limit: limit,
    );
  }
}
