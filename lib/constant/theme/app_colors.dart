import 'package:base_project/constant/theme/global_data.dart';
import 'package:flutter/material.dart';

enum AppColors {
  ///MARK:主題色彩
  mainThemeButton(dark: Color(0xFFECB680), light: Color(0xFFECB680)),
  subThemePurple(dark: Color(0xFFE2C98E), light: Color(0xFFE2C98E)),
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
  textLink(dark: Color(0xFFC6A146), light: Color(0xFFC6A146)),
  bolderGrey(dark: Color.fromRGBO(255, 255, 255, 0.3), light: Color.fromRGBO(0, 0, 0, 0.7)),
  commentUnlike(dark: Color(0xFF989898), light: Color(0xFF989898)),
  textBlack(dark: Color(0xFF000000), light: Color(0xFF000000)),
  textWhite(dark: Color(0xFFFFFFFF), light: Color(0xFFFFFFFF)),
  textHintColor(dark: Color(0xFF837F7E), light: Color(0xFF837F7E)),

  /// 按鈕顏色相關
  buttonPrimaryText(dark: Color(0xFF000000), light: Color(0xFFFFFFFF)),
  buttonGradientText(dark: Color(0xFFFFFFFF), light: Color(0xFFFFFFFF)),
  buttonUnable(dark: Color(0x3C9E9E9E), light: Color(0x3C9E9E9E)),
  buttonLike(dark: Color(0xFF3CDBA7), light: Color(0xFF3CDBA7)),
  buttonDisLike(dark: Color(0xFFC11D11), light: Color(0xFFC11D11)),
  buttonMessageRed(dark: Colors.red, light: Colors.red),
  buttonCommon(dark: Color(0xFF9E9E9E), light: Color(0xFF9E9E9E)),
  buttonCameraBg(dark: Color.fromARGB(255, 105, 101, 100), light: Color(0xFF514E4D)),
  dynamicButtons(dark: Color(0xFF373737), light: Color(0xFF373737)),
  dynamicButtonsBorder(dark: Color(0xFFFEFEFE), light: Color(0xFFFEFEFE)),

  ///背景顏色
  textFieldBackground(dark: Color(0xFF1F1F1F), light: Color(0xFFFFFFFF)),
  dialogBackground(dark: Color(0xFF333333), light: Color(0xFFBDBDBD)),
  moreActionBarBackground(dark: Color(0xFF464646), light: Color(0xFF464646)),
  opacityBackground(dark: Color(0xC6000000), light: Color(0xC6000000)),
  chatBubbleColor(dark: Color(0xFFFFD600), light: Color(0xFFFFD600)),
  messageBackground(dark: Color(0xFF936714), light: Color(0xFF936714)),
  personalDarkBackground(dark: Color(0xFF222222), light: Color(0xFF222222)),
  personalLightBackground(dark: Color(0xFF2a1a14), light: Color(0xFF2a1a14)),
  messageOtherBg(dark: Color(0xFF595451), light: Color(0xFF6A615C)),
  recordBackground(dark: Color(0xFF140B07), light: Color(0xFF140B07)),
  createFunctionBackground(dark: Color(0x33000000), light: Color(0x33FFFFFF)),
  firstAppMarkBackground(dark: Color(0x333D2B17),light: Color(0x333D2B17)),
  messageTextBg(dark: Color(0xFF18100C), light: Color(0xFF36302E)),

  /// 基本顏色
  transparent(dark: Colors.transparent, light: Colors.transparent);

  /// 背景漸層(聊天室)
  /// 扇形漸層(還需調整)
  // static RadialGradient messageLinearBg =
  //   RadialGradient(
  //     colors: <Color>[Color(0xFF0D0806), Color(0xFF1D140F), Color(0xFF433125)],
  //     center: Alignment.centerLeft
  //   );
  static LinearGradient messageLinearBg = LinearGradient(
      colors: [Color(0xFF433125),Color(0xFF1D140F),Color(0xFF0D0806), Color(0xFF1D140F), Color(0xFF433125)],
      begin: Alignment.topRight,
      end: Alignment.bottomRight);

  final Color dark;
  final Color light;

  const AppColors({required this.dark, required this.light});

  Color getColor() {
    return GlobalData.isDark ? dark : light;
  }
}
