import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/dio_client.dart';

/// Global DioClient provider
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// Logger provider (optional - for structured logging)
// final loggerProvider = Provider<Logger>((ref) {
//   return Logger();
// });
