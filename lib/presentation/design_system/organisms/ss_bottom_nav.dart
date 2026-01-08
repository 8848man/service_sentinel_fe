import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../presentation/providers/theme_provider.dart';
import '../../../core/localization/l10n/app_localizations.dart';

/// Bottom navigation item
class SSBottomNavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;

  const SSBottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}

/// ServiceSentinel Bottom Navigation Component
///
/// Bottom navigation bar for mobile app navigation.
class SSBottomNav extends ConsumerWidget {
  final int currentIndex;
  final Function(int) onTap;

  const SSBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final colors = AppTheme.getColorsForMode(themeMode);

    final items = _getNavigationItems(l10n);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: colors.surface,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: items
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                activeIcon: Icon(item.activeIcon ?? item.icon),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }

  List<SSBottomNavItem> _getNavigationItems(AppLocalizations l10n) {
    return [
      SSBottomNavItem(
        label: l10n.dashboard,
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
      ),
      SSBottomNavItem(
        label: l10n.services,
        icon: Icons.dns_outlined,
        activeIcon: Icons.dns,
      ),
      SSBottomNavItem(
        label: l10n.incidents,
        icon: Icons.warning_amber_outlined,
        activeIcon: Icons.warning_amber,
      ),
      SSBottomNavItem(
        label: l10n.settings,
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
      ),
    ];
  }
}
