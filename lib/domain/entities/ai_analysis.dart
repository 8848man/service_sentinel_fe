/// Suggested Action entity
class SuggestedAction {
  final String action;
  final String priority;
  final String estimatedImpact;

  const SuggestedAction({
    required this.action,
    required this.priority,
    required this.estimatedImpact,
  });
}

/// AI Analysis entity representing AI-generated incident analysis
class AIAnalysis {
  final int id;
  final int incidentId;
  final String modelUsed;
  final int promptTokens;
  final int completionTokens;
  final double totalCostUsd;
  final String rootCauseHypothesis;
  final double confidenceScore;
  final List<String> debugChecklist;
  final List<SuggestedAction> suggestedActions;
  final List<String> relatedErrorPatterns;
  final DateTime analyzedAt;
  final int analysisDurationMs;

  const AIAnalysis({
    required this.id,
    required this.incidentId,
    required this.modelUsed,
    required this.promptTokens,
    required this.completionTokens,
    required this.totalCostUsd,
    required this.rootCauseHypothesis,
    required this.confidenceScore,
    required this.debugChecklist,
    required this.suggestedActions,
    required this.relatedErrorPatterns,
    required this.analyzedAt,
    required this.analysisDurationMs,
  });

  AIAnalysis copyWith({
    int? id,
    int? incidentId,
    String? modelUsed,
    int? promptTokens,
    int? completionTokens,
    double? totalCostUsd,
    String? rootCauseHypothesis,
    double? confidenceScore,
    List<String>? debugChecklist,
    List<SuggestedAction>? suggestedActions,
    List<String>? relatedErrorPatterns,
    DateTime? analyzedAt,
    int? analysisDurationMs,
  }) {
    return AIAnalysis(
      id: id ?? this.id,
      incidentId: incidentId ?? this.incidentId,
      modelUsed: modelUsed ?? this.modelUsed,
      promptTokens: promptTokens ?? this.promptTokens,
      completionTokens: completionTokens ?? this.completionTokens,
      totalCostUsd: totalCostUsd ?? this.totalCostUsd,
      rootCauseHypothesis: rootCauseHypothesis ?? this.rootCauseHypothesis,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      debugChecklist: debugChecklist ?? this.debugChecklist,
      suggestedActions: suggestedActions ?? this.suggestedActions,
      relatedErrorPatterns: relatedErrorPatterns ?? this.relatedErrorPatterns,
      analyzedAt: analyzedAt ?? this.analyzedAt,
      analysisDurationMs: analysisDurationMs ?? this.analysisDurationMs,
    );
  }
}
