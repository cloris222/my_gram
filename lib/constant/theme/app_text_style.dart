import 'package:flutter/material.dart';

import '../../view_models/base_view_model.dart';
import '../enum/style_enum.dart';
import 'app_colors.dart';
import 'app_gradient_colors.dart';
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
    AppColors color = AppColors.textPrimary,
    double? fontSize,
    FontWeight? fontWeight,
    AppTextFamily? fontFamily,
    FontStyle? fontStyle,
    double height = 1.4,
    TextDecoration? textDecoration,
    AppTextShadows shadowsType = AppTextShadows.none,
    TextOverflow? overflow,
  }) {
    return TextStyle(
        color: color.getColor(),
        fontSize: fontSize ?? UIDefine.fontSize12,
        fontFamily: fontFamily?.name,
        fontWeight: getFontWeight(fontWeight),
        fontStyle: fontStyle,
        height: height,
        decoration: textDecoration,
        letterSpacing: 0.2,
        shadows: getTextShadow(shadowsType),
        overflow: overflow);
  }

  static List<BoxShadow>? getTextShadow(AppTextShadows type) {
    switch (type) {
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

  //建立漸層樣式
  static TextStyle getGradientStyle(
      {List<Color>? colors,
      double? fontSize,
      FontWeight? fontWeight,
      AppTextFamily? fontFamily,
      FontStyle? fontStyle,
      double? height,
      TextDecoration? textDecoration}) {
    Gradient gradient = LinearGradient(
      begin: Alignment(-1, 0),
      end: Alignment(1, 0),
      colors: colors ?? AppGradientColors.gradientColors.getColors(),
    );
    Shader shader = gradient.createShader(Rect.fromLTWH(0, 0, 400, 1920));
    return TextStyle(
      foreground: Paint()..shader = shader,
      fontSize: fontSize ?? UIDefine.fontSize12,
      fontFamily: fontFamily?.name,
      fontWeight: getFontWeight(fontWeight),
      fontStyle: fontStyle,
      height: height,
      decoration: textDecoration,
    );
  }
}
