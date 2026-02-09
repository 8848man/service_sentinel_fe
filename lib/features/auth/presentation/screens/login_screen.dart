import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_sentinel_fe_v2/core/l10n/locale_provider.dart';
import 'package:service_sentinel_fe_v2/core/theme/app_theme_mode.dart';
import 'package:service_sentinel_fe_v2/core/theme/theme_provider.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../widgets/guest_entry_section.dart';
import '../widgets/login_form_section.dart';

/// Login screen - User authentication
/// Provides two authentication paths:
/// 1. Guest entry (local-only mode)
/// 2. Firebase email/password login (authenticated mode)
///
/// Screen is layout only. Provider consumption happens in section widgets.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App logo and title
                    Icon(
                      Icons.security,
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.app_title,
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.app_subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Login form section (ConsumerWidget)
                    const LoginFormSection(),

                    const SizedBox(height: 32), // Divider with "OR"
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            l10n.common_or,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 32),
                    // Guest entry section (ConsumerWidget)
                    const GuestEntrySection(),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                height: 72,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildSettings(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettings() {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeModeProvider);
        final locale = ref.watch(localeProvider);

        return Row(
          children: [
            IconButton(
              icon: Icon(
                themeMode == AppThemeMode.dark
                    ? Icons.dark_mode
                    : themeMode == AppThemeMode.light
                        ? Icons.light_mode
                        : Icons.brightness_auto,
              ),
              onPressed: () => _showThemeSelector(context, ref, themeMode),
            ),
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () => _showLanguageSelector(context, ref, locale),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showThemeSelector(
    BuildContext context,
    WidgetRef ref,
    AppThemeMode currentMode,
  ) async {
    final l10n = context.l10n;
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settings_select_theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppThemeMode.values
              .map((mode) => RadioListTile<AppThemeMode>(
                    value: mode,
                    groupValue: currentMode,
                    title: Text(_getThemeModeLabel(context, mode)),
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(themeModeProvider.notifier)
                            .setThemeMode(value);
                        Navigator.of(dialogContext).pop();
                      }
                    },
                  ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.common_cancel),
          ),
        ],
      ),
    );
  }

  String _getThemeModeLabel(BuildContext context, AppThemeMode mode) {
    final l10n = context.l10n;
    switch (mode) {
      case AppThemeMode.light:
        return l10n.settings_light;
      case AppThemeMode.dark:
        return l10n.settings_dark;
      case AppThemeMode.blue:
        return l10n.settings_blue;
    }
  }

  Future<void> _showLanguageSelector(
    BuildContext context,
    WidgetRef ref,
    Locale currentLocale,
  ) async {
    final l10n = context.l10n;
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settings_select_language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              value: 'en',
              groupValue: currentLocale.languageCode,
              title: Text(l10n.settings_english),
              onChanged: (value) {
                ref.read(localeProvider.notifier).setLocale(AppLocale.en);
                Navigator.of(dialogContext).pop();
              },
            ),
            RadioListTile<String>(
              value: 'ko',
              groupValue: currentLocale.languageCode,
              title: Text(l10n.settings_korean),
              onChanged: (value) {
                ref.read(localeProvider.notifier).setLocale(AppLocale.ko);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.common_cancel),
          ),
        ],
      ),
    );
  }
}
