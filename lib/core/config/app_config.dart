/// Application configuration
class AppConfig {
  AppConfig._();

  /// Backend API base URL
  static const String apiBaseUrl = 'http://localhost:8000';

  /// API version
  static const String apiVersion = 'v2';

  /// Full API URL
  static String get apiUrl => '$apiBaseUrl/api/$apiVersion';

  /// Connection timeout in milliseconds
  static const int connectionTimeout = 30000;

  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;

  /// Enable debug logging
  static const bool enableDebugLogging = true;

  /// API Key header name
  static const String apiKeyHeader = 'X-API-Key';
}
