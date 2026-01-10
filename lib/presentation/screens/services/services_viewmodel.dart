import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/use_cases/get_services.dart';
import '../../../domain/use_cases/delete_service.dart';
import '../../../domain/use_cases/trigger_health_check.dart';
import '../../../core/di/injection.dart';
import 'services_state.dart';

/// Services ViewModel
class ServicesViewModel extends StateNotifier<ServicesState> {
  final GetServicesUseCase _getServicesUseCase;
  final DeleteServiceUseCase _deleteServiceUseCase;
  final TriggerHealthCheckUseCase _triggerHealthCheckUseCase;

  ServicesViewModel(
    this._getServicesUseCase,
    this._deleteServiceUseCase,
    this._triggerHealthCheckUseCase,
  ) : super(const ServicesState.initial());

  /// Load services list
  Future<void> loadServices() async {
    state = const ServicesState.loading();

    final result = await _getServicesUseCase();

    result.fold(
      (failure) => state = ServicesState.error(failure.message),
      (services) => state = ServicesState.loaded(services),
    );
  }

  /// Refresh services (for pull-to-refresh)
  Future<void> refreshServices() async {
    final result = await _getServicesUseCase();

    result.fold(
      (failure) => state = ServicesState.error(failure.message),
      (services) => state = ServicesState.loaded(services),
    );
  }

  /// Delete a service
  Future<bool> deleteService(int serviceId) async {
    final result = await _deleteServiceUseCase(serviceId);

    return result.fold(
      (failure) {
        // Keep current state, just return failure
        return false;
      },
      (_) {
        // Reload services after successful deletion
        loadServices();
        return true;
      },
    );
  }

  /// Trigger manual health check for a service
  Future<bool> triggerHealthCheck(int serviceId) async {
    final result = await _triggerHealthCheckUseCase(serviceId);

    return result.fold(
      (failure) => false,
      (_) {
        // Reload services to get updated status
        loadServices();
        return true;
      },
    );
  }
}

/// Provider for Services ViewModel
final servicesViewModelProvider =
    StateNotifierProvider<ServicesViewModel, ServicesState>((ref) {
  final getServicesUseCase = ref.watch(getServicesUseCaseProvider);
  final deleteServiceUseCase = ref.watch(deleteServiceUseCaseProvider);
  final triggerHealthCheckUseCase = ref.watch(triggerHealthCheckUseCaseProvider);
  return ServicesViewModel(
    getServicesUseCase,
    deleteServiceUseCase,
    triggerHealthCheckUseCase,
  );
});
