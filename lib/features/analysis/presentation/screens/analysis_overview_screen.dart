import 'package:flutter/material.dart';
import '../widgets/analysis_overview_body.dart';

/// Analysis Overview Screen
///
/// Displays an overview of AI analysis results across all incidents.
/// This screen is layout-only; all provider consumption happens in child widgets.
///
/// Route: /analysis or /main/analysis
class AnalysisOverviewScreen extends StatelessWidget {
  const AnalysisOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Analysis Overview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Analysis',
            onPressed: () {
              // TODO: Refresh analysis data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Refresh feature coming soon')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter',
            onPressed: () {
              // TODO: Show filter dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: const AnalysisOverviewBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Request bulk AI analysis
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bulk analysis request coming soon')),
          );
        },
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Request Analysis'),
      ),
    );
  }
}
