import 'package:flutter/material.dart';

import 'app_colors.dart';

///MARK: 漸層
enum AppGradientColors {
  gradientBaseColorBg(
      [AppColors.mainThemeButton, AppColors.subThemePurple]),
  gradientBaseFlipColorBg(
      [AppColors.subThemePurple, AppColors.mainThemeButton]),
  gradientColors([
    AppColors.mainThemeButton,
    AppColors.subThemePurple,
  ]),
  gradientBlackGoldColors([
    AppColors.personalDarkBackground,
    AppColors.personalLightBackground,
  ]);

  final List<AppColors> list;

  const AppGradientColors(this.list);

  List<Color> getColors() {
    return List<Color>.from(list.map((e) => e.getColor()));
  }
}