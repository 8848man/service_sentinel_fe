import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_client.dart';

/// Provider for API client (singleton)
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// Data sources will be added here as we create them
// Example:
// final serviceRemoteDataSourceProvider = Provider<ServiceRemoteDataSource>((ref) {
//   final apiClient = ref.watch(apiClientProvider);
//   return ServiceRemoteDataSource(apiClient);
// });

// Repositories will be added here as we create them
// Example:
// final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
//   final dataSource = ref.watch(serviceRemoteDataSourceProvider);
//   return ServiceRepositoryImpl(dataSource);
// });

// Use cases will be added here as we create them
// Example:
// final getServicesUseCaseProvider = Provider<GetServicesUseCase>((ref) {
//   final repository = ref.watch(serviceRepositoryProvider);
//   return GetServicesUseCase(repository);
// });
