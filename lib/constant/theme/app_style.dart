import 'package:flutter/material.dart';

import '../../widgets/label/gradient_border_type.dart';
import '../enum/border_style_type.dart';
import 'app_gradient_colors.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

///MARK: 放會重複用到的Style
class AppStyle {
  Widget styleFillText(String text,
      {TextStyle? style,
      double minHeight = 20,
      EdgeInsetsGeometry margin = EdgeInsets.zero,
      AlignmentGeometry alignment = Alignment.centerLeft,
      GlobalKey? key}) {
    return Container(
        key: key,
        alignment: alignment,
        margin: margin,
        constraints: BoxConstraints(minHeight: minHeight),
        child: Text(
          text,
          style: style ?? AppTextStyle.getBaseStyle(),
        ));
  }

  /// 漸層色藍紫色
  BoxDecoration baseGradient(
      {double radius = 0,
      Color borderColor = Colors.transparent,
      double borderWith = 1}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: borderWith),
        gradient: LinearGradient(
            colors: AppGradientColors.gradientBaseColorBg.getColors()));
  }

  /// 漸層色紫藍色(反轉)
  BoxDecoration baseFlipGradient(
      {double radius = 0,
      Color borderColor = Colors.transparent,
      double borderWith = 1}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: borderWith),
        gradient: LinearGradient(
            colors: AppGradientColors.gradientBaseFlipColorBg.getColors()));
  }

  /// 自定義漸層
  BoxDecoration buildGradient({
    double radius = 0,
    Color borderColor = Colors.transparent,
    required List<Color> colors,
    double borderWith = 1,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: Colors.transparent, width: borderWith),
        gradient: LinearGradient(colors: colors, begin: begin, end: end));
  }

  BoxDecoration buildGradientBorderWithGradientColor(
      {double radius = 8,
      double borderWidth = 1,
      bool isGradient = false,
      required GradientBorderType type,
      required List<Color> colors}) {
    return BoxDecoration(
        border: GradientBoxBorder(
          gradient: getBroderType(type),
          width: borderWidth,
        ),
        gradient: isGradient ? LinearGradient(colors: colors) : null,
        borderRadius: BorderRadius.circular(radius));
  }

  Gradient getBroderType(GradientBorderType type) {
    switch (type) {
      case GradientBorderType.base:
        return LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          tileMode: TileMode.decal,
          colors: AppGradientColors.gradientBaseColorBg.getColors(),
        );
      case GradientBorderType.common:
        return LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            tileMode: TileMode.decal,
            colors: AppGradientColors.gradientColors.getColors());
      case GradientBorderType.none:
        return const LinearGradient(colors: [
          Colors.transparent,
          Colors.transparent,
        ]);
      case GradientBorderType.test:
        return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.decal,
            colors: [
              Colors.red,
              Colors.blue,
            ]);
    }
  }

  BoxDecoration styleColorBorderBackground({
    double radius = 20.0,
    Color color = Colors.grey,
    Color backgroundColor = Colors.white,
    double borderLine = 1,
    bool hasTopLeft = true,
    bool hasTopRight = true,
    bool hasBottomLef = true,
    bool hasBottomRight = true,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft:
            hasTopLeft ? Radius.circular(radius) : const Radius.circular(0),
        topRight:
            hasTopRight ? Radius.circular(radius) : const Radius.circular(0),
        bottomLeft:
            hasBottomLef ? Radius.circular(radius) : const Radius.circular(0),
        bottomRight:
            hasBottomRight ? Radius.circular(radius) : const Radius.circular(0),
      ),
      color: backgroundColor,
      border: Border.all(color: color, width: borderLine),
    );
  }

  BoxDecoration styleColorsRadiusBackground({
    Color color = Colors.white,
    double radius = 15,
    Border? border,
    bool hasTopLeft = true,
    bool hasTopRight = true,
    bool hasBottomLef = true,
    bool hasBottomRight = true,
  }) {
    return BoxDecoration(
      border: border,
      borderRadius: BorderRadius.only(
        topLeft:
            hasTopLeft ? Radius.circular(radius) : const Radius.circular(0),
        topRight:
            hasTopRight ? Radius.circular(radius) : const Radius.circular(0),
        bottomLeft:
            hasBottomLef ? Radius.circular(radius) : const Radius.circular(0),
        bottomRight:
            hasBottomRight ? Radius.circular(radius) : const Radius.circular(0),
      ),
      color: color,
    );
  }

  BoxDecoration styleLinearRadiusBackground({
    List<Color>? colors,
    double radius = 15,
    bool hasTopLeft = true,
    bool hasTopRight = true,
    bool hasBottomLef = true,
    bool hasBottomRight = true,
  }) {
    return BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft:
              hasTopLeft ? Radius.circular(radius) : const Radius.circular(0),
          topRight:
              hasTopRight ? Radius.circular(radius) : const Radius.circular(0),
          bottomLeft:
              hasBottomLef ? Radius.circular(radius) : const Radius.circular(0),
          bottomRight: hasBottomRight
              ? Radius.circular(radius)
              : const Radius.circular(0),
        ),
        gradient: LinearGradient(
            colors: colors ?? AppGradientColors.gradientColors.getColors()));
  }

  BoxDecoration styleColorBorderBottomLine(
      {Color color = Colors.grey,
      Color backgroundColor = Colors.transparent,
      double borderLine = 1}) {
    return BoxDecoration(
      color: backgroundColor,
      border: Border(bottom: BorderSide(color: color, width: borderLine)),
    );
  }

  ///MARK: 陰影底
  ///drop-shadow(offset-x offset-y blur-radius spread-radius color)
  BoxDecoration styleShadowBorderBackground(
      {double radius = 15.0,
      Color borderBgColor = Colors.white,
      Color borderColor = Colors.transparent,
      double borderWidth = 0,
      double offsetX = 0,
      double offsetY = 0,
      Color shadowColor = Colors.black12,
      double blurRadius = 0.7,
      double spreadRadius = 0}) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: borderBgColor,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
              color: shadowColor,
              offset: Offset(offsetX, offsetY), //陰影y軸偏移量
              blurRadius: blurRadius, //陰影模糊程度
              spreadRadius: spreadRadius //陰影擴散程度
              )
        ]);
  }

  BoxDecoration styleUserSetting() {
    return styleColorBorderBackground(
        color: AppColors.bolderGrey.getColor(),
        radius: 15,
        backgroundColor: Colors.transparent);
  }

  ///0px 3px 13px #E0EDE6;
  BoxDecoration styleNewUserSetting() {
    return styleShadowBorderBackground(
        shadowColor: const Color(0xFFE0EDE6),
        radius: 15,
        offsetX: 0,
        offsetY: 3,
        blurRadius: 13);
  }

  ///MARK: 登入用
  OutlineInputBorder styleTextEditBorderBackground(
      {double radius = 15.0, Color color = Colors.grey, double width = 1.5}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
