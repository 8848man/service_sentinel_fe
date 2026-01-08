// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_check_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthCheckDto _$HealthCheckDtoFromJson(Map<String, dynamic> json) =>
    HealthCheckDto(
      id: (json['id'] as num).toInt(),
      serviceId: (json['service_id'] as num).toInt(),
      isAlive: json['is_alive'] as bool,
      statusCode: (json['status_code'] as num?)?.toInt(),
      latencyMs: (json['latency_ms'] as num?)?.toInt(),
      responseBody: json['response_body'] as String?,
      errorMessage: json['error_message'] as String?,
      errorType: json['error_type'] as String?,
      checkedAt: DateTime.parse(json['checked_at'] as String),
      needsAnalysis: json['needs_analysis'] as bool,
    );

Map<String, dynamic> _$HealthCheckDtoToJson(HealthCheckDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_id': instance.serviceId,
      'is_alive': instance.isAlive,
      'status_code': instance.statusCode,
      'latency_ms': instance.latencyMs,
      'response_body': instance.responseBody,
      'error_message': instance.errorMessage,
      'error_type': instance.errorType,
      'checked_at': instance.checkedAt.toIso8601String(),
      'needs_analysis': instance.needsAnalysis,
    };
