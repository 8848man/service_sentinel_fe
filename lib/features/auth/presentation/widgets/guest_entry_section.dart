import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../application/providers/auth_provider.dart';

/// Guest entry section - Smallest UI unit consuming Riverpod provider
/// Allows users to enter as guest (local-only mode)
///
/// Consumes: authStateNotifierProvider
/// Side effect: Navigates to project selection after guest entry
class GuestEntrySection extends ConsumerWidget {
  const GuestEntrySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person_outline,
              size: 48,
              color: theme.colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Continue as Guest',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Use local storage only. Your data stays on this device.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Guest mode is already the default state
                // Simply navigate to project selection
                context.go(AppRoutes.projectSelection);
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Enter as Guest'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
