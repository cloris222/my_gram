import 'package:flutter/material.dart';

import '../../constant/enum/border_style_type.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_gradient_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';
import 'interval_click.dart';

class TextButtonWidget extends StatefulWidget {
  const TextButtonWidget(
      {super.key,
      required this.btnText,
      required this.onPressed,
      this.setMainColor = AppColors.mainThemeButton,
      this.setSubColor = AppColors.textPrimary,
      this.setTransColor = AppColors.transparent,
      this.setHeight,
      this.setWidth,
      this.fontSize,
      this.fontWeight,
      this.margin,
      this.padding,
      this.isBorderStyle = false,
      this.borderWidth = 1,
      this.isFillWidth = true,
      this.radius = 10,
      this.backgroundHorizontal,
      this.backgroundVertical,
      this.borderSize = 2,
      this.needTimes = 1,
      this.isGradient = false,
      this.textColor = AppColors.buttonGradientText,
      this.isTextGradient = false,
      this.isBorderGradient = false});

  final String btnText;
  final VoidCallback onPressed;
  final AppColors setMainColor; //主色
  final AppColors setSubColor; //子色
  final AppColors setTransColor; //取代透明色,用於倒數框
  final double? setHeight;
  final double? setWidth;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isBorderStyle; //false 時 為填滿顏色 true 為 只有框線色
  final double borderWidth;
  final bool isFillWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double radius;

  final double? backgroundVertical;
  final double? backgroundHorizontal;
  final double borderSize;

  final int needTimes;
  final bool isGradient;
  final AppColors textColor;
  final bool isTextGradient;
  final bool isBorderGradient;

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget>
    with IntervalClick {
  @override
  void didUpdateWidget(covariant TextButtonWidget oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return createButton(context);
  }

  Widget createButton(BuildContext context) {
    Color primaryColor, borderColor;
    if (widget.isBorderStyle) {
      primaryColor = widget.setSubColor.getColor();
      borderColor = widget.setMainColor.getColor();
    } else {
      primaryColor = widget.setMainColor.getColor();
      borderColor = widget.setTransColor.getColor();
    }
    var actionButton = GestureDetector(
        onTap: () => intervalClick(widget.needTimes, widget.onPressed),
        child: Container(
            alignment: Alignment.center,
            width: widget.setWidth,
            height: widget.setHeight,
            padding: EdgeInsets.symmetric(
                vertical:
                    widget.backgroundVertical ?? UIDefine.getPixelHeight(5),
                horizontal:
                    widget.backgroundHorizontal ?? UIDefine.getPixelWidth(10)),
            decoration: widget.isGradient
                ? BoxDecoration(
                    border: Border.all(
                        color: borderColor, width: widget.borderSize),
                    borderRadius: BorderRadius.circular(widget.radius),
                    gradient: LinearGradient(
                      begin: const Alignment(-1, 0),
                      end: const Alignment(1, 0),
                      colors: AppGradientColors.gradientColors.getColors(),
                    ))
                : widget.isBorderGradient
                    ? AppStyle().buildGradientBorderWithGradientColor(
                        type: GradientBorderType.common,
                        colors: AppGradientColors.gradientColors.getColors(),
                      )
                    : AppStyle().styleColorBorderBackground(
                        borderLine: widget.borderSize,
                        radius: widget.radius,
                        color: borderColor,
                        backgroundColor: primaryColor),
            child: Text(
              widget.btnText,
              textAlign: TextAlign.center,
              style: widget.isTextGradient
                  ? AppTextStyle.getGradientStyle(
                      fontSize: widget.fontSize ?? UIDefine.fontSize16,
                      fontWeight: widget.fontWeight ?? FontWeight.w500)
                  : AppTextStyle.getBaseStyle(
                      color: widget.textColor,
                      fontSize: widget.fontSize ?? UIDefine.fontSize16,
                      fontWeight: widget.fontWeight ?? FontWeight.w500),
            )));

    return widget.isFillWidth
        ? Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            margin: widget.margin ??
                EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
            padding: widget.padding,
            child: actionButton)
        : Row(
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: widget.margin ??
                      EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
                  padding: widget.padding,
                  child: actionButton),
            ],
          );
  }
}
