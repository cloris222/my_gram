import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';
import '../../models/data/validate_result_data.dart';
import '../../widgets/label/error_text_widget.dart';
import '../../widgets/text_field/login_text_widget.dart';

class LoginParamView extends StatelessWidget {
  const LoginParamView(
      {Key? key,
      required this.titleText,
      required this.hintText,
      this.subTitleText,
      required this.controller,
      required this.data,
      this.isSecure = false,
      this.onChanged,
      this.onTap,
      this.keyboardType,
      this.bPasswordFormatter = false,
      this.bLimitDecimalLength = false,
      this.errorAlignment = Alignment.centerRight,
      this.hindTitle = false})
      : super(key: key);
  final String titleText;
  final String hintText;
  final String? subTitleText;
  final TextEditingController controller;
  final bool isSecure;
  final ValidateResultData data;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final AlignmentGeometry errorAlignment;
  final bool hindTitle;

  ///MARK: 帳號輸入資訊限制
  final bool bPasswordFormatter;

  ///MARK: 小數點限制兩位
  final bool bLimitDecimalLength;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      hindTitle ? const SizedBox() : _buildTextTitle(titleText),
      subTitleText != null ? _buildSubTitle(subTitleText!) : const SizedBox(),
      LoginTextWidget(
        keyboardType: keyboardType,
        hintText: hintText,
        controller: controller,
        initColor: data.result ? AppColors.bolderGrey : AppColors.textRed,
        enabledColor: data.result ? AppColors.bolderGrey : AppColors.textRed,
        focusedColor: AppColors.mainThemeButton,
        isSecure: isSecure,
        onChanged: onChanged,
        onTap: onTap,
        bPasswordFormatter: bPasswordFormatter,
        bLimitDecimalLength: bLimitDecimalLength,
      ),
      ErrorTextWidget(data: data, alignment: errorAlignment)
    ]);
  }

  Widget _buildTextTitle(String text) {
    return Text(text,
        style: AppTextStyle.getBaseStyle(
          color: AppColors.textWhite,
            fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize14));
  }

  Widget _buildSubTitle(String text) {
    return Text(text,
        style: AppTextStyle.getBaseStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: UIDefine.fontSize14));
  }
}
