import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../config/app_config.dart';

/// Dio HTTP client configuration
class DioClient {
  late final Dio _dio;
  final Logger _logger = Logger();

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiUrl,
        connectTimeout: const Duration(milliseconds: AppConfig.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: AppConfig.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  /// Get configured Dio instance
  Dio get dio => _dio;

  /// Set up interceptors for logging and error handling
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (AppConfig.enableDebugLogging) {
            _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
            _logger.d('Headers: ${options.headers}');
            if (options.data != null) {
              _logger.d('Data: ${options.data}');
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (AppConfig.enableDebugLogging) {
            _logger.d(
              'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
            );
            _logger.d('Data: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          if (AppConfig.enableDebugLogging) {
            _logger.e(
              'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
            );
            _logger.e('Message: ${error.message}');
            if (error.response?.data != null) {
              _logger.e('Data: ${error.response?.data}');
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// Add API Key to headers
  void setApiKey(String apiKey) {
    _dio.options.headers[AppConfig.apiKeyHeader] = apiKey;
  }

  /// Remove API Key from headers
  void clearApiKey() {
    _dio.options.headers.remove(AppConfig.apiKeyHeader);
  }
}
