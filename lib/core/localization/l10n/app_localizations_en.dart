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
}
