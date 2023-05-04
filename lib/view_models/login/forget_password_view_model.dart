// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/global_data.dart';
import '../../models/data/validate_result_data.dart';
import '../../views/login/reset_password_page.dart';
import '../check_texteditor_view_model.dart';
import '../gobal_provider/global_tag_controller_provider.dart';

class ForgetPasswordViewModel extends CheckTextEditorViewModel {
  ForgetPasswordViewModel(super.ref);

  TextEditingController emailController = TextEditingController();
  TextEditingController validateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  ///MARK:checkTagList
  final String tagEmail = "email";
  final String tagValidate = "validate";
  final String tagPassword = "password";
  final String tagRePassword = "rePassword";

  ///是否判斷過驗證碼
  // bool checkEmail = false;
  String validateEmail = '';

  String phoneCountry =
  GlobalData.country.isNotEmpty ? GlobalData.country.first.country : '';

  void dispose() {
    emailController.dispose();
    validateController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  ///MARK: 判斷是否有未輸入
  bool checkNotEmpty() {
    checkEmptyController(tagEmail, emailController);
    checkEmptyController(tagValidate, validateController);
    checkEmptyController(tagPassword, passwordController);
    checkEmptyController(tagRePassword, rePasswordController);


    return checkValidateResult(tagEmail) &&
        checkValidateResult(tagValidate) &&
        checkValidateResult(tagPassword) &&
        checkValidateResult(tagRePassword);
  }

  ///MARK: 檢查其他規範
  bool checkSendRequest() {
    ///MARK: 檢查密碼是否相符
    checkPassword();

    return checkValidateResult(tagRePassword);
  }

  bool checkPress() {
    // return checkEmail;
    return true;
  }

  void checkPassword() {
    if (passwordController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty) {
      ref.read(globalValidateDataProvider(tagRePassword).notifier).update(
              (state) =>
              ValidateResultData(
                  result: passwordController.text
                      .compareTo(rePasswordController.text) ==
                      0,
                  message: tr('rule_confirmPW')));
    } else {
      initResult(tagPassword);
      initResult(tagRePassword);
    }
  }
  
  void onPressNext(BuildContext context){
    checkEmptyController(tagEmail, emailController);
    checkEmptyController(tagValidate, validateController);
    
    if(!checkValidateResult(tagEmail) || !checkValidateResult(tagValidate)) return;
    pushPage(context, const ResetPasswordPage());
         
  }


  ///重設密碼
  void onPressReset(BuildContext context) {
    ///MARK: 檢查是否有欄位未填
    if (!checkNotEmpty()) {
      return;
    }

      // ///MARK: 如果檢查有部分錯誤時
      // if (!checkSendRequest()) {
      //   return;
      // }
    //   LoginAPI(onConnectFail: (message) => onBaseConnectFail(context, message))
    //       .register(
    //       account: accountController.text,
    //       password: passwordController.text,
    //       email: emailController.text,
    //       nickname: nicknameController.text,
    //       inviteCode: referralController.text,
    //       emailVerifyCode: emailCodeController.text)
    //       .then((value) async {
    //     ///MARK: 註冊成功動畫
    //     BaseViewModel().pushOpacityPage(
    //         context,
    //         FullAnimationPage(
    //           limitTimer: 10,
    //           animationPath: AppAnimationPath.registerSuccess,
    //           isGIF: true,
    //           nextPage: const MainPage(bRegisterFirstTime: true),
    //           runFunction: _updateRegisterInfo,
    //         ));
    //   });
    // }



    ///MARK: 切換到登入頁面
    void onPressLogin(BuildContext context) {
      popPage(context);
    }
  }


  void onEmailChanged(value){
    if(value.isNotEmpty){
      ref.read(globalValidateDataProvider(tagEmail).notifier)
          .update((state) => ValidateResultData());
    }
  }

  void onPasswordChanged(String value) {
    checkPassword();
  }
}
