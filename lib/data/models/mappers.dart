import 'service_dto.dart';
import 'health_check_dto.dart';
import 'incident_dto.dart';
import 'ai_analysis_dto.dart';
import 'dashboard_dto.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/health_check.dart';
import '../../domain/entities/incident.dart';
import '../../domain/entities/ai_analysis.dart';
import '../../domain/entities/service_status.dart';

/// Service DTO to Entity mapper
extension ServiceDtoMapper on ServiceDto {
  Service toEntity() {
    return Service(
      id: id,
      name: name,
      description: description,
      endpointUrl: endpointUrl,
      httpMethod: httpMethod,
      serviceType: serviceType,
      headers: headers,
      requestBody: requestBody,
      expectedStatusCodes: expectedStatusCodes,
      timeoutSeconds: timeoutSeconds,
      checkIntervalSeconds: checkIntervalSeconds,
      failureThreshold: failureThreshold,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastCheckedAt: lastCheckedAt,
      status: status != null ? ServiceStatus.fromString(status!) : null,
      lastCheckLatencyMs: lastCheckLatencyMs,
    );
  }
}

/// Health Check DTO to Entity mapper
extension HealthCheckDtoMapper on HealthCheckDto {
  HealthCheck toEntity() {
    return HealthCheck(
      id: id,
      serviceId: serviceId,
      isAlive: isAlive,
      statusCode: statusCode,
      latencyMs: latencyMs,
      responseBody: responseBody,
      errorMessage: errorMessage,
      errorType: errorType,
      checkedAt: checkedAt,
      needsAnalysis: needsAnalysis,
    );
  }
}

/// Incident DTO to Entity mapper
extension IncidentDtoMapper on IncidentDto {
  Incident toEntity() {
    return Incident(
      id: id,
      serviceId: serviceId,
      serviceName: serviceName,
      triggerCheckId: triggerCheckId,
      title: title,
      description: description,
      status: IncidentStatus.fromString(status),
      severity: IncidentSeverity.fromString(severity),
      consecutiveFailures: consecutiveFailures,
      totalAffectedChecks: totalAffectedChecks,
      detectedAt: detectedAt,
      resolvedAt: resolvedAt,
      acknowledgedAt: acknowledgedAt,
      aiAnalysisRequested: aiAnalysisRequested,
      aiAnalysisCompleted: aiAnalysisCompleted,
    );
  }
}

/// Suggested Action DTO to Entity mapper
extension SuggestedActionDtoMapper on SuggestedActionDto {
  SuggestedAction toEntity() {
    return SuggestedAction(
      action: action,
      priority: priority,
      estimatedImpact: estimatedImpact,
    );
  }
}

/// AI Analysis DTO to Entity mapper
extension AIAnalysisDtoMapper on AIAnalysisDto {
  AIAnalysis toEntity() {
    return AIAnalysis(
      id: id,
      incidentId: incidentId,
      modelUsed: modelUsed,
      promptTokens: promptTokens,
      completionTokens: completionTokens,
      totalCostUsd: totalCostUsd,
      rootCauseHypothesis: rootCauseHypothesis,
      confidenceScore: confidenceScore,
      debugChecklist: debugChecklist,
      suggestedActions: suggestedActions.map((dto) => dto.toEntity()).toList(),
      relatedErrorPatterns: relatedErrorPatterns,
      analyzedAt: analyzedAt,
      analysisDurationMs: analysisDurationMs,
    );
  }
}

/// Service Overview DTO to Entity mapper
extension ServiceOverviewDtoMapper on ServiceOverviewDto {
  ServiceOverview toEntity() {
    return ServiceOverview(
      id: id,
      name: name,
      status: ServiceStatus.fromString(status),
      lastCheckIsAlive: lastCheckIsAlive,
      lastCheckLatencyMs: lastCheckLatencyMs,
      lastCheckedAt: lastCheckedAt,
      activeIncidentId: activeIncidentId,
      activeIncidentSeverity: activeIncidentSeverity,
    );
  }
}

/// Dashboard Overview DTO to Entity mapper
extension DashboardOverviewDtoMapper on DashboardOverviewDto {
  DashboardOverview toEntity() {
    return DashboardOverview(
      totalServices: totalServices,
      activeServices: activeServices,
      servicesHealthy: servicesHealthy,
      servicesWarning: servicesWarning,
      servicesDown: servicesDown,
      servicesUnknown: servicesUnknown,
      openIncidents: openIncidents,
      criticalIncidents: criticalIncidents,
      services: services.map((dto) => dto.toEntity()).toList(),
    );
  }
}

/// Service Stats DTO to Entity mapper
extension ServiceStatsDtoMapper on ServiceStatsDto {
  ServiceStats toEntity() {
    return ServiceStats(
      serviceId: serviceId,
      uptimePercentage: uptimePercentage,
      totalChecks: totalChecks,
      successfulChecks: successfulChecks,
      failedChecks: failedChecks,
      avgLatencyMs: avgLatencyMs,
      period: period,
    );
  }
}
