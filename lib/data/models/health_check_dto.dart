import 'package:json_annotation/json_annotation.dart';

part 'health_check_dto.g.dart';

/// Health Check DTO matching backend API response
@JsonSerializable()
class HealthCheckDto {
  final int id;
  @JsonKey(name: 'service_id')
  final int serviceId;
  @JsonKey(name: 'is_alive')
  final bool isAlive;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey(name: 'latency_ms')
  final int? latencyMs;
  @JsonKey(name: 'response_body')
  final String? responseBody;
  @JsonKey(name: 'error_message')
  final String? errorMessage;
  @JsonKey(name: 'error_type')
  final String? errorType;
  @JsonKey(name: 'checked_at')
  final DateTime checkedAt;
  @JsonKey(name: 'needs_analysis')
  final bool needsAnalysis;

  HealthCheckDto({
    required this.id,
    required this.serviceId,
    required this.isAlive,
    this.statusCode,
    this.latencyMs,
    this.responseBody,
    this.errorMessage,
    this.errorType,
    required this.checkedAt,
    required this.needsAnalysis,
  });

  factory HealthCheckDto.fromJson(Map<String, dynamic> json) =>
      _$HealthCheckDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HealthCheckDtoToJson(this);
}
