import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/service.dart';

part 'service_form_state.freezed.dart';

/// Service form screen state
@freezed
class ServiceFormState with _$ServiceFormState {
  const factory ServiceFormState.initial({Service? service}) = _Initial;
  const factory ServiceFormState.submitting() = _Submitting;
  const factory ServiceFormState.success(Service service) = _Success;
  const factory ServiceFormState.error(String message) = _Error;
}
