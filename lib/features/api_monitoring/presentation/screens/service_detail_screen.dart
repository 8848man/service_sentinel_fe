import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../application/providers/service_provider.dart';
import '../widgets/service_detail_body.dart';

/// Service Detail Screen
///
/// Displays detailed information about a specific monitored service/API.
/// This screen is layout-only; all provider consumption happens in child widgets.
///
/// Route: /service/:id
/// Parameters: serviceId (String)
class ServiceDetailScreen extends ConsumerWidget {
  final String serviceId;

  const ServiceDetailScreen({
    super.key,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Run Health Check',
            onPressed: () {
              // TODO: Trigger manual health check
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Manual check feature coming soon')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Service',
            onPressed: () {
              // TODO: Navigate to service edit screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit feature coming soon')),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteConfirmation(context, ref);
              } else if (value == 'deactivate') {
                // TODO: Deactivate service
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Deactivate feature coming soon')),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'deactivate',
                child: Row(
                  children: [
                    Icon(Icons.pause),
                    SizedBox(width: 8),
                    Text('Deactivate'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ServiceDetailBody(serviceId: serviceId),
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service'),
        content: const Text(
          'Are you sure you want to delete this service? This will remove all monitoring data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
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

    // Delete service
    final useCase = ref.read(deleteServiceProvider);
    final result = await useCase.execute(int.parse(serviceId));

    if (!context.mounted) return;

    // Close loading dialog
    Navigator.of(context).pop();

    if (result.isSuccess) {
      // Invalidate services list
      ref.invalidate(servicesProvider);

      // Navigate back
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to delete service: ${result.errorOrNull?.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
