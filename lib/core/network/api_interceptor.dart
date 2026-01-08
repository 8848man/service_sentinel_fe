import 'package:dio/dio.dart';

/// API interceptor for request/response logging and modification
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add custom headers if needed
    // For example: authentication tokens
    // options.headers['Authorization'] = 'Bearer $token';

    // Log request
    print('📤 Request: ${options.method} ${options.path}');
    if (options.queryParameters.isNotEmpty) {
      print('   Query: ${options.queryParameters}');
    }
    if (options.data != null) {
      print('   Body: ${options.data}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response
    print('📥 Response: ${response.statusCode} ${response.requestOptions.path}');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log error
    print('❌ Error: ${err.type} ${err.requestOptions.path}');
    print('   Message: ${err.message}');
    if (err.response != null) {
      print('   Status: ${err.response?.statusCode}');
      print('   Data: ${err.response?.data}');
    }

    handler.next(err);
  }
}
