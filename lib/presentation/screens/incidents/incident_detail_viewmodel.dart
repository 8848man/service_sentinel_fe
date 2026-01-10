import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/use_cases/get_incidents.dart';
import '../../../domain/use_cases/get_ai_analysis.dart';
import '../../../domain/use_cases/acknowledge_incident.dart';
import '../../../domain/use_cases/resolve_incident.dart';
import '../../../domain/use_cases/request_ai_analysis.dart';
import '../../../core/di/injection.dart';
import 'incident_detail_state.dart';

/// Incident Detail ViewModel
class IncidentDetailViewModel extends StateNotifier<IncidentDetailState> {
  final GetIncidentsUseCase _getIncidentsUseCase;
  final GetAIAnalysisUseCase _getAIAnalysisUseCase;
  final AcknowledgeIncidentUseCase _acknowledgeIncidentUseCase;
  final ResolveIncidentUseCase _resolveIncidentUseCase;
  final RequestAIAnalysisUseCase _requestAIAnalysisUseCase;

  IncidentDetailViewModel(
    this._getIncidentsUseCase,
    this._getAIAnalysisUseCase,
    this._acknowledgeIncidentUseCase,
    this._resolveIncidentUseCase,
    this._requestAIAnalysisUseCase,
  ) : super(const IncidentDetailState.initial());

  /// Load incident detail data
  Future<void> loadIncidentDetail(int incidentId) async {
    state = const IncidentDetailState.loading();

    // Get all incidents and find the one we need
    final incidentsResult = await _getIncidentsUseCase();

    final incidentOrNull = incidentsResult.fold(
      (failure) {
        state = IncidentDetailState.error(failure.message);
        return null;
      },
      (incidents) {
        try {
          return incidents.firstWhere((i) => i.id == incidentId);
        } catch (e) {
          state = IncidentDetailState.error('Incident not found');
          return null;
        }
      },
    );

    if (incidentOrNull == null) return;

    // Try to load AI analysis if available
    final aiAnalysisResult = await _getAIAnalysisUseCase(incidentId);

    final aiAnalysisOrNull = aiAnalysisResult.fold(
      (failure) => null, // AI analysis is optional
      (analysis) => analysis,
    );

    state = IncidentDetailState.loaded(
      incident: incidentOrNull,
      aiAnalysis: aiAnalysisOrNull,
    );
  }

  /// Refresh incident detail
  Future<void> refreshIncidentDetail(int incidentId) async {
    await loadIncidentDetail(incidentId);
  }

  /// Acknowledge incident
  Future<bool> acknowledgeIncident(int incidentId) async {
    final result = await _acknowledgeIncidentUseCase(incidentId);

    return result.fold((failure) => false, (_) {
      // Reload incident detail to get updated data
      loadIncidentDetail(incidentId);
      return true;
    });
  }

  /// Resolve incident
  Future<bool> resolveIncident(int incidentId) async {
    final result = await _resolveIncidentUseCase(incidentId);

    return result.fold((failure) => false, (_) {
      // Reload incident detail to get updated data
      loadIncidentDetail(incidentId);
      return true;
    });
  }

  /// Request AI analysis
  Future<bool> requestAIAnalysis(
    int incidentId, {
    bool forceReanalyze = false,
  }) async {
    final result = await _requestAIAnalysisUseCase(
      incidentId,
      forceReanalyze: forceReanalyze,
    );

    print('test001, result is $result');
    return result.fold((failure) => false, (_) {
      // Reload incident detail to get the new AI analysis
      loadIncidentDetail(incidentId);
      return true;
    });
  }
}

/// Provider for Incident Detail ViewModel
/// This is a family provider that takes an incident ID
final incidentDetailViewModelProvider =
    StateNotifierProvider.family<
      IncidentDetailViewModel,
      IncidentDetailState,
      int
    >((ref, incidentId) {
      final getIncidentsUseCase = ref.watch(getIncidentsUseCaseProvider);
      final getAIAnalysisUseCase = ref.watch(getAIAnalysisUseCaseProvider);
      final acknowledgeIncidentUseCase = ref.watch(
        acknowledgeIncidentUseCaseProvider,
      );
      final resolveIncidentUseCase = ref.watch(resolveIncidentUseCaseProvider);
      final requestAIAnalysisUseCase = ref.watch(
        requestAIAnalysisUseCaseProvider,
      );

      final viewModel = IncidentDetailViewModel(
        getIncidentsUseCase,
        getAIAnalysisUseCase,
        acknowledgeIncidentUseCase,
        resolveIncidentUseCase,
        requestAIAnalysisUseCase,
      );

      // Auto-load incident detail when provider is first accessed
      viewModel.loadIncidentDetail(incidentId);

      return viewModel;
    });
