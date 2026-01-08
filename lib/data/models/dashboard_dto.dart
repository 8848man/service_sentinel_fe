import 'package:json_annotation/json_annotation.dart';

part 'dashboard_dto.g.dart';

/// Service Overview Item DTO
@JsonSerializable()
class ServiceOverviewDto {
  final int id;
  final String name;
  final String status; // healthy, warning, down, unknown
  @JsonKey(name: 'last_check_is_alive')
  final bool? lastCheckIsAlive;
  @JsonKey(name: 'last_check_latency_ms')
  final int? lastCheckLatencyMs;
  @JsonKey(name: 'last_checked_at')
  final DateTime? lastCheckedAt;
  @JsonKey(name: 'active_incident_id')
  final int? activeIncidentId;
  @JsonKey(name: 'active_incident_severity')
  final String? activeIncidentSeverity;

  ServiceOverviewDto({
    required this.id,
    required this.name,
    required this.status,
    this.lastCheckIsAlive,
    this.lastCheckLatencyMs,
    this.lastCheckedAt,
    this.activeIncidentId,
    this.activeIncidentSeverity,
  });

  factory ServiceOverviewDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceOverviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceOverviewDtoToJson(this);
}

/// Dashboard Overview DTO matching backend API response
@JsonSerializable()
class DashboardOverviewDto {
  @JsonKey(name: 'total_services')
  final int totalServices;
  @JsonKey(name: 'active_services')
  final int activeServices;
  @JsonKey(name: 'services_healthy')
  final int servicesHealthy;
  @JsonKey(name: 'services_warning')
  final int servicesWarning;
  @JsonKey(name: 'services_down')
  final int servicesDown;
  @JsonKey(name: 'services_unknown')
  final int servicesUnknown;
  @JsonKey(name: 'open_incidents')
  final int openIncidents;
  @JsonKey(name: 'critical_incidents')
  final int criticalIncidents;
  final List<ServiceOverviewDto> services;

  DashboardOverviewDto({
    required this.totalServices,
    required this.activeServices,
    required this.servicesHealthy,
    required this.servicesWarning,
    required this.servicesDown,
    required this.servicesUnknown,
    required this.openIncidents,
    required this.criticalIncidents,
    required this.services,
  });

  factory DashboardOverviewDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardOverviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardOverviewDtoToJson(this);
}

/// Service Statistics DTO
@JsonSerializable()
class ServiceStatsDto {
  @JsonKey(name: 'service_id')
  final int serviceId;
  @JsonKey(name: 'uptime_percentage')
  final double uptimePercentage;
  @JsonKey(name: 'total_checks')
  final int totalChecks;
  @JsonKey(name: 'successful_checks')
  final int successfulChecks;
  @JsonKey(name: 'failed_checks')
  final int failedChecks;
  @JsonKey(name: 'avg_latency_ms')
  final double avgLatencyMs;
  final String period;

  ServiceStatsDto({
    required this.serviceId,
    required this.uptimePercentage,
    required this.totalChecks,
    required this.successfulChecks,
    required this.failedChecks,
    required this.avgLatencyMs,
    required this.period,
  });

  factory ServiceStatsDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceStatsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceStatsDtoToJson(this);
}
