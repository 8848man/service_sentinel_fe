/// Source of truth for data
enum SourceOfTruth {
  local, // Guest mode - Local DB
  server, // Authenticated mode - Server DB
}

/// Service types
enum ServiceType {
  httpApi,
  httpsApi,
  gcpEndpoint,
  firebase,
  websocket,
  grpc,
}

/// HTTP methods
enum HttpMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

/// Incident status
enum IncidentStatus {
  open,
  investigating,
  resolved,
  acknowledged,
}

/// Incident severity
enum IncidentSeverity {
  critical,
  high,
  medium,
  low,
}

/// Extensions for enum display names
extension ServiceTypeExtension on ServiceType {
  String get displayName {
    switch (this) {
      case ServiceType.httpApi:
        return 'HTTP API';
      case ServiceType.httpsApi:
        return 'HTTPS API';
      case ServiceType.gcpEndpoint:
        return 'GCP Endpoint';
      case ServiceType.firebase:
        return 'Firebase';
      case ServiceType.websocket:
        return 'WebSocket';
      case ServiceType.grpc:
        return 'gRPC';
    }
  }

  String get serverValue {
    switch (this) {
      case ServiceType.httpApi:
        return 'http_api';
      case ServiceType.httpsApi:
        return 'https_api';
      case ServiceType.gcpEndpoint:
        return 'gcp_endpoint';
      case ServiceType.firebase:
        return 'firebase';
      case ServiceType.websocket:
        return 'websocket';
      case ServiceType.grpc:
        return 'grpc';
    }
  }
}

extension HttpMethodExtension on HttpMethod {
  String get value {
    return name.toUpperCase();
  }
}

extension IncidentStatusExtension on IncidentStatus {
  String get displayName {
    switch (this) {
      case IncidentStatus.open:
        return 'Open';
      case IncidentStatus.investigating:
        return 'Investigating';
      case IncidentStatus.resolved:
        return 'Resolved';
      case IncidentStatus.acknowledged:
        return 'Acknowledged';
    }
  }
}

extension IncidentSeverityExtension on IncidentSeverity {
  String get displayName {
    switch (this) {
      case IncidentSeverity.critical:
        return 'Critical';
      case IncidentSeverity.high:
        return 'High';
      case IncidentSeverity.medium:
        return 'Medium';
      case IncidentSeverity.low:
        return 'Low';
    }
  }
}
