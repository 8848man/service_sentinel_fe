import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/service_status.dart';

part 'dashboard_state.freezed.dart';

/// Dashboard screen state
@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;
  const factory DashboardState.loading() = _Loading;
  const factory DashboardState.loaded(DashboardOverview overview) = _Loaded;
  const factory DashboardState.error(String message) = _Error;
}
