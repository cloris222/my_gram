// ignore_for_file: use_build_context_synchronously

import 'package:base_project/constant/theme/ui_define.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/enum/app_param_enum.dart';
import '../constant/theme/global_data.dart';
import '../models/app_shared_preferences.dart';
import '../models/http/http_setting.dart';
import '../models/http/data/api_response.dart';
import '../utils/language_util.dart';

class BaseViewModel {
  /// 判斷是否登入,當token 為空時，代表未登入
  bool isLogin() {
    return GlobalData.userToken.isNotEmpty;
  }

  /// 取得全域Context
  BuildContext getGlobalContext() {
    return GlobalData.globalKey.currentContext!;
  }

  /// 跳下方文字窗
  void showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void buildHttpOnFail(BuildContext context, String errorMessage) {
    showToast(context, tr(errorMessage));
  }

  void copyText({required String copyText}) {
    Clipboard.setData(ClipboardData(text: copyText));
  }

  void clearAllFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  ///取得 PublicKey
  Future<void> getPublicKey() async {
    // await CommonAPI().getApiSecret().then((value) => {
    //       GlobalData.apiSecretKey = value.data['apiSecretKey'],
    //       GlobalData.publicKey = value.data['publicKey'],
    //     });
  }

  ///MARK: 通用的 單一彈錯視窗
  onBaseConnectFail(BuildContext context, String message) {
    // ConfirmDialog(context, mainText: message, callOkFunction: () {}).show();
  }


  ///MARK: 推頁面 偷懶用
  void popPage(BuildContext context) {
    Navigator.pop(context);
  }

  ///MARK: 推新的一頁
  Future<void> pushPage(BuildContext context, Widget page) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));

    // /// 由下而上的推頁方式
    // await Navigator.of(context).push( PageRouteBuilder(
    //   pageBuilder: (context, animation, secondaryAnimation) => page,
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //     const begin = Offset(0.0, 1.0);
    //     const end = Offset.zero;
    //     const curve = Curves.ease;
    //
    //     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    //
    //     return SlideTransition(
    //       position: animation.drive(tween),
    //       child: child,
    //     );
    //   },
    // ));
  }

  ///MARK: 取代當前頁面
  Future<void> pushReplacement(BuildContext context, Widget page) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  ///MARK: 將前面的頁面全部清除只剩此頁面
  Future<void> pushAndRemoveUntil(BuildContext context, Widget page) async {
    await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => page),
      (route) => false,
    );
  }

  ///MARK: 全域切頁面
  Future<void> globalPushAndRemoveUntil(Widget page) async {
    GlobalData.globalKey.currentState?.pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (BuildContext context) => page),
      (route) => false,
    );
  }

  ///MARK: 推一個疊加頁面
  Future<void> pushStackPage(BuildContext context, Widget page) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // set to false
        pageBuilder: (_, __, ___) => page,
      ),
    );
  }

  /// 切換主頁頁面
  void changeMainScreenPage(AppNavigationBarType type,{bool isRebecca=false,int index=0}){
    if(isRebecca){
      GlobalData.dynamicRebeccaOffset=UIDefine.getViewHeight()*0.85*index;
    }
    GlobalData.mainScreenSubject.changeMainScreenPage( type,isRebecca:isRebecca);
  }

  String _buildDataFormat(
      {required String strFormat,
      required DateTime time,
      bool needLocale = false}) {
    return DateFormat(
            strFormat, needLocale ? LanguageUtil.getTimeLocale() : "en")
        .format(time);
  }

  DateTime _getNow() {
    return DateTime.now();
  }

  /// ex: 2022-10-18
  String getTimeWithDayFormat({DateTime? time}) {
    return _buildDataFormat(strFormat: 'yyyy-MM-dd', time: time ?? _getNow());
  }

  ///MARK: 更新使用者資料
  Future<void> saveUserLoginInfo(
      {required bool isLogin,
      required ApiResponse response,
      required WidgetRef ref}) async {
    await AppSharedPreferences.setLogIn(true);
    await AppSharedPreferences.setMemberID(response.data['id']);
    await AppSharedPreferences.setToken(response.data['token']);
    GlobalData.userToken = response.data['token'];
    GlobalData.userMemberId = response.data['id'];

    await uploadPersonalInfo(isLogin: isLogin, ref: ref);

    AppSharedPreferences.printAll();
  }

  ///MARK: 登出使用者資料
  Future<void> clearUserLoginInfo() async {
    await AppSharedPreferences.setLogIn(false);
    await AppSharedPreferences.setMemberID('');
    await AppSharedPreferences.setToken('');
    await clearTemporaryData();
    GlobalData.userToken = '';
    GlobalData.userMemberId = '';
    stopUserListener();
  }

  ///MARK: 登出後-清除暫存資料
  Future<void> clearTemporaryData() async {
    ///清除使用者相關的暫存資料
    AppSharedPreferences.clearUserTmpValue();
  }

  ///MARK: 使用者監聽
  void startUserListener() {
    GlobalData.printLog('---startUserListener');
  }

  ///MARK: 關閉使用者監聽
  void stopUserListener() {
    GlobalData.printLog('---stopUserListener');
  }

  ///MARK: 使用者資料
  Future<bool> uploadPersonalInfo(
      {required bool isLogin, required WidgetRef ref}) async {
    ///MARK: 判斷有無讀取失敗
    bool connectFail = false;
    onFail(message) => connectFail = true;

    List<bool> checkList = List<bool>.generate(1, (index) => false);

    if (isLogin) {
      ///MARK: 直接強迫API更新
      // ref
      //     .watch(userInfoProvider.notifier)
      //     .update(onConnectFail: onFail, onFinish: () => checkList[0] = true);

      await checkFutureTime(
          logKey: 'uploadPersonalInfo',
          onCheckFinish: () => !checkList.contains(false) || connectFail);

      ///MARK: 判斷有無讀取失敗
      return !connectFail;
    } else {
      ///MARK: 後更新 頁面自動更新資料
      // ref.watch(userInfoProvider.notifier).init(onConnectFail: onFail);

      return true;
    }
  }

  /// 簡易timer
  Future<void> checkFutureTime(
      {required bool Function() onCheckFinish,
      Duration timeOut =
          const Duration(milliseconds: HttpSetting.connectionTimeout),
      String logKey = 'checkFutureTime',
      bool printLog = true}) async {
    if (printLog) GlobalData.printLog('$logKey: ---timeStart!!!!');
    while (timeOut.inSeconds > 0) {
      await Future.delayed(const Duration(milliseconds: 500));
      timeOut = timeOut - const Duration(microseconds: 500);
      if (onCheckFinish()) {
        if (printLog) GlobalData.printLog('$logKey: ---timeFinish!!!!');
        return;
      }
    }
    if (printLog) GlobalData.printLog('$logKey: ---timeOut!!!!');
  }
}
