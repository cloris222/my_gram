import 'package:flutter/cupertino.dart';

class UserTokenNotifier extends ChangeNotifier {
  String _userToken = ''; // 使用者Token (空值：未登入)

  String get userToken => _userToken;

  bool get isLogin => _userToken.isNotEmpty;

  set setUserToken(String value) {
    _userToken = value;
    notifyListeners();
  }

}