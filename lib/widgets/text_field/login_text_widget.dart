import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/app_theme.dart';
import '../../constant/theme/ui_define.dart';
import '../../utils/num_length_formatter.dart';

class LoginTextWidget extends StatefulWidget {
  const LoginTextWidget({
    Key? key,
    required this.hintText,
    this.fontSize,
    this.hintColor = AppColors.textHint,
    this.isSecure = false,
    this.prefixIconAsset = '',
    this.suffixIconAsset = '',
    this.onChanged,
    this.onTap,
    this.enabledColor = AppColors.mainThemeButton,
    this.focusedColor = AppColors.mainThemeButton,
    this.initColor = AppColors.mainThemeButton,
    this.keyboardType,
    required this.controller,
    this.contentPaddingRight,
    this.contentPaddingLeft,
    this.contentPaddingTop,
    this.contentPaddingBottom,
    this.bLimitDecimalLength = false,
    this.bPasswordFormatter = false,
    this.inputFormatters = const [],
    this.bFill = true,
    this.fillColor = AppColors.transparent,
    this.bFocusedGradientBolder = false,
    this.margin,
    this.radius = 10,
    this.maxLines = 1,
  }) : super(key: key);
  final String hintText;
  final double? fontSize;
  final AppColors hintColor;
  final bool isSecure;
  final String prefixIconAsset;
  final String suffixIconAsset;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final double? contentPaddingRight;
  final double? contentPaddingLeft;
  final double? contentPaddingTop;
  final double? contentPaddingBottom;
  final bool bFill;
  final AppColors fillColor;

  ///MARK: 小數點限制兩位
  final bool bLimitDecimalLength;

  ///MARK: 密碼輸入資訊限制
  final bool bPasswordFormatter;

  ///MARK: 自定義 在前兩者限制為false啟用
  final List<TextInputFormatter> inputFormatters;

  ///控制不同狀態下的框限顏色
  final AppColors enabledColor; //可用狀態
  final AppColors focusedColor; //點選中
  final AppColors initColor; //初始化

  /// 是否開啟漸層框(for 點選中)
  final bool bFocusedGradientBolder;
  final EdgeInsetsGeometry? margin;
  final double radius;

  /// 限制行數
  final int ?maxLines;

  @override
  State<LoginTextWidget> createState() => _LoginTextWidgetState();
}

class _LoginTextWidgetState extends State<LoginTextWidget> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: widget.margin ??
            EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
        child: _buildEdit());
  }

  Widget _buildEdit() {
    return TextField(
        maxLines: widget.maxLines,
        cursorColor: AppColors.textPrimary.getColor(),
        controller: widget.controller,
        inputFormatters: widget.bLimitDecimalLength
            ? [
                NumLengthInputFormatter(decimalLength: 2),
                FilteringTextInputFormatter.allow(RegExp(r"[\d.]")),
              ] // 小數點限制兩位 整數預設99位
            : widget.bPasswordFormatter //英文+數字，且不能超過30個字元
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\d]")),
                    LengthLimitingTextInputFormatter(30),
                  ]
                : widget.inputFormatters,
        obscureText: widget.isSecure && isPasswordVisible,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.next,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        style: AppTextStyle.getBaseStyle(),
        decoration: InputDecoration(
            filled: widget.bFill,
            fillColor: widget.fillColor.getColor(),
            isCollapsed: true,
            hintText: widget.hintText,
            hintStyle:
                AppTextStyle.getBaseStyle(height: 1.1, color: widget.hintColor),
            labelStyle: AppTextStyle.getBaseStyle(),
            alignLabelWithHint: true,
            counterStyle: AppTextStyle.getBaseStyle(
                color: AppColors.buttonPrimaryText,
                fontSize: widget.fontSize ?? UIDefine.fontSize12),
            contentPadding: EdgeInsets.only(
                top: widget.contentPaddingTop ?? UIDefine.getPixelWidth(15),
                bottom:
                    widget.contentPaddingBottom ?? UIDefine.getPixelWidth(15),
                left: widget.contentPaddingLeft ?? UIDefine.getPixelWidth(20),
                right: widget.contentPaddingRight ?? UIDefine.getPixelWidth(0)),
            disabledBorder: AppTheme.style.styleTextEditBorderBackground(
                color: widget.enabledColor.getColor(), radius: widget.radius,width: 1),
            enabledBorder: AppTheme.style.styleTextEditBorderBackground(
                color: widget.enabledColor.getColor(), radius: widget.radius,width: 1),
            focusedBorder: AppTheme.style.styleTextEditBorderBackground(
                color: widget.focusedColor.getColor(), radius: widget.radius,width: 1),
            border: AppTheme.style.styleTextEditBorderBackground(
                color: widget.initColor.getColor(), radius: widget.radius,width: 1),
            suffixIcon: widget.suffixIconAsset.isNotEmpty
                ? Image.asset(widget.suffixIconAsset)
                : widget.isSecure
                    ? _buildSecureView()
                    : null,
            prefixIcon: widget.prefixIconAsset.isNotEmpty
                ? Image.asset(widget.prefixIconAsset)
                : null));
  }

  Widget _buildSecureView() {
    return IconButton(
        icon: Icon(
            isPasswordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.grey),
        onPressed: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        });
  }
}
