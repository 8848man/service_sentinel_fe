// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncidentDto _$IncidentDtoFromJson(Map<String, dynamic> json) => IncidentDto(
  id: (json['id'] as num).toInt(),
  serviceId: (json['service_id'] as num).toInt(),
  serviceName: json['service_name'] as String?,
  triggerCheckId: (json['trigger_check_id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  status: json['status'] as String,
  severity: json['severity'] as String,
  consecutiveFailures: (json['consecutive_failures'] as num).toInt(),
  totalAffectedChecks: (json['total_affected_checks'] as num).toInt(),
  detectedAt: DateTime.parse(json['detected_at'] as String),
  resolvedAt: json['resolved_at'] == null
      ? null
      : DateTime.parse(json['resolved_at'] as String),
  acknowledgedAt: json['acknowledged_at'] == null
      ? null
      : DateTime.parse(json['acknowledged_at'] as String),
  aiAnalysisRequested: json['ai_analysis_requested'] as bool,
  aiAnalysisCompleted: json['ai_analysis_completed'] as bool,
);

Map<String, dynamic> _$IncidentDtoToJson(IncidentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'trigger_check_id': instance.triggerCheckId,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'severity': instance.severity,
      'consecutive_failures': instance.consecutiveFailures,
      'total_affected_checks': instance.totalAffectedChecks,
      'detected_at': instance.detectedAt.toIso8601String(),
      'resolved_at': instance.resolvedAt?.toIso8601String(),
      'acknowledged_at': instance.acknowledgedAt?.toIso8601String(),
      'ai_analysis_requested': instance.aiAnalysisRequested,
      'ai_analysis_completed': instance.aiAnalysisCompleted,
    };

IncidentListDto _$IncidentListDtoFromJson(Map<String, dynamic> json) =>
    IncidentListDto(
      total: (json['total'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => IncidentDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IncidentListDtoToJson(IncidentListDto instance) =>
    <String, dynamic>{'total': instance.total, 'items': instance.items};
