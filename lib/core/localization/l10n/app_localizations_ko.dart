// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '서비스센티널';

  @override
  String get dashboard => '대시보드';

  @override
  String get services => '서비스';

  @override
  String get incidents => '장애';

  @override
  String get settings => '설정';

  @override
  String get statusHealthy => '정상';

  @override
  String get statusWarning => '경고';

  @override
  String get statusDown => '중단';

  @override
  String get statusUnknown => '알 수 없음';

  @override
  String get incidentOpen => '열림';

  @override
  String get incidentAcknowledged => '확인됨';

  @override
  String get incidentResolved => '해결됨';

  @override
  String get severityLow => '낮음';

  @override
  String get severityMedium => '중간';

  @override
  String get severityHigh => '높음';

  @override
  String get severityCritical => '심각';

  @override
  String get serviceCreateTitle => '서비스 등록';

  @override
  String get serviceEditTitle => '서비스 수정';

  @override
  String get serviceNameLabel => '서비스 이름';

  @override
  String get serviceDescriptionLabel => '설명';

  @override
  String get serviceEndpointLabel => '엔드포인트 URL';

  @override
  String get serviceHttpMethodLabel => 'HTTP 메서드';

  @override
  String get serviceTypeLabel => '서비스 유형';

  @override
  String get serviceHeadersLabel => '헤더';

  @override
  String get serviceExpectedStatusCodesLabel => '예상 상태 코드';

  @override
  String get serviceTimeoutLabel => '타임아웃 (초)';

  @override
  String get serviceCheckIntervalLabel => '체크 간격 (초)';

  @override
  String get serviceFailureThresholdLabel => '실패 임계값';

  @override
  String get buttonSave => '저장';

  @override
  String get buttonCancel => '취소';

  @override
  String get buttonDelete => '삭제';

  @override
  String get buttonEdit => '수정';

  @override
  String get buttonRefresh => '새로고침';

  @override
  String get buttonCheckNow => '지금 확인';

  @override
  String get buttonActivate => '활성화';

  @override
  String get buttonDeactivate => '비활성화';

  @override
  String get buttonAcknowledge => '확인';

  @override
  String get buttonResolve => '해결';

  @override
  String get buttonRequestAnalysis => 'AI 분석 요청';

  @override
  String get overviewTotalServices => '전체 서비스';

  @override
  String get overviewActiveServices => '활성 서비스';

  @override
  String get overviewHealthyServices => '정상';

  @override
  String get overviewServicesDown => '중단';

  @override
  String get overviewOpenIncidents => '진행 중인 장애';

  @override
  String get recentChecks => '최근 체크';

  @override
  String get activeIncidents => '활성 장애';

  @override
  String get healthCheckHistory => '상태 체크 기록';

  @override
  String get statistics => '통계';

  @override
  String get uptimePercentage => '가동률';

  @override
  String get avgLatency => '평균 지연시간';

  @override
  String get totalChecks => '총 체크 수';

  @override
  String get successfulChecks => '성공';

  @override
  String get failedChecks => '실패';

  @override
  String get aiAnalysis => 'AI 분석';

  @override
  String get rootCause => '근본 원인';

  @override
  String get debugChecklist => '디버그 체크리스트';

  @override
  String get suggestedActions => '제안 조치';

  @override
  String get confidence => '신뢰도';

  @override
  String get theme => '테마';

  @override
  String get themeWhite => '화이트';

  @override
  String get themeBlack => '블랙';

  @override
  String get themeBlue => '블루';

  @override
  String get language => '언어';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKorean => '한국어';

  @override
  String get emptyServices => '서비스가 없습니다';

  @override
  String get emptyServicesDescription => '첫 번째 서비스를 추가하여 모니터링을 시작하세요';

  @override
  String get emptyIncidents => '장애가 없습니다';

  @override
  String get emptyIncidentsDescription => '모든 서비스가 정상입니다';

  @override
  String get errorLoadingData => '데이터 로딩 오류';

  @override
  String get errorNetwork => '네트워크 오류. 연결을 확인하세요';

  @override
  String get errorServer => '서버 오류. 나중에 다시 시도하세요';

  @override
  String get loading => '로딩 중...';

  @override
  String get pullToRefresh => '당겨서 새로고침';

  @override
  String get lastUpdated => '마지막 업데이트';

  @override
  String get serviceDetail => '서비스 상세';

  @override
  String get checkNow => '지금 확인';

  @override
  String get edit => '수정';

  @override
  String get delete => '삭제';

  @override
  String get cancel => '취소';

  @override
  String get deleteService => '서비스 삭제';

  @override
  String get deleteServiceConfirmTitle => '서비스를 삭제하시겠습니까?';

  @override
  String get deleteServiceConfirmMessage =>
      '이 서비스를 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.';

  @override
  String get deleteServiceFailed => '서비스 삭제 실패';

  @override
  String get noHealthChecks => '상태 체크 기록이 없습니다';

  @override
  String get healthCheckTriggered => '상태 체크가 성공적으로 시작되었습니다';

  @override
  String get healthCheckFailed => '상태 체크 시작 실패';

  @override
  String get serviceActive => '활성';

  @override
  String get serviceInactive => '비활성';

  @override
  String get serviceCreate => '서비스 생성';

  @override
  String get serviceCreatedSuccess => '서비스가 성공적으로 생성되었습니다';

  @override
  String get serviceUpdatedSuccess => '서비스가 성공적으로 수정되었습니다';

  @override
  String get fieldRequired => '이 필드는 필수입니다';

  @override
  String get invalidUrl => 'http:// 또는 https://로 시작하는 유효한 URL을 입력하세요';

  @override
  String get invalidNumber => '유효한 양수를 입력하세요';

  @override
  String get failureThresholdHelp => '장애 생성 전 연속 실패 횟수';

  @override
  String get all => '전체';

  @override
  String get status => '상태';

  @override
  String get severity => '심각도';

  @override
  String get incidentDetail => '장애 상세';

  @override
  String get detectedAt => '감지 시각';

  @override
  String get resolvedAt => '해결 시각';

  @override
  String get acknowledgedAt => '확인 시각';

  @override
  String get consecutiveFailures => '연속 실패 횟수';

  @override
  String get totalAffectedChecks => '전체 영향받은 체크 수';

  @override
  String get incidentAcknowledge => '확인';

  @override
  String get incidentResolve => '해결';

  @override
  String get incidentRequestAnalysis => 'AI 분석 요청';

  @override
  String get incidentAcknowledged_success => '장애가 성공적으로 확인되었습니다';

  @override
  String get incidentResolved_success => '장애가 성공적으로 해결되었습니다';

  @override
  String get aiAnalysisRequested => 'AI 분석이 성공적으로 요청되었습니다';

  @override
  String get aiAnalysisFailed => 'AI 분석 요청 실패';

  @override
  String get noAiAnalysis => '아직 AI 분석을 사용할 수 없습니다';
}
