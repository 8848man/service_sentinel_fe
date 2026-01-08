import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'ServiceSentinel'**
  String get appTitle;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @incidents.
  ///
  /// In en, this message translates to:
  /// **'Incidents'**
  String get incidents;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @statusHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get statusHealthy;

  /// No description provided for @statusWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get statusWarning;

  /// No description provided for @statusDown.
  ///
  /// In en, this message translates to:
  /// **'Down'**
  String get statusDown;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @incidentOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get incidentOpen;

  /// No description provided for @incidentAcknowledged.
  ///
  /// In en, this message translates to:
  /// **'Acknowledged'**
  String get incidentAcknowledged;

  /// No description provided for @incidentResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get incidentResolved;

  /// No description provided for @severityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get severityLow;

  /// No description provided for @severityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get severityMedium;

  /// No description provided for @severityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get severityHigh;

  /// No description provided for @severityCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get severityCritical;

  /// No description provided for @serviceCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Register Service'**
  String get serviceCreateTitle;

  /// No description provided for @serviceEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Service'**
  String get serviceEditTitle;

  /// No description provided for @serviceNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Name'**
  String get serviceNameLabel;

  /// No description provided for @serviceDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get serviceDescriptionLabel;

  /// No description provided for @serviceEndpointLabel.
  ///
  /// In en, this message translates to:
  /// **'Endpoint URL'**
  String get serviceEndpointLabel;

  /// No description provided for @serviceHttpMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'HTTP Method'**
  String get serviceHttpMethodLabel;

  /// No description provided for @serviceTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceTypeLabel;

  /// No description provided for @serviceHeadersLabel.
  ///
  /// In en, this message translates to:
  /// **'Headers'**
  String get serviceHeadersLabel;

  /// No description provided for @serviceExpectedStatusCodesLabel.
  ///
  /// In en, this message translates to:
  /// **'Expected Status Codes'**
  String get serviceExpectedStatusCodesLabel;

  /// No description provided for @serviceTimeoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Timeout (seconds)'**
  String get serviceTimeoutLabel;

  /// No description provided for @serviceCheckIntervalLabel.
  ///
  /// In en, this message translates to:
  /// **'Check Interval (seconds)'**
  String get serviceCheckIntervalLabel;

  /// No description provided for @serviceFailureThresholdLabel.
  ///
  /// In en, this message translates to:
  /// **'Failure Threshold'**
  String get serviceFailureThresholdLabel;

  /// No description provided for @buttonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get buttonSave;

  /// No description provided for @buttonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get buttonCancel;

  /// No description provided for @buttonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get buttonDelete;

  /// No description provided for @buttonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get buttonEdit;

  /// No description provided for @buttonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get buttonRefresh;

  /// No description provided for @buttonCheckNow.
  ///
  /// In en, this message translates to:
  /// **'Check Now'**
  String get buttonCheckNow;

  /// No description provided for @buttonActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get buttonActivate;

  /// No description provided for @buttonDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get buttonDeactivate;

  /// No description provided for @buttonAcknowledge.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge'**
  String get buttonAcknowledge;

  /// No description provided for @buttonResolve.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get buttonResolve;

  /// No description provided for @buttonRequestAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Request AI Analysis'**
  String get buttonRequestAnalysis;

  /// No description provided for @overviewTotalServices.
  ///
  /// In en, this message translates to:
  /// **'Total Services'**
  String get overviewTotalServices;

  /// No description provided for @overviewActiveServices.
  ///
  /// In en, this message translates to:
  /// **'Active Services'**
  String get overviewActiveServices;

  /// No description provided for @overviewHealthyServices.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get overviewHealthyServices;

  /// No description provided for @overviewServicesDown.
  ///
  /// In en, this message translates to:
  /// **'Down'**
  String get overviewServicesDown;

  /// No description provided for @overviewOpenIncidents.
  ///
  /// In en, this message translates to:
  /// **'Open Incidents'**
  String get overviewOpenIncidents;

  /// No description provided for @recentChecks.
  ///
  /// In en, this message translates to:
  /// **'Recent Checks'**
  String get recentChecks;

  /// No description provided for @activeIncidents.
  ///
  /// In en, this message translates to:
  /// **'Active Incidents'**
  String get activeIncidents;

  /// No description provided for @healthCheckHistory.
  ///
  /// In en, this message translates to:
  /// **'Health Check History'**
  String get healthCheckHistory;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @uptimePercentage.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get uptimePercentage;

  /// No description provided for @avgLatency.
  ///
  /// In en, this message translates to:
  /// **'Avg Latency'**
  String get avgLatency;

  /// No description provided for @totalChecks.
  ///
  /// In en, this message translates to:
  /// **'Total Checks'**
  String get totalChecks;

  /// No description provided for @successfulChecks.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successfulChecks;

  /// No description provided for @failedChecks.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failedChecks;

  /// No description provided for @aiAnalysis.
  ///
  /// In en, this message translates to:
  /// **'AI Analysis'**
  String get aiAnalysis;

  /// No description provided for @rootCause.
  ///
  /// In en, this message translates to:
  /// **'Root Cause'**
  String get rootCause;

  /// No description provided for @debugChecklist.
  ///
  /// In en, this message translates to:
  /// **'Debug Checklist'**
  String get debugChecklist;

  /// No description provided for @suggestedActions.
  ///
  /// In en, this message translates to:
  /// **'Suggested Actions'**
  String get suggestedActions;

  /// No description provided for @confidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get confidence;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeWhite.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get themeWhite;

  /// No description provided for @themeBlack.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get themeBlack;

  /// No description provided for @themeBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get themeBlue;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageKorean.
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get languageKorean;

  /// No description provided for @emptyServices.
  ///
  /// In en, this message translates to:
  /// **'No services yet'**
  String get emptyServices;

  /// No description provided for @emptyServicesDescription.
  ///
  /// In en, this message translates to:
  /// **'Add your first service to start monitoring'**
  String get emptyServicesDescription;

  /// No description provided for @emptyIncidents.
  ///
  /// In en, this message translates to:
  /// **'No incidents'**
  String get emptyIncidents;

  /// No description provided for @emptyIncidentsDescription.
  ///
  /// In en, this message translates to:
  /// **'All services are healthy'**
  String get emptyIncidentsDescription;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorLoadingData;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection'**
  String get errorNetwork;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later'**
  String get errorServer;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @pullToRefresh.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get pullToRefresh;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated'**
  String get lastUpdated;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
