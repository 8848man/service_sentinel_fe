import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../application/providers/incident_provider.dart';
import '../../domain/repositories/incident_repository.dart';
import '../../../../core/di/repository_providers.dart';
import '../widgets/ai_analysis_view.dart';

part 'ai_analysis_screen.g.dart';

/// AI Analysis Detail Screen
///
/// Displays AI-generated root cause analysis for an incident.
/// Fetches and displays the analysis data from the repository.
///
/// Route: /incident/:id/analysis
/// Parameters: incidentId (String)
class AiAnalysisScreen extends ConsumerWidget {
  final String incidentId;

  const AiAnalysisScreen({
    super.key,
    required this.incidentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Root Cause Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Analysis',
            onPressed: () {
              // Refresh by invalidating the provider
              ref.invalidate(aiAnalysisProvider(incidentId));
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final analysisAsync = ref.watch(aiAnalysisProvider(incidentId));

          return analysisAsync.when(
            data: (analysis) => AiAnalysisView(analysis: analysis),
            loading: () => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading AI Analysis...'),
                ],
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to Load Analysis',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        ref.invalidate(aiAnalysisProvider(incidentId));
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Provider to fetch AI analysis for an incident
/// Fetches from repository and caches the result
@riverpod
Future<dynamic> aiAnalysis(AiAnalysisRef ref, String incidentId) async {
  final repository = ref.watch(incidentRepositoryProvider);
  final result = await repository.getAnalysis(int.parse(incidentId));

  if (result.isSuccess) {
    return result.dataOrNull;
  } else {
    throw result.errorOrNull ?? Exception('Unknown error');
  }
}
