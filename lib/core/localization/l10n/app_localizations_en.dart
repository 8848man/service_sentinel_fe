// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ServiceSentinel';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get services => 'Services';

  @override
  String get incidents => 'Incidents';

  @override
  String get settings => 'Settings';

  @override
  String get statusHealthy => 'Healthy';

  @override
  String get statusWarning => 'Warning';

  @override
  String get statusDown => 'Down';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get incidentOpen => 'Open';

  @override
  String get incidentAcknowledged => 'Acknowledged';

  @override
  String get incidentResolved => 'Resolved';

  @override
  String get severityLow => 'Low';

  @override
  String get severityMedium => 'Medium';

  @override
  String get severityHigh => 'High';

  @override
  String get severityCritical => 'Critical';

  @override
  String get serviceCreateTitle => 'Register Service';

  @override
  String get serviceEditTitle => 'Edit Service';

  @override
  String get serviceNameLabel => 'Service Name';

  @override
  String get serviceDescriptionLabel => 'Description';

  @override
  String get serviceEndpointLabel => 'Endpoint URL';

  @override
  String get serviceHttpMethodLabel => 'HTTP Method';

  @override
  String get serviceTypeLabel => 'Service Type';

  @override
  String get serviceHeadersLabel => 'Headers';

  @override
  String get serviceExpectedStatusCodesLabel => 'Expected Status Codes';

  @override
  String get serviceTimeoutLabel => 'Timeout (seconds)';

  @override
  String get serviceCheckIntervalLabel => 'Check Interval (seconds)';

  @override
  String get serviceFailureThresholdLabel => 'Failure Threshold';

  @override
  String get buttonSave => 'Save';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonDelete => 'Delete';

  @override
  String get buttonEdit => 'Edit';

  @override
  String get buttonRefresh => 'Refresh';

  @override
  String get buttonCheckNow => 'Check Now';

  @override
  String get buttonActivate => 'Activate';

  @override
  String get buttonDeactivate => 'Deactivate';

  @override
  String get buttonAcknowledge => 'Acknowledge';

  @override
  String get buttonResolve => 'Resolve';

  @override
  String get buttonRequestAnalysis => 'Request AI Analysis';

  @override
  String get overviewTotalServices => 'Total Services';

  @override
  String get overviewActiveServices => 'Active Services';

  @override
  String get overviewHealthyServices => 'Healthy';

  @override
  String get overviewServicesDown => 'Down';

  @override
  String get overviewOpenIncidents => 'Open Incidents';

  @override
  String get recentChecks => 'Recent Checks';

  @override
  String get activeIncidents => 'Active Incidents';

  @override
  String get healthCheckHistory => 'Health Check History';

  @override
  String get statistics => 'Statistics';

  @override
  String get uptimePercentage => 'Uptime';

  @override
  String get avgLatency => 'Avg Latency';

  @override
  String get totalChecks => 'Total Checks';

  @override
  String get successfulChecks => 'Successful';

  @override
  String get failedChecks => 'Failed';

  @override
  String get aiAnalysis => 'AI Analysis';

  @override
  String get rootCause => 'Root Cause';

  @override
  String get debugChecklist => 'Debug Checklist';

  @override
  String get suggestedActions => 'Suggested Actions';

  @override
  String get confidence => 'Confidence';

  @override
  String get theme => 'Theme';

  @override
  String get themeWhite => 'White';

  @override
  String get themeBlack => 'Black';

  @override
  String get themeBlue => 'Blue';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKorean => '한국어';

  @override
  String get emptyServices => 'No services yet';

  @override
  String get emptyServicesDescription =>
      'Add your first service to start monitoring';

  @override
  String get emptyIncidents => 'No incidents';

  @override
  String get emptyIncidentsDescription => 'All services are healthy';

  @override
  String get errorLoadingData => 'Error loading data';

  @override
  String get errorNetwork => 'Network error. Please check your connection';

  @override
  String get errorServer => 'Server error. Please try again later';

  @override
  String get loading => 'Loading...';

  @override
  String get pullToRefresh => 'Pull to refresh';

  @override
  String get lastUpdated => 'Last updated';

  @override
  String get serviceDetail => 'Service Detail';

  @override
  String get checkNow => 'Check Now';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteService => 'Delete Service';

  @override
  String get deleteServiceConfirmTitle => 'Delete Service?';

  @override
  String get deleteServiceConfirmMessage =>
      'Are you sure you want to delete this service? This action cannot be undone.';

  @override
  String get deleteServiceFailed => 'Failed to delete service';

  @override
  String get noHealthChecks => 'No health checks yet';

  @override
  String get healthCheckTriggered => 'Health check triggered successfully';

  @override
  String get healthCheckFailed => 'Failed to trigger health check';

  @override
  String get serviceActive => 'Active';

  @override
  String get serviceInactive => 'Inactive';

  @override
  String get serviceCreate => 'Create Service';

  @override
  String get serviceCreatedSuccess => 'Service created successfully';

  @override
  String get serviceUpdatedSuccess => 'Service updated successfully';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidUrl =>
      'Please enter a valid URL starting with http:// or https://';

  @override
  String get invalidNumber => 'Please enter a valid positive number';

  @override
  String get failureThresholdHelp =>
      'Number of consecutive failures before creating an incident';

  @override
  String get all => 'All';

  @override
  String get status => 'Status';

  @override
  String get severity => 'Severity';

  @override
  String get incidentDetail => 'Incident Detail';

  @override
  String get detectedAt => 'Detected At';

  @override
  String get resolvedAt => 'Resolved At';

  @override
  String get acknowledgedAt => 'Acknowledged At';

  @override
  String get consecutiveFailures => 'Consecutive Failures';

  @override
  String get totalAffectedChecks => 'Total Affected Checks';

  @override
  String get incidentAcknowledge => 'Acknowledge';

  @override
  String get incidentResolve => 'Resolve';

  @override
  String get incidentRequestAnalysis => 'Request AI Analysis';

  @override
  String get incidentAcknowledged_success =>
      'Incident acknowledged successfully';

  @override
  String get incidentResolved_success => 'Incident resolved successfully';

  @override
  String get aiAnalysisRequested => 'AI analysis requested successfully';

  @override
  String get aiAnalysisFailed => 'Failed to request AI analysis';

  @override
  String get noAiAnalysis => 'No AI analysis available yet';
}
