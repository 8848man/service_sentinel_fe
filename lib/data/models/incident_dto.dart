import 'package:json_annotation/json_annotation.dart';

part 'incident_dto.g.dart';

/// Incident DTO matching backend API response
@JsonSerializable()
class IncidentDto {
  final int id;
  @JsonKey(name: 'service_id')
  final int serviceId;
  @JsonKey(name: 'service_name')
  final String? serviceName;
  @JsonKey(name: 'trigger_check_id')
  final int triggerCheckId;
  final String title;
  final String description;
  final String status; // open, acknowledged, resolved
  final String severity; // low, medium, high, critical
  @JsonKey(name: 'consecutive_failures')
  final int consecutiveFailures;
  @JsonKey(name: 'total_affected_checks')
  final int totalAffectedChecks;
  @JsonKey(name: 'detected_at')
  final DateTime detectedAt;
  @JsonKey(name: 'resolved_at')
  final DateTime? resolvedAt;
  @JsonKey(name: 'acknowledged_at')
  final DateTime? acknowledgedAt;
  @JsonKey(name: 'ai_analysis_requested')
  final bool aiAnalysisRequested;
  @JsonKey(name: 'ai_analysis_completed')
  final bool aiAnalysisCompleted;

  IncidentDto({
    required this.id,
    required this.serviceId,
    this.serviceName,
    required this.triggerCheckId,
    required this.title,
    required this.description,
    required this.status,
    required this.severity,
    required this.consecutiveFailures,
    required this.totalAffectedChecks,
    required this.detectedAt,
    this.resolvedAt,
    this.acknowledgedAt,
    required this.aiAnalysisRequested,
    required this.aiAnalysisCompleted,
  });

  factory IncidentDto.fromJson(Map<String, dynamic> json) =>
      _$IncidentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentDtoToJson(this);
}

/// Incident list response with pagination
@JsonSerializable()
class IncidentListDto {
  final int total;
  final List<IncidentDto> items;

  IncidentListDto({
    required this.total,
    required this.items,
  });

  factory IncidentListDto.fromJson(Map<String, dynamic> json) =>
      _$IncidentListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentListDtoToJson(this);
}
