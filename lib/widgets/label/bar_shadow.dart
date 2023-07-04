import 'package:base_project/constant/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/ui_define.dart';

class BarShadow extends StatelessWidget {
  const BarShadow({Key? key, this.height, this.typeIndex = 1})
      : super(key: key);
  final double? height;
  final int typeIndex;

  @override
  Widget build(BuildContext context) {
    switch (typeIndex) {
      /// 通用
      case 1:
        return Container(
            height: height ?? UIDefine.getPixelWidth(80),
            width: UIDefine.getWidth(),
            decoration: AppStyle().styleShadowBorderBackground(
                borderBgColor: Colors.transparent,
                shadowColor: AppColors.textBlack.getColor().withOpacity(0.4),
                radius: 0,
                offsetX: 0,
                offsetY: 0.5,
                blurRadius: 40));

      /// for創建使用
      case 11:
        return Container(
            height: height ?? UIDefine.getPixelWidth(80),
            width: UIDefine.getWidth(),
            decoration: AppStyle().styleShadowBorderBackground(
                borderBgColor: Colors.transparent,
                shadowColor: AppColors.textBlack.getColor().withOpacity(0.4),
                radius: 5,
                offsetX: 0,
                offsetY: 0.5,
                blurRadius: 70));
      case 2:
        return GlassContainer(
            height: height ?? UIDefine.getPixelWidth(91),
            width: UIDefine.getWidth(),
            border: 0.0,
            blur: 0.6,
            radius: 0,
            linearGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.mirror,
              colors: List<Color>.generate(
                  11,
                  (index) => AppColors.textBlack
                      .getColor()
                      .withOpacity(0.6 - (index * (0.6 / 10)))),
            ));

      case 3:
        return GlassContainer(
          height: height ?? UIDefine.getPixelWidth(91),
          width: UIDefine.getWidth(),
          border: 0.0,
          blur: 0.7,
          radius: 0,
          linearGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.textBlack.getColor().withOpacity(0.6),
                AppColors.textBlack.getColor().withOpacity(0.3),
                AppColors.textBlack.getColor().withOpacity(0.078),
                AppColors.textBlack.getColor().withOpacity(0),
              ]),
        );
      case 4:
        return Container(
            height: height ?? UIDefine.getPixelWidth(91),
            width: UIDefine.getWidth(),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.mirror,
              colors: List<Color>.generate(12, (index) {
                double opacity = 0.6 - (index * (0.6 / 10));
                return AppColors.textBlack
                    .getColor()
                    .withOpacity(opacity > 0 ? opacity : 0);
              }),
            )));

      default:
        return Container(
          height: height ?? UIDefine.getPixelWidth(91),
          width: UIDefine.getWidth(),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.textBlack.getColor().withOpacity(0.5),
                AppColors.textBlack.getColor().withOpacity(0),
              ])),
        );
    }
  }
}
