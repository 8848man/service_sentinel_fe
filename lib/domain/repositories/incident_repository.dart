import 'package:dartz/dartz.dart';
import '../entities/incident.dart';
import '../entities/ai_analysis.dart';
import '../failures/failure.dart';

/// Incident repository interface
abstract class IncidentRepository {
  /// Get all incidents with optional filters
  Future<Either<Failure, List<Incident>>> getIncidents({
    IncidentStatus? status,
    IncidentSeverity? severity,
    int? skip,
    int? limit,
  });

  /// Get incident by ID
  Future<Either<Failure, Incident>> getIncidentById(int id);

  /// Get incidents for a specific service
  Future<Either<Failure, List<Incident>>> getServiceIncidents(int serviceId);

  /// Update incident
  Future<Either<Failure, Incident>> updateIncident(
    int id,
    Map<String, dynamic> data,
  );

  /// Acknowledge incident
  Future<Either<Failure, Incident>> acknowledgeIncident(int id);

  /// Resolve incident
  Future<Either<Failure, Incident>> resolveIncident(int id);

  /// Get AI analysis for incident
  Future<Either<Failure, AIAnalysis?>> getAIAnalysis(int incidentId);

  /// Request AI analysis for incident
  Future<Either<Failure, AIAnalysis>> requestAIAnalysis(
    int incidentId, {
    bool forceReanalyze = false,
  });
}
