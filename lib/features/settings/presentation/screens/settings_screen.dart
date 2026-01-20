import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:service_sentinel_fe_v2/core/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/state/project_session_notifier.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/app_theme_mode.dart';
import '../../../../core/l10n/locale_provider.dart';
import '../../../auth/application/providers/auth_provider.dart';
import '../widgets/api_key_settings_section.dart';

/// Settings screen - App settings and preferences
/// Layout only. Provider consumption happens in section widgets.
///
/// Features:
/// - Theme selection
/// - Language selection
/// - API key management (authenticated users only)
/// - Account settings
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // General settings section
              const _GeneralSettingsSection(),

              const SizedBox(height: 24),

              // Project section (show current project and change button)
              const _ProjectSection(),

              const SizedBox(height: 24),

              // API Key settings section (authenticated only)
              const ApiKeySettingsSection(),

              const SizedBox(height: 24),

              // Account section
              const _AccountSection(),
            ],
          ),
        ),
      ),
    );
  }
}

/// General settings section (theme, language)
class _GeneralSettingsSection extends ConsumerWidget {
  const _GeneralSettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // Theme selector
            ListTile(
              leading: Icon(
                themeMode == AppThemeMode.dark
                    ? Icons.dark_mode
                    : themeMode == AppThemeMode.light
                        ? Icons.light_mode
                        : Icons.brightness_auto,
              ),
              title: const Text('Theme'),
              subtitle: Text(_getThemeModeLabel(themeMode)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showThemeSelector(context, ref, themeMode),
            ),

            const Divider(),

            // Language selector
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: Text(locale.languageCode.toUpperCase()),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showLanguageSelector(context, ref, locale),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeLabel(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.blue:
        return 'blue';
    }
  }

  Future<void> _showThemeSelector(
    BuildContext context,
    WidgetRef ref,
    AppThemeMode currentMode,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppThemeMode.values
              .map((mode) => RadioListTile<AppThemeMode>(
                    value: mode,
                    groupValue: currentMode,
                    title: Text(_getThemeModeLabel(mode)),
                    onChanged: (value) {
                      if (value != null) {
                        ref
                            .read(themeModeProvider.notifier)
                            .setThemeMode(value);
                        Navigator.of(context).pop();
                      }
                    },
                  ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _showLanguageSelector(
    BuildContext context,
    WidgetRef ref,
    Locale currentLocale,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              value: 'en',
              groupValue: currentLocale.languageCode,
              title: const Text('English'),
              onChanged: (value) {
                ref.read(localeProvider.notifier).setLocale(AppLocale.en);
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              value: 'ko',
              groupValue: currentLocale.languageCode,
              title: const Text('한국어 (Korean)'),
              onChanged: (value) {
                ref.read(localeProvider.notifier).setLocale(AppLocale.ko);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

/// Project section (current project and change button)
class _ProjectSection extends ConsumerWidget {
  const _ProjectSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final projectSession = ref.watch(projectSessionProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (projectSession.hasProject) ...[
              // Current project info
              ListTile(
                leading: Icon(
                  projectSession.project!.isLocalOnly
                      ? Icons.phonelink
                      : Icons.cloud_done,
                  color: theme.colorScheme.primary,
                ),
                title: Text(projectSession.project!.name),
                subtitle: projectSession.project!.description != null
                    ? Text(
                        projectSession.project!.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
              ),

              const Divider(),

              // Change project button
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: const Text('Change Project'),
                subtitle: const Text('Select a different project'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => context.go(AppRoutes.projectSelection),
              ),
            ] else ...[
              // No project selected
              ListTile(
                leading: Icon(
                  Icons.warning_amber,
                  color: theme.colorScheme.error,
                ),
                title: const Text('No Project Selected'),
                subtitle: const Text('Select a project to get started'),
              ),

              const Divider(),

              // Go to project selection button
              ElevatedButton.icon(
                onPressed: () => context.go(AppRoutes.projectSelection),
                icon: const Icon(Icons.add),
                label: const Text('Select Project'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Account section (logout, etc.)
class _AccountSection extends ConsumerWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Observe auth state
    final authStateAsync = ref.watch(authStateNotifierProvider);

    return authStateAsync.when(
      data: (authState) {
        if (!authState.isAuthenticated) {
          return const SizedBox.shrink();
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                // User info
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Signed in as'),
                  subtitle: Text(authState.user.email ?? 'Unknown'),
                ),

                const Divider(),

                // Logout button
                ListTile(
                  leading: Icon(Icons.logout, color: theme.colorScheme.error),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  onTap: () => _handleLogout(context, ref),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  /// Handle logout with confirmation
  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text(
          'Are you sure you want to sign out? Your local data will remain saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Sign out
    await ref.read(authStateNotifierProvider.notifier).signOut();

    if (!context.mounted) return;

    // Close loading dialog
    Navigator.of(context).pop();

    // Navigate to login screen
    context.go(AppRoutes.login);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed out successfully')),
    );
  }
}
