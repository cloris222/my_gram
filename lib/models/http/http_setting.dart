class HttpSetting {
  HttpSetting._();

  ///MARK: Release Setting
  // static const String appUrl = "https://mygram.ai/gateway/app";
  // static const String commonUrl = "https://mygram.ai/gateway/common";
  // static const String socketUrl = 'wss://mygram.ai/gateway/websocket/connect';
  // static const String postKey = "RSA加密KEY";
  // static const bool debugMode = false;

  ///MARK: develop Setting
  static const String appUrl = "https://test.mygram.ai/gateway/app";
  static const String chatUrl = "https://test.mygram.ai/gateway/chat";
  static const String commonUrl = "https://test.mygram.ai/gateway/common";
  static const String socketUrl = 'wss://test.mygram.ai/gateway/websocket/connect';
  // static const String msgUrl = "http://test.mygram.ai/gateway";
  static const String postKey = "RSA加密KEY";
  static const bool debugMode = true;

  ///其他參數-----
  static const bool needRsaEncode = false;

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
