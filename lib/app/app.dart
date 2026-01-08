import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/theme/app_theme.dart';
import '../presentation/providers/theme_provider.dart';
import '../presentation/providers/locale_provider.dart';
import '../core/localization/l10n/app_localizations.dart';

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

      // Home (placeholder for now, will be replaced with proper routing)
      home: const _PlaceholderHome(),
    );
  }
}

/// Placeholder home screen
class _PlaceholderHome extends ConsumerWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(_getThemeIcon(themeMode)),
            tooltip: l10n.theme,
            onPressed: () {
              ref.read(themeProvider.notifier).cycleTheme();
            },
          ),
          // Language toggle button
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: l10n.language,
            onPressed: () {
              ref.read(localeProvider.notifier).toggleLocale();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.appTitle,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Theme: ${_getThemeName(themeMode)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Language: ${locale.languageCode.toUpperCase()}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Text(
              'Foundation setup complete! 🎉',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Next: Building design system...',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getThemeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.white:
        return Icons.light_mode;
      case AppThemeMode.black:
        return Icons.dark_mode;
      case AppThemeMode.blue:
        return Icons.palette;
    }
  }

  String _getThemeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.white:
        return 'White';
      case AppThemeMode.black:
        return 'Black';
      case AppThemeMode.blue:
        return 'Blue';
    }
  }
}
