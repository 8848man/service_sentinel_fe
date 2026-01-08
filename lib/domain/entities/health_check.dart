/// Health check entity representing a service health check result
class HealthCheck {
  final int id;
  final int serviceId;
  final bool isAlive;
  final int? statusCode;
  final int? latencyMs;
  final String? responseBody;
  final String? errorMessage;
  final String? errorType;
  final DateTime checkedAt;
  final bool needsAnalysis;

  const HealthCheck({
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

  HealthCheck copyWith({
    int? id,
    int? serviceId,
    bool? isAlive,
    int? statusCode,
    int? latencyMs,
    String? responseBody,
    String? errorMessage,
    String? errorType,
    DateTime? checkedAt,
    bool? needsAnalysis,
  }) {
    return HealthCheck(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      isAlive: isAlive ?? this.isAlive,
      statusCode: statusCode ?? this.statusCode,
      latencyMs: latencyMs ?? this.latencyMs,
      responseBody: responseBody ?? this.responseBody,
      errorMessage: errorMessage ?? this.errorMessage,
      errorType: errorType ?? this.errorType,
      checkedAt: checkedAt ?? this.checkedAt,
      needsAnalysis: needsAnalysis ?? this.needsAnalysis,
    );
  }
}
