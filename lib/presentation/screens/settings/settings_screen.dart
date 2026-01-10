import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../design_system/molecules/ss_card.dart';
import '../../design_system/organisms/ss_app_bar.dart';
import '../../providers/theme_provider.dart';
import '../../providers/locale_provider.dart';

/// Settings Screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: SSAppBar(title: l10n.settings),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Section
            Text(
              l10n.theme,
              style: AppTypography.headingMedium.copyWith(
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SSCard(
              child: Column(
                children: [
                  _buildThemeOption(
                    context,
                    ref,
                    l10n.themeWhite,
                    AppThemeMode.white,
                    themeMode,
                  ),
                  Divider(
                    height: 1,
                    color: colors.textSecondary.withOpacity(0.2),
                  ),
                  _buildThemeOption(
                    context,
                    ref,
                    l10n.themeBlack,
                    AppThemeMode.black,
                    themeMode,
                  ),
                  Divider(
                    height: 1,
                    color: colors.textSecondary.withOpacity(0.2),
                  ),
                  _buildThemeOption(
                    context,
                    ref,
                    l10n.themeBlue,
                    AppThemeMode.blue,
                    themeMode,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Language Section
            Text(
              l10n.language,
              style: AppTypography.headingMedium.copyWith(
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SSCard(
              child: Column(
                children: [
                  _buildLanguageOption(
                    context,
                    ref,
                    l10n.languageEnglish,
                    const Locale('en'),
                    currentLocale,
                  ),
                  Divider(
                    height: 1,
                    color: colors.textSecondary.withOpacity(0.2),
                  ),
                  _buildLanguageOption(
                    context,
                    ref,
                    l10n.languageKorean,
                    const Locale('ko'),
                    currentLocale,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    String title,
    AppThemeMode mode,
    AppThemeMode currentMode,
  ) {
    final colors = AppTheme.getColorsForMode(currentMode);
    final isSelected = mode == currentMode;

    return InkWell(
      onTap: () {
        ref.read(themeProvider.notifier).setTheme(mode);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.body.copyWith(
                color: colors.textPrimary,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colors.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref,
    String title,
    Locale locale,
    Locale currentLocale,
  ) {
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);
    final isSelected = locale == currentLocale;

    return InkWell(
      onTap: () {
        ref.read(localeProvider.notifier).setLocale(locale);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.body.copyWith(
                color: colors.textPrimary,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colors.primary,
              ),
          ],
        ),
      ),
    );
  }
}
