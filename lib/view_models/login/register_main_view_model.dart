// ignore_for_file: use_build_context_synchronously

import 'package:base_project/models/http/api/user_api.dart';
import 'package:base_project/view_models/login/register_param_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/enum/login_enum.dart';
import '../../constant/theme/global_data.dart';
import '../../models/validate_result_data.dart';
import '../../views/login/register_choose_gender_page.dart';
import '../check_texteditor_view_model.dart';
import '../gobal_provider/global_tag_controller_provider.dart';

class RegisterMainViewModel extends CheckTextEditorViewModel {
  RegisterMainViewModel(super.ref);

  TextEditingController emailController = TextEditingController();
  TextEditingController validateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  ///MARK:checkTagList
  final String tagEmail = "email";
  final String tagValidate = "validate";
  final String tagPassword = "password";
  final String tagRePassword = "rePassword";
  final String tagAcceptProtocol = "acceptProtocol";

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

    ///MARK: 判斷是否有點選協議
    ref.read(globalValidateDataProvider(tagAcceptProtocol).notifier).update(
        (state) => ValidateResultData(
            result: ref.read(globalBoolProvider(tagAcceptProtocol))));

    return checkValidateResult(tagRePassword) &&
        checkValidateResult(tagAcceptProtocol);
  }

  bool checkPress() {
    // return checkEmail;
    return true;
  }

  void checkPassword() {
    if (passwordController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty) {
      ref.read(globalValidateDataProvider(tagRePassword).notifier).update(
          (state) => ValidateResultData(
              result: passwordController.text
                      .compareTo(rePasswordController.text) ==
                  0,
              message: tr('rule_confirmPW')));
    } else {
      initResult(tagPassword);
      initResult(tagRePassword);
    }
  }

  ///MARK: 註冊
  void onPressRegister(BuildContext context) {
    ///MARK: 檢查是否有欄位未填
    if (!checkNotEmpty()) {
      return;
    }
    if (!checkSendRequest()) {
      return;
    }
    ref.read(registerParamProvider.notifier).setAccountInfo(
        email: emailController.text,
        verifyCode: validateController.text,
        password: passwordController.text);
    pushPage(context, const RegisterChooseGenderPage());
  }

  ///MARK: 切換到登入頁面
  void onPressLogin(BuildContext context) {
    popPage(context);
  }

  void showAcceptProtocol() {}

  void onEmailChanged(value) {
    if (value.isNotEmpty) {
      ref
          .read(globalValidateDataProvider(tagEmail).notifier)
          .update((state) => ValidateResultData());
    }
  }

  void onPasswordChanged(String value) {
    checkPassword();
  }

  void sendVerifyCode(BuildContext context) {
    UserAPI(onConnectFail: (msg) => onBaseConnectFail(context, msg))
        .sendEmailVerifyCode(emailController.text, EmailAction.register)
        .then((value) => onBaseConnectFail(context, tr("success")));
  }
}
