import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/theme/global_data.dart';

class AppSharedPreferences {
  AppSharedPreferences._();

  static Future<bool> checkKey(String key, {required bool needEncryption, SharedPreferences? pref}) async {
    if (needEncryption) {
      return await _checkEncryptionKey(key);
    } else {
      return await _checkNormalKey(key, pref: pref);
    }
  }

  ///MARK: ----非加密pref start ----

  static Future<SharedPreferences> _getNormalPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> _checkNormalKey(String key, {SharedPreferences? pref}) async {
    pref ??= await _getNormalPreferences();
    return pref.containsKey(key);
  }

  ///MARK: ----非加密pref end ----

  ///MARK: ----加密pref start ----

  static Future<FlutterSecureStorage> _getEncryptionPreferences() async {
    return FlutterSecureStorage(aOptions: _androidOptions);
  }

  static AndroidOptions get _androidOptions => const AndroidOptions(encryptedSharedPreferences: true);

  static Future<bool> _checkEncryptionKey(String key, {FlutterSecureStorage? pref}) async {
    pref ??= await _getEncryptionPreferences();
    return pref.containsKey(key: key);
  }

  static Future<void> _setEncryptionValue(String key, String value) async {
    FlutterSecureStorage pref = await _getEncryptionPreferences();
    await pref.write(key: key, value: value);
  }

  static Future<String> _getEncryptionValue(String key, {required String defaultValue}) async {
    FlutterSecureStorage pref = await _getEncryptionPreferences();
    if (await _checkEncryptionKey(key, pref: pref)) {
      return (await pref.read(key: key)) as String;
    } else {
      return defaultValue;
    }
  }

  ///MARK: ----加密pref end ----

  ///MARK: ----存取值 start ----

  static Future<void> setString(String key, String value, {required bool needEncryption}) async {
    if (needEncryption) {
      await _setEncryptionValue(key, value);
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      await pref.setString(key, value);
    }
  }

  static Future<String> getString(String key, {String defaultValue = '', required bool needEncryption}) async {
    if (needEncryption) {
      return (await _getEncryptionValue(key, defaultValue: defaultValue));
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      if (await _checkNormalKey(key, pref: pref)) {
        return pref.getString(key)!;
      } else {
        return defaultValue;
      }
    }
  }

  static Future<void> setStringList(String key, List<String> value, {required bool needEncryption}) async {
    if (needEncryption) {
      await _setEncryptionValue(key, json.encode(value));
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      await pref.setStringList(key, value);
    }
  }

  static Future<List<String>> getStringList(String key,
      {List<String> defaultValue = const [], required bool needEncryption}) async {
    if (needEncryption) {
      return jsonDecode(await _getEncryptionValue(key, defaultValue: jsonDecode(jsonEncode(defaultValue))))
          as List<String>;
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      if (await _checkNormalKey(key, pref: pref)) {
        return pref.getStringList(key)!;
      } else {
        return defaultValue;
      }
    }
  }

  static Future<void> setInt(String key, int value, {required bool needEncryption}) async {
    if (needEncryption) {
      await _setEncryptionValue(key, value.toString());
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      await pref.setInt(key, value);
    }
  }

  static Future<int> getInt(String key, {int defaultValue = 0, required bool needEncryption}) async {
    if (needEncryption) {
      return int.parse(await _getEncryptionValue(key, defaultValue: "$defaultValue"));
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      if (await _checkNormalKey(key, pref: pref)) {
        return pref.getInt(key)!;
      } else {
        return defaultValue;
      }
    }
  }

  static Future<void> setDouble(String key, double value, {required bool needEncryption}) async {
    if (needEncryption) {
      await _setEncryptionValue(key, value.toString());
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      await pref.setDouble(key, value);
    }
  }

  static Future<double> getDouble(String key, {double defaultValue = 0, required bool needEncryption}) async {
    if (needEncryption) {
      return double.parse(await _getEncryptionValue(key, defaultValue: "$defaultValue"));
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      if (await _checkNormalKey(key, pref: pref)) {
        return pref.getDouble(key)!;
      } else {
        return defaultValue;
      }
    }
  }

  static Future<void> setBool(String key, bool value, {required bool needEncryption}) async {
    if (needEncryption) {
      await _setEncryptionValue(key, value ? "true" : "false");
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      await pref.setBool(key, value);
    }
  }

  static Future<bool> getBool(String key, {bool defaultValue = false, required bool needEncryption}) async {
    if (needEncryption) {
      return (await _getEncryptionValue(key, defaultValue: defaultValue ? "true" : "false")) == "true";
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      if (await _checkNormalKey(key, pref: pref)) {
        return pref.getBool(key)!;
      } else {
        return defaultValue;
      }
    }
  }

  static Future<void> setJson(String key, dynamic value, {required bool needEncryption}) async {
    await setString(key, json.encode(value).toString(), needEncryption: needEncryption);
  }

  static Future<dynamic> getJson(String key, {required bool needEncryption}) async {
    if (needEncryption) {
      var pref = await _getEncryptionPreferences();
      if (await _checkEncryptionKey(key, pref: pref)) {
        return json.decode((await _getEncryptionValue(key, defaultValue: "")));
      } else {
        return null;
      }
    } else {
      SharedPreferences pref = await _getNormalPreferences();
      if (await _checkNormalKey(key, pref: pref)) {
        return json.decode(pref.getString(key)!);
      } else {
        return null;
      }
    }
  }

  ///MARK: ----存取值 end ----
  ///MARK: ----使用者設定 start ----

  static Future<void> setLanguage(String lang) async {
    await setString("Lang", lang, needEncryption: false);
  }

  static Future<String> getLanguage() async {
    return await getString("Lang", needEncryption: false);
  }

  static Future<void> setMemberID(String id) async {
    await setString("MemberID", id, needEncryption: true);
  }

  static Future<String> getMemberID() async {
    return await getString("MemberID", needEncryption: true);
  }

  static Future<void> setToken(String token) async {
    await setString('Token', token, needEncryption: true);
  }

  static Future<String> getToken() async {
    return await getString("Token", needEncryption: true);
  }

  /// 主題色
  static Future<void> setTheme(ThemeMode mode) async {
    await setInt("userTheme", mode.index, needEncryption: false);
  }

  static Future<ThemeMode> getTheme() async {
    int index = await getInt("userTheme", defaultValue: -1, needEncryption: false);
    if (index == -1) {
      return ThemeMode.dark;
    }
    return ThemeMode.values[index];
  }

  /// Chat Room
  /// 聊天室動態牆紀錄更改
  static Future<void> setWall(String roomId, bool open) async {
    await setBool("chatRoomWall${roomId}", open, needEncryption: false);
  }

  /// 檢查動態牆收起或開啟
  static Future<bool> checkWallClose(
    String roomId,
  ) async {
    return await getBool("chatRoomWall${roomId}", needEncryption: false);
  }

  /// MARK: 判斷是否登入過
  static Future<void> setLogIn(bool isLogIn) async {
    await setBool("LogIn", isLogIn, needEncryption: false);
  }

  static Future<bool> getLogIn() async {
    return await getBool("LogIn", needEncryption: false);
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
    /// 清除加密
    var encryptionPref = await _getEncryptionPreferences();
    encryptionPref.deleteAll(aOptions: _androidOptions);

    /// 清除未加密
    SharedPreferences normalPref = await _getNormalPreferences();
    normalPref.getKeys().forEach((key) {
      ///MARK: 如果包含_tmp 代表需要被刪除
      if (key.contains("_tmp")) {
        normalPref.remove(key);
      }
    });
  }

  ///MARK: ----使用者設定 end ----

  ///MARK: ----暫存相關 start ----

  ///MARK: ----暫存相關 end ----
}
