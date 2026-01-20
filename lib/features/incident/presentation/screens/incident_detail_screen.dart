import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/incident_provider.dart';
import '../widgets/incident_detail_body.dart';

/// Incident Detail Screen
///
/// Displays detailed information about a specific incident.
/// Provides actions to acknowledge, resolve, and request AI analysis.
///
/// Route: /incident/:id
/// Parameters: incidentId (String)
class IncidentDetailScreen extends ConsumerWidget {
  final String incidentId;

  const IncidentDetailScreen({
    super.key,
    required this.incidentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            tooltip: 'Request AI Analysis',
            onPressed: () => _handleRequestAnalysis(context, ref),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'acknowledge') {
                _handleAcknowledge(context, ref);
              } else if (value == 'resolve') {
                _handleResolve(context, ref);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'acknowledge',
                child: Row(
                  children: [
                    Icon(Icons.check),
                    SizedBox(width: 8),
                    Text('Acknowledge'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'resolve',
                child: Row(
                  children: [
                    Icon(Icons.done_all, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Resolve'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: IncidentDetailBody(incidentId: incidentId),
    );
  }

  /// Handle acknowledge incident action
  Future<void> _handleAcknowledge(BuildContext context, WidgetRef ref) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Acknowledge incident
    final useCase = ref.read(acknowledgeIncidentProvider);
    final result = await useCase.execute(int.parse(incidentId));

    if (!context.mounted) return;

    // Close loading dialog
    Navigator.of(context).pop();

    if (result.isSuccess) {
      // Invalidate incidents list to refresh
      ref.invalidate(incidentsProvider);
      ref.invalidate(incidentByIdProvider(incidentId));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incident acknowledged successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to acknowledge: ${result.errorOrNull?.message}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Handle resolve incident action
  Future<void> _handleResolve(BuildContext context, WidgetRef ref) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resolve Incident'),
        content: const Text(
          'Are you sure you want to mark this incident as resolved?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Resolve'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Resolve incident
    final useCase = ref.read(resolveIncidentProvider);
    final result = await useCase.execute(int.parse(incidentId));

    if (!context.mounted) return;

    // Close loading dialog
    Navigator.of(context).pop();

    if (result.isSuccess) {
      // Invalidate incidents list to refresh
      ref.invalidate(incidentsProvider);
      ref.invalidate(incidentByIdProvider(incidentId));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incident resolved successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resolve: ${result.errorOrNull?.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Handle request AI analysis action
  Future<void> _handleRequestAnalysis(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request AI Analysis'),
        content: const Text(
          'Request AI to analyze this incident and provide root cause analysis, '
          'debug steps, and suggested actions?\n\n'
          'Analysis may take a few moments to complete.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Request Analysis'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Request AI analysis
    final useCase = ref.read(requestAiAnalysisProvider);
    final result = await useCase.execute(int.parse(incidentId));

    if (!context.mounted) return;

    // Close loading dialog
    Navigator.of(context).pop();

    if (result.isSuccess) {
      // Invalidate incidents list to refresh
      ref.invalidate(incidentsProvider);
      ref.invalidate(incidentByIdProvider(incidentId));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'AI analysis requested. It will be available shortly.',
          ),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to request analysis: ${result.errorOrNull?.message}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
