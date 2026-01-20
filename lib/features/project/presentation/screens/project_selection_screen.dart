import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../auth/application/providers/auth_provider.dart';
import '../widgets/project_list_section.dart';
import '../widgets/project_header_section.dart';

/// Project selection screen - Choose or create a project
/// Layout only. Provider consumption happens in section widgets.
///
/// Observes:
/// - authStateNotifierProvider (for user info and logout)
/// - projectsProvider (via ProjectListSection)
///
/// Features:
/// - Display all projects
/// - Create new project
/// - Select project and navigate to main
/// - Handle source of truth (Local vs Server based on auth state)
class ProjectSelectionScreen extends StatelessWidget {
  const ProjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.translate('app.title')),
        actions: [
          // Logout action (ConsumerWidget)
          Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authStateNotifierProvider).value;
              final isAuthenticated = authState?.isAuthenticated ?? false;

              if (!isAuthenticated) {
                return const SizedBox.shrink();
              }

              return IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Sign Out',
                onPressed: () async {
                  // Call authStateNotifierProvider.signOut()
                  await ref.read(authStateNotifierProvider.notifier).signOut();
                },
              );
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section (shows user info and mode)
            ProjectHeaderSection(),

            SizedBox(height: 24),

            // Project list section (ConsumerWidget)
            ProjectListSection(),
          ],
        ),
      ),
    );
  }
}
