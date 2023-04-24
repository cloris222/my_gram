import 'package:flutter/material.dart';

import '../../views/login/login_main_page.dart';
import '../../views/web_recaptcha_page.dart';
import 'global_data.dart';

@immutable //不可變物件
class AppRoutes {
  const AppRoutes._();

  /// MARK: 靜態Router
  static Map<String, WidgetBuilder> define() {
    return {
      "/WebRecaptchaPage": (context) => const WebRecaptchaPage(),
      "/AppLogin": (context) => const LoginMainPage(),
    };
  }

  static _checkRoutePath(BuildContext context, String routePath,
      {bool removeUntil = false}) {
    String? path = ModalRoute.of(context)?.settings.name;
    GlobalData.printLog("_checkRoutePath:$path");
    if (path != null) {
      /// 路徑相同時，不跳轉
      if (routePath.compareTo(path) == 0) {
        return;
      }
    }
    if (removeUntil) {
      Navigator.pushNamedAndRemoveUntil(context, routePath, (route) => false);
    } else {
      Navigator.pushNamed(context, routePath);
    }
  }

  ///推到WebRecaptchaPage
  static pushWebRecaptchaPage(BuildContext context) {
    _checkRoutePath(context, "/WebRecaptchaPage");
  }

  /// 設定頁面
  static pushRemoveLogin(BuildContext context) {
    _checkRoutePath(context, "/AppLogin",removeUntil: true);
  }
}
