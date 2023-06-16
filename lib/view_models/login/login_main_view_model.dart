// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../models/validate_result_data.dart';
import '../../views/main_screen.dart';
import '../check_texteditor_view_model.dart';
import '../gobal_provider/global_tag_controller_provider.dart';
import '../gobal_provider/user_info_provider.dart';

class LoginMainViewModel extends CheckTextEditorViewModel {
  LoginMainViewModel(super.ref);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///MARK:checkTagList
  final String tagEmail = "email";
  final String tagPassword = "password";

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  ///MARK: 判斷是否有未輸入
  bool checkNotEmpty() {
    checkEmptyController(tagEmail, emailController);
    checkEmptyController(tagPassword, passwordController);

    return checkValidateResult(tagEmail) && checkValidateResult(tagPassword);
  }

  bool checkPress() {
    // return checkEmail;
    return true;
  }

  void onEmailChanged(value) {
    if (value.isNotEmpty) {
      ref
          .read(globalValidateDataProvider(tagEmail).notifier)
          .update((state) => ValidateResultData());
    }
  }

  void onPasswordChanged(String value) {
    if (value.isNotEmpty) {
      ref
          .read(globalValidateDataProvider(tagPassword).notifier)
          .update((state) => ValidateResultData());
    }
  }

  void onPressLogin(BuildContext context) {
    if (!checkNotEmpty()) return;
    ref
        .read(userInfoProvider.notifier)
        .loginWithMail(
            email: emailController.text, password: passwordController.text)
        .then((value) => pushAndRemoveUntil(context, const MainScreen()));
  }
}
