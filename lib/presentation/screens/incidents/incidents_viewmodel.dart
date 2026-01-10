import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/use_cases/get_incidents.dart';
import '../../../domain/entities/incident.dart';
import '../../../core/di/injection.dart';
import 'incidents_state.dart';

/// Incidents ViewModel
class IncidentsViewModel extends StateNotifier<IncidentsState> {
  final GetIncidentsUseCase _getIncidentsUseCase;

  IncidentsViewModel(this._getIncidentsUseCase)
    : super(const IncidentsState.initial());

  /// Load incidents list
  Future<void> loadIncidents({String? status, String? severity}) async {
    state = const IncidentsState.loading();

    // Convert string filters to enums
    final statusEnum = status != null ? IncidentStatus.fromString(status) : null;
    final severityEnum = severity != null ? IncidentSeverity.fromString(severity) : null;

    final result = await _getIncidentsUseCase(
      status: statusEnum,
      severity: severityEnum,
    );

    result.fold(
      (failure) => state = IncidentsState.error(failure.message),
      (incidents) => state = IncidentsState.loaded(incidents),
    );
  }

  /// Refresh incidents (for pull-to-refresh)
  Future<void> refreshIncidents({String? status, String? severity}) async {
    // Convert string filters to enums
    final statusEnum = status != null ? IncidentStatus.fromString(status) : null;
    final severityEnum = severity != null ? IncidentSeverity.fromString(severity) : null;

    final result = await _getIncidentsUseCase(
      status: statusEnum,
      severity: severityEnum,
    );

    result.fold(
      (failure) => state = IncidentsState.error(failure.message),
      (incidents) => state = IncidentsState.loaded(incidents),
    );
  }
}

/// Provider for Incidents ViewModel
final incidentsViewModelProvider =
    StateNotifierProvider<IncidentsViewModel, IncidentsState>((ref) {
      final useCase = ref.watch(getIncidentsUseCaseProvider);
      return IncidentsViewModel(useCase);
    });
