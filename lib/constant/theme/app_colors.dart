import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors._();

  ///MARK:基本文字顏色
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textRed = Color(0xFFEC6898);
  static const Color textBlack = Color(0xFF000000);
  static const Color textHintWhite = Color(0xFFAEAEAE);

  static const Color bolderGrey = Color(0xFFE6E5EA);

  ///MARK:主題色彩
  static const Color mainThemeButton = Color(0xFF3B82F6);
  static const Color subThemePurple = Color(0xFF9657D7);

  ///MARK: 漸層
  static const List<Color> gradientBaseColorBg = [
    mainThemeButton,
    subThemePurple,
  ];

  static const List<Color> gradientBaseFlipColorBg = [
    mainThemeButton,
    subThemePurple,
  ];
}
