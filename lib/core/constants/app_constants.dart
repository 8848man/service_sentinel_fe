/// Application constants
class AppConstants {
  AppConstants._();

  // API Configuration
  static const String apiBaseUrl = 'http://localhost:8000/api/v1';
  static const Duration apiConnectTimeout = Duration(seconds: 10);
  static const Duration apiReceiveTimeout = Duration(seconds: 10);

  // Polling Configuration
  static const Duration pollingInterval = Duration(seconds: 30);

  // Pagination
  static const int defaultPageSize = 20;

  // Timeouts
  static const int defaultServiceTimeout = 10; // seconds
  static const int defaultCheckInterval = 60; // seconds
  static const int defaultFailureThreshold = 3;
}
