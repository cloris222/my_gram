import 'package:base_project/views/main_screen.dart';
import 'package:flutter/material.dart';

import '../../views/login/login_main_page.dart';
import 'global_data.dart';

@immutable //不可變物件
class AppRoutes {
  const AppRoutes._();

  /// MARK: 靜態Router
  static Map<String, WidgetBuilder> define() {
    return {
      "/AppMain": (context) => const MainScreen(),
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

  static pushRemoveMain(BuildContext context) {
    _checkRoutePath(context, "/AppMain",removeUntil: true);
  }

  static pushLogin(BuildContext context, {bool removeUntil = true}) {
    _checkRoutePath(context, "/AppLogin", removeUntil: removeUntil);
  }
}
