import 'package:dartz/dartz.dart';
import '../repositories/incident_repository.dart';
import '../entities/incident.dart';
import '../failures/failure.dart';

/// Use case for resolving an incident
class ResolveIncidentUseCase {
  final IncidentRepository _repository;

  ResolveIncidentUseCase(this._repository);

  Future<Either<Failure, Incident>> call(int incidentId) {
    return _repository.resolveIncident(incidentId);
  }
}
