import 'package:dartz/dartz.dart';
import '../repositories/incident_repository.dart';
import '../entities/incident.dart';
import '../failures/failure.dart';

/// Use case for acknowledging an incident
class AcknowledgeIncidentUseCase {
  final IncidentRepository _repository;

  AcknowledgeIncidentUseCase(this._repository);

  Future<Either<Failure, Incident>> call(int incidentId) {
    return _repository.acknowledgeIncident(incidentId);
  }
}
