import 'package:flutter/material.dart';

import '../../view_models/base_view_model.dart';
import '../enum/style_enum.dart';
import 'app_colors.dart';
import 'ui_define.dart';

class AppTextStyle {
  const AppTextStyle._();

  static TransitionBuilder setMainTextBuilder() {
    ///MARK:textScaleFactor 控制文字比例大小
    ///MARK:boldText 控制文字粗體(測試無效果，可能要看看IOS)
    return (context, widget) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1,
            // boldText: false,
          ),
          child: widget ?? const SizedBox());
    };
  }

  static bool isSystemBold() {
    return MediaQuery.of(BaseViewModel().getGlobalContext()).boldText;
  }

  static FontWeight? getFontWeight(FontWeight? fontWeight) {
    if (fontWeight == null) {
      return null;
    }
    if (isSystemBold()) {
      if (fontWeight.index <= FontWeight.w500.index) {
        return null;
      }
    }
    return fontWeight;
  }

  static TextStyle getBaseStyle({
    Color color = AppColors.textWhite,
    double? fontSize,
    FontWeight? fontWeight,
    AppTextFamily? fontFamily,
    FontStyle? fontStyle,
    double? height,
    TextDecoration? textDecoration,
    AppTextShadows shadowsType = AppTextShadows.none,
  }) {
    return TextStyle(
        color: color,
        fontSize: fontSize ?? UIDefine.fontSize12,
        fontFamily: fontFamily?.name,
        fontWeight: getFontWeight(fontWeight),
        fontStyle: fontStyle,
        height: height,
        decoration: textDecoration,
        shadows: getTextShadow(shadowsType));
  }

  static List<BoxShadow>? getTextShadow(AppTextShadows type) {
    switch(type){
      case AppTextShadows.none:
        return null;
      case AppTextShadows.common:
        return [
          BoxShadow(
              color: Colors.black.withOpacity(0.31),
              offset: Offset(3.8, 3.8), //陰影y軸偏移量
              blurRadius: 4.81, //陰影模糊程度
              spreadRadius: 0 //陰影擴散程度
          )
        ];
    }
  }
}
