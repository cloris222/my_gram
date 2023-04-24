class HttpSetting {
  HttpSetting._();

  ///MARK: Release Setting
  // static const String appUrl = "https://locas.release/gateway/app";
  // static const String commonUrl = "https://locas.release/gateway/common";
  // static const String postKey = "RSA加密KEY";
  // static const bool debugMode = false;

  ///MARK: develop Setting
  static const String appUrl = "https://locas.release/gateway/app";
  static const String commonUrl = "https://locas.release/gateway/common";
  static const String postKey = "RSA加密KEY";
  static const bool debugMode = true;

  ///其他參數-----
  static const bool needRsaEncode = true;

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
