import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/theme/app_theme.dart';
import '../presentation/providers/theme_provider.dart';
import '../presentation/providers/locale_provider.dart';
import '../core/localization/l10n/app_localizations.dart';
import '../presentation/screens/main_screen.dart';

/// Root application widget
class ServiceSentinelApp extends ConsumerWidget {
  const ServiceSentinelApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'ServiceSentinel',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.getTheme(themeMode),

      // Localization
      locale: locale,
      supportedLocales: ref.watch(supportedLocalesProvider),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Home - Main Screen with bottom navigation
      home: const MainScreen(),
    );
  }
}
