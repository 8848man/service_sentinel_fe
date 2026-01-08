import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_client.dart';
import '../../data/data_sources/service_remote_data_source.dart';
import '../../data/data_sources/incident_remote_data_source.dart';
import '../../data/data_sources/dashboard_remote_data_source.dart';
import '../../data/repositories/service_repository_impl.dart';
import '../../data/repositories/incident_repository_impl.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/service_repository.dart';
import '../../domain/repositories/incident_repository.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/use_cases/get_dashboard_overview.dart';
import '../../domain/use_cases/get_services.dart';
import '../../domain/use_cases/get_incidents.dart';

// ============================================================================
// API Client
// ============================================================================

/// Provider for API client (singleton)
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// ============================================================================
// Data Sources
// ============================================================================

/// Provider for Service remote data source
final serviceRemoteDataSourceProvider = Provider<ServiceRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ServiceRemoteDataSource(apiClient);
});

/// Provider for Incident remote data source
final incidentRemoteDataSourceProvider = Provider<IncidentRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return IncidentRemoteDataSource(apiClient);
});

/// Provider for Dashboard remote data source
final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardRemoteDataSource(apiClient);
});

// ============================================================================
// Repositories
// ============================================================================

/// Provider for Service repository
final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  final dataSource = ref.watch(serviceRemoteDataSourceProvider);
  return ServiceRepositoryImpl(dataSource);
});

/// Provider for Incident repository
final incidentRepositoryProvider = Provider<IncidentRepository>((ref) {
  final dataSource = ref.watch(incidentRemoteDataSourceProvider);
  return IncidentRepositoryImpl(dataSource);
});

/// Provider for Dashboard repository
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final dataSource = ref.watch(dashboardRemoteDataSourceProvider);
  return DashboardRepositoryImpl(dataSource);
});

// ============================================================================
// Use Cases
// ============================================================================

/// Provider for Get Dashboard Overview use case
final getDashboardOverviewUseCaseProvider = Provider<GetDashboardOverviewUseCase>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetDashboardOverviewUseCase(repository);
});

/// Provider for Get Services use case
final getServicesUseCaseProvider = Provider<GetServicesUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return GetServicesUseCase(repository);
});

/// Provider for Get Incidents use case
final getIncidentsUseCaseProvider = Provider<GetIncidentsUseCase>((ref) {
  final repository = ref.watch(incidentRepositoryProvider);
  return GetIncidentsUseCase(repository);
});
