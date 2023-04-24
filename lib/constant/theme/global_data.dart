import 'package:flutter/cupertino.dart';
import '../../models/http_setting.dart';
import '../enum/app_param_enum.dart';

class GlobalData {
  GlobalData._();

  static String urlPrefix = '';

  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static bool firstLaunch = true;

  static AppNavigationBarType mainBottomType = AppNavigationBarType.typePair;

  /// USER
  static String userToken = '';
  static String userMemberId = '';

  /// RSA Public Key
  static String publicKey = '';
  static String apiSecretKey = '';
  static String userId = '';

  static printLog(String? logMessage) {
    if (HttpSetting.debugMode) {
      debugPrint(logMessage);
    }
  }
}
