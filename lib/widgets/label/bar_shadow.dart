import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/ui_define.dart';

class BarShadow extends StatelessWidget {
  const BarShadow({Key? key, this.height}) : super(key: key);
  final double? height;

  @override
  Widget build(BuildContext context) {
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

    return GlassContainer(
      height: height ?? UIDefine.getPixelWidth(120),
      width: UIDefine.getWidth(),
      border: 0.0,
      blur: 0.7,
      radius: 0,
      linearGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.textBlack.getColor().withOpacity(0.6),
            AppColors.textBlack.getColor().withOpacity(0.6),
            AppColors.textBlack.getColor().withOpacity(0.078),
            AppColors.textBlack.getColor().withOpacity(0),
          ]),
    );
  }
}
