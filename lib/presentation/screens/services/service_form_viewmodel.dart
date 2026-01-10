import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/use_cases/create_service.dart';
import '../../../domain/use_cases/update_service.dart';
import '../../../domain/entities/service.dart';
import '../../../core/di/injection.dart';
import 'service_form_state.dart';

/// Service Form ViewModel
class ServiceFormViewModel extends StateNotifier<ServiceFormState> {
  final CreateServiceUseCase _createServiceUseCase;
  final UpdateServiceUseCase _updateServiceUseCase;

  ServiceFormViewModel(
    this._createServiceUseCase,
    this._updateServiceUseCase, {
    Service? initialService,
  }) : super(ServiceFormState.initial(service: initialService));

  /// Submit form (create or update)
  Future<void> submitForm(Map<String, dynamic> data, {int? serviceId}) async {
    state = const ServiceFormState.submitting();

    final result = serviceId != null
        ? await _updateServiceUseCase(serviceId, data)
        : await _createServiceUseCase(data);

    result.fold(
      (failure) => state = ServiceFormState.error(failure.message),
      (service) => state = ServiceFormState.success(service),
    );
  }

  /// Reset form to initial state
  void resetForm() {
    state = const ServiceFormState.initial();
  }
}

/// Provider for Service Form ViewModel
/// This is a family provider that takes an optional service for editing
final serviceFormViewModelProvider = StateNotifierProvider.family<
    ServiceFormViewModel, ServiceFormState, Service?>((ref, initialService) {
  final createServiceUseCase = ref.watch(createServiceUseCaseProvider);
  final updateServiceUseCase = ref.watch(updateServiceUseCaseProvider);

  return ServiceFormViewModel(
    createServiceUseCase,
    updateServiceUseCase,
    initialService: initialService,
  );
});
