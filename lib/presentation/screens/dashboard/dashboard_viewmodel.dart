import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/use_cases/get_dashboard_overview.dart';
import '../../../core/di/injection.dart';
import 'dashboard_state.dart';

/// Dashboard ViewModel
class DashboardViewModel extends StateNotifier<DashboardState> {
  final GetDashboardOverviewUseCase _getDashboardOverviewUseCase;

  DashboardViewModel(this._getDashboardOverviewUseCase)
      : super(const DashboardState.initial());

  /// Load dashboard overview
  Future<void> loadDashboard() async {
    state = const DashboardState.loading();

    final result = await _getDashboardOverviewUseCase();

    result.fold(
      (failure) => state = DashboardState.error(failure.message),
      (overview) => state = DashboardState.loaded(overview),
    );
  }

  /// Refresh dashboard (for pull-to-refresh)
  Future<void> refreshDashboard() async {
    // For refresh, we don't show loading state to avoid flickering
    // The RefreshIndicator handles the loading UI
    final result = await _getDashboardOverviewUseCase();

    result.fold(
      (failure) => state = DashboardState.error(failure.message),
      (overview) => state = DashboardState.loaded(overview),
    );
  }
}

/// Provider for Dashboard ViewModel
final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>((ref) {
  final useCase = ref.watch(getDashboardOverviewUseCaseProvider);
  return DashboardViewModel(useCase);
});
