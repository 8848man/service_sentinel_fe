import 'service_status.dart';

/// Service entity representing a monitored service
class Service {
  final int id;
  final String name;
  final String? description;
  final String endpointUrl;
  final String httpMethod;
  final String serviceType;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? requestBody;
  final List<int> expectedStatusCodes;
  final int timeoutSeconds;
  final int checkIntervalSeconds;
  final int failureThreshold;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastCheckedAt;
  final ServiceStatus? status;
  final int? lastCheckLatencyMs;

  const Service({
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
    this.status,
    this.lastCheckLatencyMs,
  });

  Service copyWith({
    int? id,
    String? name,
    String? description,
    String? endpointUrl,
    String? httpMethod,
    String? serviceType,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? requestBody,
    List<int>? expectedStatusCodes,
    int? timeoutSeconds,
    int? checkIntervalSeconds,
    int? failureThreshold,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastCheckedAt,
    ServiceStatus? status,
    int? lastCheckLatencyMs,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      endpointUrl: endpointUrl ?? this.endpointUrl,
      httpMethod: httpMethod ?? this.httpMethod,
      serviceType: serviceType ?? this.serviceType,
      headers: headers ?? this.headers,
      requestBody: requestBody ?? this.requestBody,
      expectedStatusCodes: expectedStatusCodes ?? this.expectedStatusCodes,
      timeoutSeconds: timeoutSeconds ?? this.timeoutSeconds,
      checkIntervalSeconds: checkIntervalSeconds ?? this.checkIntervalSeconds,
      failureThreshold: failureThreshold ?? this.failureThreshold,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastCheckedAt: lastCheckedAt ?? this.lastCheckedAt,
      status: status ?? this.status,
      lastCheckLatencyMs: lastCheckLatencyMs ?? this.lastCheckLatencyMs,
    );
  }
}
