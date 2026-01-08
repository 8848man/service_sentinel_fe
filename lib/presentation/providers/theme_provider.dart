import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';

/// Theme notifier to manage theme state
class ThemeNotifier extends StateNotifier<AppThemeMode> {
  static const String _themeKey = 'app_theme_mode';
  final SharedPreferences _prefs;

  ThemeNotifier(this._prefs) : super(AppThemeMode.white) {
    _loadTheme();
  }

  /// Load saved theme from preferences
  void _loadTheme() {
    final themeIndex = _prefs.getInt(_themeKey);
    if (themeIndex != null && themeIndex < AppThemeMode.values.length) {
      state = AppThemeMode.values[themeIndex];
    }
  }

  /// Set theme and persist
  Future<void> setTheme(AppThemeMode mode) async {
    state = mode;
    await _prefs.setInt(_themeKey, mode.index);
  }

  /// Cycle through themes (for quick testing)
  Future<void> cycleTheme() async {
    final nextIndex = (state.index + 1) % AppThemeMode.values.length;
    await setTheme(AppThemeMode.values[nextIndex]);
  }
}

/// Provider for SharedPreferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider for theme state
final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  if (prefs == null) {
    throw Exception('SharedPreferences not initialized');
  }
  return ThemeNotifier(prefs);
});
