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

  static TextStyle getBaseStyle(
      {Color color = AppColors.textWhite,
      double? fontSize,
      FontWeight? fontWeight,
      AppTextFamily? fontFamily,
      FontStyle? fontStyle,
      double? height,
      TextDecoration? textDecoration}) {
    return TextStyle(
      color: color,
      fontSize: fontSize ?? UIDefine.fontSize12,
      fontFamily: fontFamily?.name,
      fontWeight: getFontWeight(fontWeight),
      fontStyle: fontStyle,
      height: height,
      decoration: textDecoration,
    );
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
      colors: colors ?? [
        Color.fromRGBO(255, 255, 0, 6),
        Color.fromRGBO(255, 255, 255, 0.9),
        Color.fromRGBO(255, 255, 0, 6),
      ],);
    Shader shader = gradient.createShader(Rect.fromLTWH(0,0,400,1920));
    return TextStyle(
      foreground: Paint()
        ..shader = shader,
      fontSize: fontSize ?? UIDefine.fontSize12,
      fontFamily: fontFamily?.name,
      fontWeight: getFontWeight(fontWeight),
      fontStyle: fontStyle,
      height: height,
      decoration: textDecoration,
    );
  }
}
