/// Incident status enum
enum IncidentStatus {
  open,
  acknowledged,
  resolved;

  static IncidentStatus fromString(String status) {
    return IncidentStatus.values.firstWhere(
      (e) => e.name == status.toLowerCase(),
      orElse: () => IncidentStatus.open,
    );
  }
}

/// Incident severity enum
enum IncidentSeverity {
  low,
  medium,
  high,
  critical;

  static IncidentSeverity fromString(String severity) {
    return IncidentSeverity.values.firstWhere(
      (e) => e.name == severity.toLowerCase(),
      orElse: () => IncidentSeverity.medium,
    );
  }
}

/// Incident entity representing a service incident
class Incident {
  final int id;
  final int serviceId;
  final String? serviceName;
  final int triggerCheckId;
  final String title;
  final String description;
  final IncidentStatus status;
  final IncidentSeverity severity;
  final int consecutiveFailures;
  final int totalAffectedChecks;
  final DateTime detectedAt;
  final DateTime? resolvedAt;
  final DateTime? acknowledgedAt;
  final bool aiAnalysisRequested;
  final bool aiAnalysisCompleted;

  const Incident({
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

  Incident copyWith({
    int? id,
    int? serviceId,
    String? serviceName,
    int? triggerCheckId,
    String? title,
    String? description,
    IncidentStatus? status,
    IncidentSeverity? severity,
    int? consecutiveFailures,
    int? totalAffectedChecks,
    DateTime? detectedAt,
    DateTime? resolvedAt,
    DateTime? acknowledgedAt,
    bool? aiAnalysisRequested,
    bool? aiAnalysisCompleted,
  }) {
    return Incident(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      triggerCheckId: triggerCheckId ?? this.triggerCheckId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      severity: severity ?? this.severity,
      consecutiveFailures: consecutiveFailures ?? this.consecutiveFailures,
      totalAffectedChecks: totalAffectedChecks ?? this.totalAffectedChecks,
      detectedAt: detectedAt ?? this.detectedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
      aiAnalysisRequested: aiAnalysisRequested ?? this.aiAnalysisRequested,
      aiAnalysisCompleted: aiAnalysisCompleted ?? this.aiAnalysisCompleted,
    );
  }
}
