import 'package:json_annotation/json_annotation.dart';

part 'service_dto.g.dart';

/// Service DTO matching backend API response
@JsonSerializable()
class ServiceDto {
  final int id;
  final String name;
  final String? description;
  @JsonKey(name: 'endpoint_url')
  final String endpointUrl;
  @JsonKey(name: 'http_method')
  final String httpMethod;
  @JsonKey(name: 'service_type')
  final String serviceType;
  final Map<String, dynamic>? headers;
  @JsonKey(name: 'request_body')
  final Map<String, dynamic>? requestBody;
  @JsonKey(name: 'expected_status_codes')
  final List<int> expectedStatusCodes;
  @JsonKey(name: 'timeout_seconds')
  final int timeoutSeconds;
  @JsonKey(name: 'check_interval_seconds')
  final int checkIntervalSeconds;
  @JsonKey(name: 'failure_threshold')
  final int failureThreshold;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'last_checked_at')
  final DateTime? lastCheckedAt;

  ServiceDto({
    required this.id,
    required this.name,
    this.description,
    required this.endpointUrl,
    required this.httpMethod,
    required this.serviceType,
    this.headers,
    this.requestBody,
    required this.expectedStatusCodes,
    required this.timeoutSeconds,
    required this.checkIntervalSeconds,
    required this.failureThreshold,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.lastCheckedAt,
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDtoToJson(this);
}

/// Service create/update request DTO
@JsonSerializable()
class ServiceCreateDto {
  final String name;
  final String? description;
  @JsonKey(name: 'endpoint_url')
  final String endpointUrl;
  @JsonKey(name: 'http_method')
  final String httpMethod;
  @JsonKey(name: 'service_type')
  final String serviceType;
  final Map<String, dynamic>? headers;
  @JsonKey(name: 'request_body')
  final Map<String, dynamic>? requestBody;
  @JsonKey(name: 'expected_status_codes')
  final List<int> expectedStatusCodes;
  @JsonKey(name: 'timeout_seconds')
  final int timeoutSeconds;
  @JsonKey(name: 'check_interval_seconds')
  final int checkIntervalSeconds;
  @JsonKey(name: 'failure_threshold')
  final int failureThreshold;

  ServiceCreateDto({
    required this.name,
    this.description,
    required this.endpointUrl,
    required this.httpMethod,
    required this.serviceType,
    this.headers,
    this.requestBody,
    required this.expectedStatusCodes,
    required this.timeoutSeconds,
    required this.checkIntervalSeconds,
    required this.failureThreshold,
  });

  factory ServiceCreateDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCreateDtoToJson(this);
}
