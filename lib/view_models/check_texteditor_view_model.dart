import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/data/validate_result_data.dart';
import '../utils/regular_expression_util.dart';
import 'base_view_model.dart';
import 'gobal_provider/global_tag_controller_provider.dart';

class CheckTextEditorViewModel extends BaseViewModel {
  CheckTextEditorViewModel(this.ref);

  final WidgetRef ref;

  void initResult(String tag) {
    ref
        .read(globalValidateDataProvider(tag).notifier)
        .update((state) => ValidateResultData());
  }

  void checkEmptyController(String tag, TextEditingController controller) {
    ref.read(globalValidateDataProvider(tag).notifier).update(
        (state) => ValidateResultData(result: controller.text.isNotEmpty));
  }

  bool checkValidateResult(String tag) {
    return ref.read(globalValidateDataProvider(tag)).result;
  }

  ValidateResultData checkAccount(String value) {
    if (value.isNotEmpty) {
      return ValidateResultData(
          result: RegularExpressionUtil().checkFormatNickName(value),
          message: tr('accountLimitHint'));
    } else {
      return ValidateResultData();
    }
  }
}
