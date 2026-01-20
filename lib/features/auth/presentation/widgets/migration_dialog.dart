import 'package:flutter/material.dart';

/// Migration dialog - Shown when guest user logs in with local projects
/// Blocking dialog that allows user to:
/// 1. Migrate local projects to server
/// 2. Skip migration (local projects remain local-only)
///
/// Returns: true if user wants to migrate, false if user wants to skip
class MigrationDialog extends StatelessWidget {
  const MigrationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: Icon(
        Icons.cloud_upload_outlined,
        size: 64,
        color: theme.colorScheme.primary,
      ),
      title: const Text('Migrate Local Projects?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You have local projects stored on this device. Would you like to migrate them to the cloud?',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
            context,
            Icons.cloud_done,
            'Cloud Sync',
            'Access your projects from any device',
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            context,
            Icons.backup,
            'Backup',
            'Your data is safely backed up',
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            context,
            Icons.group,
            'Team Collaboration',
            'Share projects with team members',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Skip for Now'),
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.cloud_upload),
          label: const Text('Migrate Now'),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
