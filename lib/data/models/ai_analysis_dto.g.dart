// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_analysis_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestedActionDto _$SuggestedActionDtoFromJson(Map<String, dynamic> json) =>
    SuggestedActionDto(
      action: json['action'] as String,
      priority: json['priority'] as String,
      estimatedImpact: json['estimated_impact'] as String,
    );

Map<String, dynamic> _$SuggestedActionDtoToJson(SuggestedActionDto instance) =>
    <String, dynamic>{
      'action': instance.action,
      'priority': instance.priority,
      'estimated_impact': instance.estimatedImpact,
    };

AIAnalysisDto _$AIAnalysisDtoFromJson(Map<String, dynamic> json) =>
    AIAnalysisDto(
      id: (json['id'] as num).toInt(),
      incidentId: (json['incident_id'] as num).toInt(),
      modelUsed: json['model_used'] as String,
      promptTokens: (json['prompt_tokens'] as num?)?.toInt(),
      completionTokens: (json['completion_tokens'] as num?)?.toInt(),
      totalCostUsd: (json['total_cost_usd'] as num?)?.toDouble(),
      rootCauseHypothesis: json['root_cause_hypothesis'] as String,
      confidenceScore: (json['confidence_score'] as num).toDouble(),
      debugChecklist: (json['debug_checklist'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      suggestedActions: (json['suggested_actions'] as List<dynamic>)
          .map((e) => SuggestedActionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      relatedErrorPatterns: (json['related_error_patterns'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      analyzedAt: DateTime.parse(json['analyzed_at'] as String),
      analysisDurationMs: (json['analysis_duration_ms'] as num).toInt(),
    );

Map<String, dynamic> _$AIAnalysisDtoToJson(AIAnalysisDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incident_id': instance.incidentId,
      'model_used': instance.modelUsed,
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_cost_usd': instance.totalCostUsd,
      'root_cause_hypothesis': instance.rootCauseHypothesis,
      'confidence_score': instance.confidenceScore,
      'debug_checklist': instance.debugChecklist,
      'suggested_actions': instance.suggestedActions,
      'related_error_patterns': instance.relatedErrorPatterns,
      'analyzed_at': instance.analyzedAt.toIso8601String(),
      'analysis_duration_ms': instance.analysisDurationMs,
    };
