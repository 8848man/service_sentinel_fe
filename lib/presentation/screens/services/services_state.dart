import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/service.dart';

part 'services_state.freezed.dart';

/// Services list screen state
@freezed
class ServicesState with _$ServicesState {
  const factory ServicesState.initial() = _Initial;
  const factory ServicesState.loading() = _Loading;
  const factory ServicesState.loaded(List<Service> services) = _Loaded;
  const factory ServicesState.error(String message) = _Error;
}
