import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors._();

  ///MARK:基本文字顏色
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFFBDBDBD);
  static const Color textRed = Color(0xFFEC6898);
  static const Color textBlack = Color(0xFF000000);
  static const Color textHintWhite = Color(0xFFAEAEAE);
  static const Color bolderGrey = Color.fromRGBO(255, 255, 255, 0.3);

  static const Color commentUnlike = Color(0xFF979797);

  ///MARK:主題色彩
  static const Color mainThemeButton = Color(0xFF766733);
  static const Color subThemePurple = Color(0xFFCEBB8B);

  ///背景顏色
  static const Color textFieldBackground = Color(0xFF1F1F1F);

  static const Color buttonLike = Color(0xFF3CDBA7);
  static const Color buttonDisLike = Color(0xFFF24C65);

  ///MARK: 漸層
  static const List<Color> gradientBaseColorBg = [
    mainThemeButton,
    subThemePurple,
  ];

  static const List<Color> gradientBaseFlipColorBg = [
    mainThemeButton,
    subThemePurple,
  ];

  static const List<Color> gradientColors = [
    Color(0xFF766733),
    Color(0xFFCEBB8B),
    Color(0xFF766733),
  ];

}
