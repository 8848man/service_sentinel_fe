import 'package:dartz/dartz.dart';
import '../repositories/incident_repository.dart';
import '../entities/ai_analysis.dart';
import '../failures/failure.dart';

/// Use case for requesting AI analysis for an incident
class RequestAIAnalysisUseCase {
  final IncidentRepository _repository;

  RequestAIAnalysisUseCase(this._repository);

  Future<Either<Failure, AIAnalysis>> call(int incidentId, {bool forceReanalyze = false}) {
    return _repository.requestAIAnalysis(incidentId, forceReanalyze: forceReanalyze);
  }
}
