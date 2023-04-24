import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/theme/global_data.dart';

class AppSharedPreferences {
  AppSharedPreferences._();

  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> checkKey(String key, {SharedPreferences? pref}) async {
    pref ??= await _getPreferences();
    return pref.containsKey(key);
  }

  static Future<void> setString(String key, String value) async {
    SharedPreferences pref = await _getPreferences();
    await pref.setString(key, value);
  }

  static Future<String> getString(String key,
      {String defaultValue = ''}) async {
    SharedPreferences pref = await _getPreferences();
    if (await checkKey(key, pref: pref)) {
      return pref.getString(key)!;
    } else {
      return defaultValue;
    }
  }

  static Future<void> setStringList(String key, List<String> value) async {
    SharedPreferences pref = await _getPreferences();
    await pref.setStringList(key, value);
  }

  static Future<List<String>> getStringList(String key,
      {List<String> defaultValue = const []}) async {
    SharedPreferences pref = await _getPreferences();
    if (await checkKey(key, pref: pref)) {
      return pref.getStringList(key)!;
    } else {
      return defaultValue;
    }
  }

  static Future<void> setDouble(String key, double value) async {
    SharedPreferences pref = await _getPreferences();
    await pref.setDouble(key, value);
  }

  static Future<double> getDouble(String key, {double defaultValue = 0}) async {
    SharedPreferences pref = await _getPreferences();
    if (await checkKey(key, pref: pref)) {
      return pref.getDouble(key)!;
    } else {
      return defaultValue;
    }
  }

  static Future<void> setBool(String key, bool value) async {
    SharedPreferences pref = await _getPreferences();
    await pref.setBool(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    SharedPreferences pref = await _getPreferences();
    if (await checkKey(key, pref: pref)) {
      return pref.getBool(key)!;
    } else {
      return defaultValue;
    }
  }

  static Future<void> setJson(String key, dynamic value) async {
    await setString(key, json.encode(value).toString());
  }

  static Future<dynamic> getJson(String key) async {
    SharedPreferences pref = await _getPreferences();
    if (await checkKey(key, pref: pref)) {
      return json.decode(pref.getString(key)!);
    } else {
      return null;
    }
  }

  ///MARK: ----使用者設定 start ----

  static Future<void> setLanguage(String lang) async {
    await setString("Lang", lang);
  }

  static Future<String> getLanguage() async {
    return await getString("Lang");
  }

  static Future<void> setMemberID(String id) async {
    await setString("MemberID", id);
  }

  static Future<String> getMemberID() async {
    return await getString("MemberID");
  }

  static Future<void> setToken(String token) async {
    await setString('Token', token);
  }

  static Future<String> getToken() async {
    return await getString("Token");
  }

  /// MARK: 判斷是否登入過
  static Future<void> setLogIn(bool isLogIn) async {
    await setBool("LogIn", isLogIn);
  }

  static Future<bool> getLogIn() async {
    return await getBool("LogIn");
  }

  static Future<void> printAll() async {
    GlobalData.printLog('pref_ printAll------');
    GlobalData.printLog('pref_getLanguage:${await getLanguage()}');
    GlobalData.printLog('pref_getMemberID:${await getMemberID()}');
    GlobalData.printLog('pref_getToken:${await getToken()}');
    GlobalData.printLog('pref_getLogIn:${await getLogIn()}');
  }

  ///清除使用者相關的暫存資料
  static Future<void> clearUserTmpValue() async {
    SharedPreferences pref = await _getPreferences();
    pref.getKeys().forEach((key) {
      ///MARK: 如果包含_tmp 代表需要被刪除
      if (key.contains("_tmp")) {
        pref.remove(key);
      }
    });
  }


///MARK: ----使用者設定 end ----

///MARK: ----暫存相關 start ----

///MARK: ----暫存相關 end ----
}
