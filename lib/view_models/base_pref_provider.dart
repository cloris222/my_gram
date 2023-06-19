import '../constant/theme/global_data.dart';
import '../models/app_shared_preferences.dart';
import 'call_back_function.dart';

/// for 需要暫存的Provider使用
abstract class BasePrefProvider {
  /// 定義此SharedPreferencesKey
  String setKey();

  /// 定義此provider 是否為user相關資料
  /// 如果為true，則會在使用者登出後自動清除
  bool setUserTemporaryValue();

  /// 是否為需要加密的資料
  bool needEncryption();

  /// 設定初始值
  Future<void> initValue();

  /// 讀取 SharedPreferencesKey 內容並轉成對應值
  Future<void> readSharedPreferencesValue();

  /// 將 內容 存入 SharedPreferencesKey
  Future<void> setSharedPreferencesValue();

  /// 讀取 API值
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail});

  void printLog(String log) {
    if (false) {
      GlobalData.printLog('BasePrefProvider_${setKey()}:$log');
    }
  }

  String getSharedPreferencesKey() {
    return '${setKey()}${setUserTemporaryValue() ? "_tmp" : ""}';
  }

  ///MARK: 先讀暫存或預設值 後讀api更新值
  Future<void> init(
      {onClickFunction? onFinish,
      onClickFunction? onUpdateFinish,
      ResponseErrorFunction? onConnectFail}) async {
    await Future.delayed(Duration.zero);

    if (await AppSharedPreferences.checkKey(getSharedPreferencesKey(),
        needEncryption: needEncryption())) {
      printLog("readSharedPreferencesValue");
      await readSharedPreferencesValue();
    } else {
      printLog("initValue");
      await initValue();
    }
    if (onFinish != null) {
      onFinish();
    }
    printLog("update");
    update(
        onFinish: onFinish,
        onUpdateFinish: onUpdateFinish,
        onConnectFail: onConnectFail);
  }

  Future<void> update(
      {onClickFunction? onFinish,
      onClickFunction? onUpdateFinish,
      ResponseErrorFunction? onConnectFail}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    printLog("readAPIValue");

    await readAPIValue(onConnectFail: onConnectFail);
    if (onFinish != null) {
      onFinish();
    }
    if (onUpdateFinish != null) {
      onUpdateFinish();
    }
    printLog("setSharedPreferencesValue");
    setSharedPreferencesValue();
  }
}
