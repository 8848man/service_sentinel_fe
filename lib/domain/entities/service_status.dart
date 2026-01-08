/// Service status enum
enum ServiceStatus {
  healthy,
  warning,
  down,
  unknown;

  static ServiceStatus fromString(String status) {
    return ServiceStatus.values.firstWhere(
      (e) => e.name == status.toLowerCase(),
      orElse: () => ServiceStatus.unknown,
    );
  }
}

/// Service Overview entity for dashboard
class ServiceOverview {
  final int id;
  final String name;
  final ServiceStatus status;
  final bool? lastCheckIsAlive;
  final int? lastCheckLatencyMs;
  final DateTime? lastCheckedAt;
  final int? activeIncidentId;
  final String? activeIncidentSeverity;

  const ServiceOverview({
    required this.id,
    required this.name,
    required this.status,
    this.lastCheckIsAlive,
    this.lastCheckLatencyMs,
    this.lastCheckedAt,
    this.activeIncidentId,
    this.activeIncidentSeverity,
  });
}

/// Dashboard Overview entity
class DashboardOverview {
  final int totalServices;
  final int activeServices;
  final int servicesHealthy;
  final int servicesWarning;
  final int servicesDown;
  final int servicesUnknown;
  final int openIncidents;
  final int criticalIncidents;
  final List<ServiceOverview> services;

  const DashboardOverview({
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
}

/// Service Statistics entity
class ServiceStats {
  final int serviceId;
  final double uptimePercentage;
  final int totalChecks;
  final int successfulChecks;
  final int failedChecks;
  final double avgLatencyMs;
  final String period;

  const ServiceStats({
    required this.serviceId,
    required this.uptimePercentage,
    required this.totalChecks,
    required this.successfulChecks,
    required this.failedChecks,
    required this.avgLatencyMs,
    required this.period,
  });
}
