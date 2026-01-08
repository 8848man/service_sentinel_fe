// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceOverviewDto _$ServiceOverviewDtoFromJson(Map<String, dynamic> json) =>
    ServiceOverviewDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: json['status'] as String,
      lastCheckIsAlive: json['last_check_is_alive'] as bool?,
      lastCheckLatencyMs: (json['last_check_latency_ms'] as num?)?.toInt(),
      lastCheckedAt: json['last_checked_at'] == null
          ? null
          : DateTime.parse(json['last_checked_at'] as String),
      activeIncidentId: (json['active_incident_id'] as num?)?.toInt(),
      activeIncidentSeverity: json['active_incident_severity'] as String?,
    );

Map<String, dynamic> _$ServiceOverviewDtoToJson(ServiceOverviewDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'last_check_is_alive': instance.lastCheckIsAlive,
      'last_check_latency_ms': instance.lastCheckLatencyMs,
      'last_checked_at': instance.lastCheckedAt?.toIso8601String(),
      'active_incident_id': instance.activeIncidentId,
      'active_incident_severity': instance.activeIncidentSeverity,
    };

DashboardOverviewDto _$DashboardOverviewDtoFromJson(
  Map<String, dynamic> json,
) => DashboardOverviewDto(
  totalServices: (json['total_services'] as num).toInt(),
  activeServices: (json['active_services'] as num).toInt(),
  servicesHealthy: (json['services_healthy'] as num).toInt(),
  servicesWarning: (json['services_warning'] as num).toInt(),
  servicesDown: (json['services_down'] as num).toInt(),
  servicesUnknown: (json['services_unknown'] as num).toInt(),
  openIncidents: (json['open_incidents'] as num).toInt(),
  criticalIncidents: (json['critical_incidents'] as num).toInt(),
  services: (json['services'] as List<dynamic>)
      .map((e) => ServiceOverviewDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DashboardOverviewDtoToJson(
  DashboardOverviewDto instance,
) => <String, dynamic>{
  'total_services': instance.totalServices,
  'active_services': instance.activeServices,
  'services_healthy': instance.servicesHealthy,
  'services_warning': instance.servicesWarning,
  'services_down': instance.servicesDown,
  'services_unknown': instance.servicesUnknown,
  'open_incidents': instance.openIncidents,
  'critical_incidents': instance.criticalIncidents,
  'services': instance.services,
};

ServiceStatsDto _$ServiceStatsDtoFromJson(Map<String, dynamic> json) =>
    ServiceStatsDto(
      serviceId: (json['service_id'] as num).toInt(),
      uptimePercentage: (json['uptime_percentage'] as num).toDouble(),
      totalChecks: (json['total_checks'] as num).toInt(),
      successfulChecks: (json['successful_checks'] as num).toInt(),
      failedChecks: (json['failed_checks'] as num).toInt(),
      avgLatencyMs: (json['avg_latency_ms'] as num).toDouble(),
      period: json['period'] as String,
    );

Map<String, dynamic> _$ServiceStatsDtoToJson(ServiceStatsDto instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'uptime_percentage': instance.uptimePercentage,
      'total_checks': instance.totalChecks,
      'successful_checks': instance.successfulChecks,
      'failed_checks': instance.failedChecks,
      'avg_latency_ms': instance.avgLatencyMs,
      'period': instance.period,
    };
