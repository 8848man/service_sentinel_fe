import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/incident.dart';
import '../../../domain/entities/ai_analysis.dart';

part 'incident_detail_state.freezed.dart';

/// Incident detail screen state
@freezed
class IncidentDetailState with _$IncidentDetailState {
  const factory IncidentDetailState.initial() = _Initial;
  const factory IncidentDetailState.loading() = _Loading;
  const factory IncidentDetailState.loaded({
    required Incident incident,
    AIAnalysis? aiAnalysis,
  }) = _Loaded;
  const factory IncidentDetailState.error(String message) = _Error;
}
