import 'package:base_project/constant/theme/app_gradient_colors.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';
import '../../utils/number_format_util.dart';

class CustomLinearProgress extends StatelessWidget {
  const CustomLinearProgress({
    Key? key,
    required this.percentage,
    this.isGradient = false,
    this.backgroundColor = AppColors.textPrimary,
    this.valueColor = AppColors.mainThemeButton,
    this.height = 10,
    this.radius = 15,
    this.needShowPercentage = false,
    this.needShowFinishIcon = true,
    this.colors,
    this.setWidth
  }) : super(key: key);
  final double percentage;
  final AppColors backgroundColor;
  final AppColors valueColor;
  final double? height;
  final double radius;
  final bool needShowPercentage;
  final bool needShowFinishIcon;
  final bool isGradient;
  final List<Color>? colors;
  final double? setWidth;

  @override
  Widget build(BuildContext context) {
    int flex = int.parse(NumberFormatUtil()
        .integerFormat(percentage * 100, hasSeparator: false));
    if (flex <= 0) {
      flex = 0;
    }
    if (flex >= 100) {
      flex = 100;
    }
    return Row(
      children: [
        Flexible(
            child: Stack(alignment: Alignment.centerLeft, children: [
          Container(
              decoration: AppStyle().styleColorsRadiusBackground(
                  color: backgroundColor.getColor(), radius: radius),
              width: setWidth??UIDefine.getWidth(),
              height: height),
          Row(
            children: [
              flex == 0
                  ? Container()
                  : Flexible(
                      flex: flex,
                      child: Container(
                          decoration: isGradient?
                          AppStyle().styleLinearRadiusBackground(colors: AppGradientColors.gradientColors.getColors()):
                          AppStyle().styleColorsRadiusBackground(
                              color: valueColor.getColor(), radius: radius),
                          width: UIDefine.getWidth(),
                          height: height),
                    ),
              flex == 100
                  ? Container()
                  : Flexible(
                      flex: 100 - flex,
                      child: Container(width: UIDefine.getWidth())),
            ],
          )
        ])),
        Visibility(
            visible: needShowPercentage,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: (flex == 100 && needShowFinishIcon)
                  ? Icon(
                      Icons.check,
                      size: UIDefine.fontSize16)
                  : Text(
                      '$flex%',
                      style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12),
                    ),
            ))
      ],
    );
  }
}
