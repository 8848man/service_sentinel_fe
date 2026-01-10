import 'package:dartz/dartz.dart';
import '../repositories/incident_repository.dart';
import '../entities/ai_analysis.dart';
import '../failures/failure.dart';

/// Use case for getting AI analysis for an incident
class GetAIAnalysisUseCase {
  final IncidentRepository _repository;

  GetAIAnalysisUseCase(this._repository);

  Future<Either<Failure, AIAnalysis?>> call(int incidentId) {
    return _repository.getAIAnalysis(incidentId);
  }
}
