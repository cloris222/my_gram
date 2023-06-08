import 'package:base_project/constant/theme/global_data.dart';
import 'package:flutter/material.dart';

enum AppColors {
  ///MARK:主題色彩
  mainThemeButton(dark: Color(0xFF766733), light: Color(0xFF3B82F6)),
  subThemePurple(dark: Color(0xFFCEBB8B), light: Color(0xFF9657D7)),
  mainBackground(dark: Colors.black, light: Colors.white),
  navigationBarSelect(dark: Colors.yellow, light: Color(0xFF3B82F6)),
  navigationBarUnSelect(dark: Colors.grey, light: Colors.grey),

  /// ICON 主要顏色
  iconPrimary(dark: Color(0xFFFFFFFF), light: Color(0xFF000000)),

  /// 文字主要顏色
  textPrimary(dark: Color(0xFFFFFFFF), light: Color(0xFF000000)),
  textSubInfo(dark: Color(0xFFBDBDBD), light: Color(0xFFBDBDBD)),
  textError(dark: Color(0xFFEC6898), light: Color(0xFFEC6898)),
  textHint(dark: Color(0xFFAEAEAE), light: Color(0xFFAEAEAE)),
  textSuccess(dark: Color(0xFFDCAC4E), light: Color(0xFFDCAC4E)),
  textFail(dark: Color(0xFFF24C65), light: Color(0xFFF24C65)),
  textWarning(dark: Color(0xFFFFD600), light: Color(0xFFFFD600)),
  bolderGrey(
      dark: Color.fromRGBO(255, 255, 255, 0.3),
      light: Color.fromRGBO(0, 0, 0, 0.7)),
  commentUnlike(dark: Color(0xFF979797), light: Color(0xFF979797)),

  /// 按鈕顏色相關
  buttonPrimaryText(dark: Color(0xFF000000), light: Color(0xFFFFFFFF)),
  buttonUnable(dark: Colors.grey, light: Colors.grey),
  buttonLike(dark: Color(0xFF3CDBA7), light: Color(0xFF3CDBA7)),
  buttonDisLike(dark: Color(0xFFF24C65), light: Color(0xFFF24C65)),
  buttonMessageRed(dark: Colors.red, light: Colors.red),

  ///背景顏色
  textFieldBackground(dark: Color(0xFF1F1F1F), light: Color(0xFFFFFFFF)),
  dialogBackground(dark: Color(0xFF333333), light: Color(0xFFBDBDBD)),
  moreActionBarBackground(dark: Color(0xFF464646), light: Color(0xFF464646)),
  opacityBackground(dark: Color(0xC6000000), light: Color(0xC6000000)),
  chatBubbleColor(dark: Color(0xFFFFD600), light: Color(0xFFFFD600)),
  messageBackground(dark: Color(0xFF936714), light: Color(0xFF936714)),

  /// 基本顏色
  transparent(dark: Colors.transparent, light: Colors.transparent);

  final Color dark;
  final Color light;

  const AppColors({required this.dark, required this.light});

  Color getColor() {
    return GlobalData.isDark ? dark : light;
  }
}
