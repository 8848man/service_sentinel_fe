import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/health_check.dart';
import '../../../domain/entities/service_status.dart';

part 'service_detail_state.freezed.dart';

/// Service detail screen state
@freezed
class ServiceDetailState with _$ServiceDetailState {
  const factory ServiceDetailState.initial() = _Initial;
  const factory ServiceDetailState.loading() = _Loading;
  const factory ServiceDetailState.loaded({
    required Service service,
    required List<HealthCheck> healthChecks,
    required ServiceStats stats,
  }) = _Loaded;
  const factory ServiceDetailState.error(String message) = _Error;
}
