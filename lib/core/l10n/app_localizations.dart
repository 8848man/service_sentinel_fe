import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Supported locales
enum AppLocale {
  en,
  ko;

  Locale get locale {
    switch (this) {
      case AppLocale.en:
        return const Locale('en');
      case AppLocale.ko:
        return const Locale('ko');
    }
  }

  String get displayName {
    switch (this) {
      case AppLocale.en:
        return 'English';
      case AppLocale.ko:
        return '한국어';
    }
  }

  static AppLocale fromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'ko':
        return AppLocale.ko;
      case 'en':
      default:
        return AppLocale.en;
    }
  }
}

/// Application localization class
class AppLocalizations {
  final Locale locale;
  late Map<String, dynamic> _localizedStrings;

  AppLocalizations(this.locale);

  /// Get localized string by key path (e.g., "app.title")
  String translate(String key) {
    final keys = key.split('.');
    dynamic value = _localizedStrings;

    for (final k in keys) {
      if (value is Map<String, dynamic> && value.containsKey(k)) {
        value = value[k];
      } else {
        return key; // Return key if translation not found
      }
    }

    return value.toString();
  }

  /// Static helper to get AppLocalizations from context
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Load translations from JSON file
  static Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    final jsonString = await rootBundle
        .loadString('assets/translations/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    localizations._localizedStrings = jsonMap;
    return localizations;
  }

  /// List of supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ko'),
  ];
}

/// Localization delegate
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .any((supported) => supported.languageCode == locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
