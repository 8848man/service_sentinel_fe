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
}
