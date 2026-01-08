import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../presentation/providers/theme_provider.dart';
import '../../../presentation/providers/locale_provider.dart';
import '../../../core/localization/l10n/app_localizations.dart';

/// ServiceSentinel App Bar Component
///
/// Custom app bar with theme and language toggles.
class SSAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showThemeToggle;
  final bool showLanguageToggle;
  final Widget? leading;

  const SSAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showThemeToggle = true,
    this.showLanguageToggle = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    return AppBar(
      backgroundColor: colors.surface,
      foregroundColor: colors.textPrimary,
      elevation: 0,
      leading: leading,
      title: Text(
        title,
        style: AppTypography.headingMedium.copyWith(
          color: colors.textPrimary,
        ),
      ),
      actions: [
        ...?actions,
        if (showThemeToggle)
          IconButton(
            icon: Icon(_getThemeIcon(themeMode)),
            tooltip: l10n.theme,
            onPressed: () {
              ref.read(themeProvider.notifier).cycleTheme();
            },
          ),
        if (showLanguageToggle)
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: l10n.language,
            onPressed: () {
              ref.read(localeProvider.notifier).toggleLocale();
            },
          ),
      ],
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
