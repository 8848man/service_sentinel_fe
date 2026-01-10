import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_state.dart';

/// Settings ViewModel
class SettingsViewModel extends StateNotifier<SettingsState> {
  SettingsViewModel() : super(const SettingsState.initial()) {
    _initialize();
  }

  void _initialize() {
    state = const SettingsState.loaded();
  }
}

/// Provider for Settings ViewModel
final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, SettingsState>((ref) {
  return SettingsViewModel();
});
