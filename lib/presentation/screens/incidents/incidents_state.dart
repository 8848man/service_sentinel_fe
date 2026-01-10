import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/incident.dart';

part 'incidents_state.freezed.dart';

/// Incidents list screen state
@freezed
class IncidentsState with _$IncidentsState {
  const factory IncidentsState.initial() = _Initial;
  const factory IncidentsState.loading() = _Loading;
  const factory IncidentsState.loaded(List<Incident> incidents) = _Loaded;
  const factory IncidentsState.error(String message) = _Error;
}
