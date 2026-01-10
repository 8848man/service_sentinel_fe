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
import '../../domain/use_cases/delete_service.dart';
import '../../domain/use_cases/trigger_health_check.dart';
import '../../domain/use_cases/get_service_by_id.dart';
import '../../domain/use_cases/get_health_checks.dart';
import '../../domain/use_cases/get_service_stats.dart';
import '../../domain/use_cases/create_service.dart';
import '../../domain/use_cases/update_service.dart';
import '../../domain/use_cases/acknowledge_incident.dart';
import '../../domain/use_cases/resolve_incident.dart';
import '../../domain/use_cases/request_ai_analysis.dart';
import '../../domain/use_cases/get_ai_analysis.dart';

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

/// Provider for Delete Service use case
final deleteServiceUseCaseProvider = Provider<DeleteServiceUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return DeleteServiceUseCase(repository);
});

/// Provider for Trigger Health Check use case
final triggerHealthCheckUseCaseProvider = Provider<TriggerHealthCheckUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return TriggerHealthCheckUseCase(repository);
});

/// Provider for Get Service By ID use case
final getServiceByIdUseCaseProvider = Provider<GetServiceByIdUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return GetServiceByIdUseCase(repository);
});

/// Provider for Get Health Checks use case
final getHealthChecksUseCaseProvider = Provider<GetHealthChecksUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return GetHealthChecksUseCase(repository);
});

/// Provider for Get Service Stats use case
final getServiceStatsUseCaseProvider = Provider<GetServiceStatsUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return GetServiceStatsUseCase(repository);
});

/// Provider for Create Service use case
final createServiceUseCaseProvider = Provider<CreateServiceUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return CreateServiceUseCase(repository);
});

/// Provider for Update Service use case
final updateServiceUseCaseProvider = Provider<UpdateServiceUseCase>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return UpdateServiceUseCase(repository);
});

/// Provider for Acknowledge Incident use case
final acknowledgeIncidentUseCaseProvider = Provider<AcknowledgeIncidentUseCase>((ref) {
  final repository = ref.watch(incidentRepositoryProvider);
  return AcknowledgeIncidentUseCase(repository);
});

/// Provider for Resolve Incident use case
final resolveIncidentUseCaseProvider = Provider<ResolveIncidentUseCase>((ref) {
  final repository = ref.watch(incidentRepositoryProvider);
  return ResolveIncidentUseCase(repository);
});

/// Provider for Request AI Analysis use case
final requestAIAnalysisUseCaseProvider = Provider<RequestAIAnalysisUseCase>((ref) {
  final repository = ref.watch(incidentRepositoryProvider);
  return RequestAIAnalysisUseCase(repository);
});

/// Provider for Get AI Analysis use case
final getAIAnalysisUseCaseProvider = Provider<GetAIAnalysisUseCase>((ref) {
  final repository = ref.watch(incidentRepositoryProvider);
  return GetAIAnalysisUseCase(repository);
});
