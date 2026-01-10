import 'package:json_annotation/json_annotation.dart';

part 'ai_analysis_dto.g.dart';

/// Suggested Action DTO
@JsonSerializable()
class SuggestedActionDto {
  final String action;
  final String priority;
  @JsonKey(name: 'estimated_impact')
  final String estimatedImpact;

  SuggestedActionDto({
    required this.action,
    required this.priority,
    required this.estimatedImpact,
  });

  factory SuggestedActionDto.fromJson(Map<String, dynamic> json) =>
      _$SuggestedActionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestedActionDtoToJson(this);
}

/// AI Analysis DTO matching backend API response
@JsonSerializable()
class AIAnalysisDto {
  final int id;
  @JsonKey(name: 'incident_id')
  final int incidentId;
  @JsonKey(name: 'model_used')
  final String modelUsed;
  @JsonKey(name: 'prompt_tokens')
  final int? promptTokens;
  @JsonKey(name: 'completion_tokens')
  final int? completionTokens;
  @JsonKey(name: 'total_cost_usd')
  final double? totalCostUsd;
  @JsonKey(name: 'root_cause_hypothesis')
  final String rootCauseHypothesis;
  @JsonKey(name: 'confidence_score')
  final double confidenceScore;
  @JsonKey(name: 'debug_checklist')
  final List<String> debugChecklist;
  @JsonKey(name: 'suggested_actions')
  final List<SuggestedActionDto> suggestedActions;
  @JsonKey(name: 'related_error_patterns')
  final List<String> relatedErrorPatterns;
  @JsonKey(name: 'analyzed_at')
  final DateTime analyzedAt;
  @JsonKey(name: 'analysis_duration_ms')
  final int analysisDurationMs;

  AIAnalysisDto({
    required this.id,
    required this.incidentId,
    required this.modelUsed,
    required this.promptTokens,
    required this.completionTokens,
    required this.totalCostUsd,
    required this.rootCauseHypothesis,
    required this.confidenceScore,
    required this.debugChecklist,
    required this.suggestedActions,
    required this.relatedErrorPatterns,
    required this.analyzedAt,
    required this.analysisDurationMs,
  });

  factory AIAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$AIAnalysisDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AIAnalysisDtoToJson(this);
}
