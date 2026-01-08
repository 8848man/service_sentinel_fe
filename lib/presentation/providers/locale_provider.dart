import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_provider.dart';

/// Locale notifier to manage language state
class LocaleNotifier extends StateNotifier<Locale> {
  static const String _localeKey = 'app_locale';
  final SharedPreferences _prefs;

  LocaleNotifier(this._prefs) : super(const Locale('en')) {
    _loadLocale();
  }

  /// Load saved locale from preferences
  void _loadLocale() {
    final localeCode = _prefs.getString(_localeKey);
    if (localeCode != null) {
      state = Locale(localeCode);
    }
  }

  /// Set locale and persist
  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _prefs.setString(_localeKey, locale.languageCode);
  }

  /// Toggle between English and Korean
  Future<void> toggleLocale() async {
    final newLocale = state.languageCode == 'en'
      ? const Locale('ko')
      : const Locale('en');
    await setLocale(newLocale);
  }
}

/// Provider for locale state
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  if (prefs == null) {
    throw Exception('SharedPreferences not initialized');
  }
  return LocaleNotifier(prefs);
});

/// Supported locales
final supportedLocalesProvider = Provider<List<Locale>>((ref) {
  return const [
    Locale('en'),
    Locale('ko'),
  ];
});
