import 'package:dio/dio.dart';

/// Custom API exception
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final ApiExceptionType type;

  const ApiException({
    required this.message,
    this.statusCode,
    required this.type,
  });

  /// Create ApiException from DioException
  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: 'Connection timeout. Please check your internet connection.',
          type: ApiExceptionType.timeout,
        );

      case DioExceptionType.badResponse:
        return ApiException(
          message: _getMessageFromResponse(error.response),
          statusCode: error.response?.statusCode,
          type: ApiExceptionType.response,
        );

      case DioExceptionType.cancel:
        return const ApiException(
          message: 'Request was cancelled',
          type: ApiExceptionType.cancel,
        );

      case DioExceptionType.unknown:
        if (error.error.toString().contains('SocketException')) {
          return const ApiException(
            message: 'No internet connection',
            type: ApiExceptionType.network,
          );
        }
        return ApiException(
          message: error.message ?? 'Unknown error occurred',
          type: ApiExceptionType.unknown,
        );

      default:
        return const ApiException(
          message: 'An unexpected error occurred',
          type: ApiExceptionType.unknown,
        );
    }
  }

  /// Extract error message from response
  static String _getMessageFromResponse(Response? response) {
    if (response == null) {
      return 'Server error occurred';
    }

    try {
      final data = response.data;
      if (data is Map) {
        // Try common error message fields
        if (data.containsKey('detail')) {
          return data['detail'].toString();
        }
        if (data.containsKey('message')) {
          return data['message'].toString();
        }
        if (data.containsKey('error')) {
          return data['error'].toString();
        }
      }

      // Default messages based on status code
      switch (response.statusCode) {
        case 400:
          return 'Invalid request';
        case 401:
          return 'Unauthorized access';
        case 403:
          return 'Access forbidden';
        case 404:
          return 'Resource not found';
        case 500:
          return 'Internal server error';
        case 502:
          return 'Bad gateway';
        case 503:
          return 'Service unavailable';
        default:
          return 'Error: ${response.statusCode}';
      }
    } catch (_) {
      return 'Server error occurred';
    }
  }

  @override
  String toString() => message;
}

/// API exception types
enum ApiExceptionType {
  timeout,
  network,
  response,
  cancel,
  unknown,
}
