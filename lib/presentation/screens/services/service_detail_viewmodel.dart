import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/use_cases/get_service_by_id.dart';
import '../../../domain/use_cases/get_health_checks.dart';
import '../../../domain/use_cases/get_service_stats.dart';
import '../../../domain/use_cases/trigger_health_check.dart';
import '../../../domain/use_cases/delete_service.dart';
import '../../../core/di/injection.dart';
import 'service_detail_state.dart';

/// Service Detail ViewModel
class ServiceDetailViewModel extends StateNotifier<ServiceDetailState> {
  final GetServiceByIdUseCase _getServiceByIdUseCase;
  final GetHealthChecksUseCase _getHealthChecksUseCase;
  final GetServiceStatsUseCase _getServiceStatsUseCase;
  final TriggerHealthCheckUseCase _triggerHealthCheckUseCase;
  final DeleteServiceUseCase _deleteServiceUseCase;

  ServiceDetailViewModel(
    this._getServiceByIdUseCase,
    this._getHealthChecksUseCase,
    this._getServiceStatsUseCase,
    this._triggerHealthCheckUseCase,
    this._deleteServiceUseCase,
  ) : super(const ServiceDetailState.initial());

  /// Load service detail data
  Future<void> loadServiceDetail(int serviceId) async {
    state = const ServiceDetailState.loading();

    // Load service first
    final serviceResult = await _getServiceByIdUseCase(serviceId);

    // Check if service request failed
    final serviceOrNull = serviceResult.fold(
      (failure) {
        state = ServiceDetailState.error(failure.message);
        return null;
      },
      (service) => service,
    );

    if (serviceOrNull == null) return;

    // Load health checks and stats in parallel
    final healthChecksResult = await _getHealthChecksUseCase(serviceId, limit: 20);
    final statsResult = await _getServiceStatsUseCase(serviceId, period: '24h');

    // Check if health checks request failed
    final healthChecksOrNull = healthChecksResult.fold(
      (failure) {
        state = ServiceDetailState.error(failure.message);
        return null;
      },
      (healthChecks) => healthChecks,
    );

    if (healthChecksOrNull == null) return;

    // Check if stats request failed
    final statsOrNull = statsResult.fold(
      (failure) {
        state = ServiceDetailState.error(failure.message);
        return null;
      },
      (stats) => stats,
    );

    if (statsOrNull == null) return;

    // All requests successful
    state = ServiceDetailState.loaded(
      service: serviceOrNull,
      healthChecks: healthChecksOrNull,
      stats: statsOrNull,
    );
  }

  /// Refresh service detail
  Future<void> refreshServiceDetail(int serviceId) async {
    await loadServiceDetail(serviceId);
  }

  /// Trigger manual health check
  Future<bool> triggerHealthCheck(int serviceId) async {
    final result = await _triggerHealthCheckUseCase(serviceId);

    return result.fold(
      (failure) => false,
      (_) {
        // Reload service detail to get updated data
        loadServiceDetail(serviceId);
        return true;
      },
    );
  }

  /// Delete service
  Future<bool> deleteService(int serviceId) async {
    final result = await _deleteServiceUseCase(serviceId);

    return result.fold(
      (failure) => false,
      (_) => true,
    );
  }
}

/// Provider for Service Detail ViewModel
/// This is a family provider that takes a service ID
final serviceDetailViewModelProvider = StateNotifierProvider.family<
    ServiceDetailViewModel, ServiceDetailState, int>((ref, serviceId) {
  final getServiceByIdUseCase = ref.watch(getServiceByIdUseCaseProvider);
  final getHealthChecksUseCase = ref.watch(getHealthChecksUseCaseProvider);
  final getServiceStatsUseCase = ref.watch(getServiceStatsUseCaseProvider);
  final triggerHealthCheckUseCase = ref.watch(triggerHealthCheckUseCaseProvider);
  final deleteServiceUseCase = ref.watch(deleteServiceUseCaseProvider);

  final viewModel = ServiceDetailViewModel(
    getServiceByIdUseCase,
    getHealthChecksUseCase,
    getServiceStatsUseCase,
    triggerHealthCheckUseCase,
    deleteServiceUseCase,
  );

  // Auto-load service detail when provider is first accessed
  viewModel.loadServiceDetail(serviceId);

  return viewModel;
});
