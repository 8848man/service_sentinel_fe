// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDto _$ServiceDtoFromJson(Map<String, dynamic> json) => ServiceDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  endpointUrl: json['endpoint_url'] as String,
  httpMethod: json['http_method'] as String,
  serviceType: json['service_type'] as String,
  headers: json['headers'] as Map<String, dynamic>?,
  requestBody: json['request_body'] as Map<String, dynamic>?,
  expectedStatusCodes: (json['expected_status_codes'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  timeoutSeconds: (json['timeout_seconds'] as num).toInt(),
  checkIntervalSeconds: (json['check_interval_seconds'] as num).toInt(),
  failureThreshold: (json['failure_threshold'] as num).toInt(),
  isActive: json['is_active'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  lastCheckedAt: json['last_checked_at'] == null
      ? null
      : DateTime.parse(json['last_checked_at'] as String),
);

Map<String, dynamic> _$ServiceDtoToJson(ServiceDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'endpoint_url': instance.endpointUrl,
      'http_method': instance.httpMethod,
      'service_type': instance.serviceType,
      'headers': instance.headers,
      'request_body': instance.requestBody,
      'expected_status_codes': instance.expectedStatusCodes,
      'timeout_seconds': instance.timeoutSeconds,
      'check_interval_seconds': instance.checkIntervalSeconds,
      'failure_threshold': instance.failureThreshold,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'last_checked_at': instance.lastCheckedAt?.toIso8601String(),
    };

ServiceCreateDto _$ServiceCreateDtoFromJson(Map<String, dynamic> json) =>
    ServiceCreateDto(
      name: json['name'] as String,
      description: json['description'] as String?,
      endpointUrl: json['endpoint_url'] as String,
      httpMethod: json['http_method'] as String,
      serviceType: json['service_type'] as String,
      headers: json['headers'] as Map<String, dynamic>?,
      requestBody: json['request_body'] as Map<String, dynamic>?,
      expectedStatusCodes: (json['expected_status_codes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      timeoutSeconds: (json['timeout_seconds'] as num).toInt(),
      checkIntervalSeconds: (json['check_interval_seconds'] as num).toInt(),
      failureThreshold: (json['failure_threshold'] as num).toInt(),
    );

Map<String, dynamic> _$ServiceCreateDtoToJson(ServiceCreateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'endpoint_url': instance.endpointUrl,
      'http_method': instance.httpMethod,
      'service_type': instance.serviceType,
      'headers': instance.headers,
      'request_body': instance.requestBody,
      'expected_status_codes': instance.expectedStatusCodes,
      'timeout_seconds': instance.timeoutSeconds,
      'check_interval_seconds': instance.checkIntervalSeconds,
      'failure_threshold': instance.failureThreshold,
    };
