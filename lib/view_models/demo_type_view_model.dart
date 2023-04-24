import 'package:base_project/view_models/check_texteditor_view_model.dart';
import 'package:flutter/material.dart';

class DemoTypeViewModel extends CheckTextEditorViewModel {
  DemoTypeViewModel(super.ref);

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///MARK:checkTagList
  final String tagAccount = "account";
  final String tagPassword = "password";

  void dispose() {
    accountController.dispose();
    passwordController.dispose();
  }

  ///MARK: 判斷是否有未輸入
  bool checkNotEmpty() {
    checkEmptyController(tagAccount, accountController);
    checkEmptyController(tagPassword, passwordController);

    return checkValidateResult(tagAccount) && checkValidateResult(tagPassword);
  }

  void onPressLogin(BuildContext context) {
    if (!checkNotEmpty()) {
      return;
    }

    showToast(context, "login!!!");
  }
}
