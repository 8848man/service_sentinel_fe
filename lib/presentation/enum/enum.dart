enum ServiceTypeOption {
  httpApi,
  httpsApi,
  gcpEndpoint,
  firebase,
  websocket,
  grpc,
}

extension ServiceTypeOptionX on ServiceTypeOption {
  /// 서버로 전달할 값
  String get value {
    switch (this) {
      case ServiceTypeOption.httpApi:
        return 'http_api';
      case ServiceTypeOption.httpsApi:
        return 'https_api';
      case ServiceTypeOption.gcpEndpoint:
        return 'gcp_endpoint';
      case ServiceTypeOption.firebase:
        return 'firebase';
      case ServiceTypeOption.websocket:
        return 'websocket';
      case ServiceTypeOption.grpc:
        return 'grpc';
    }
  }

  // /// 화면에 보여줄 라벨 (다국어 대응 가능)
  // String label(AppLocalizations l10n) {
  //   switch (this) {
  //     case ServiceTypeOption.httpApi:
  //       return l10n.serviceTypeHttpApi;
  //     case ServiceTypeOption.httpsApi:
  //       return l10n.serviceTypeHttpsApi;
  //     case ServiceTypeOption.gcpEndpoint:
  //       return l10n.serviceTypeGcpEndpoint;
  //     case ServiceTypeOption.firebase:
  //       return l10n.serviceTypeFirebase;
  //     case ServiceTypeOption.websocket:
  //       return l10n.serviceTypeWebsocket;
  //     case ServiceTypeOption.grpc:
  //       return l10n.serviceTypeGrpc;
  //   }
  // }
}
