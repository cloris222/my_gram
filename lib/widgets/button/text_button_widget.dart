import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';
import 'interval_click.dart';

class TextButtonWidget extends StatefulWidget {
  const TextButtonWidget({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.setMainColor = AppColors.mainThemeButton,
    this.setSubColor = AppColors.textWhite,
    this.setTransColor = Colors.transparent,
    this.setHeight,
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
  });

  final String btnText;
  final VoidCallback onPressed;
  final Color setMainColor; //主色
  final Color setSubColor; //子色
  final Color setTransColor; //取代透明色,用於倒數框
  final double? setHeight;
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

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget>
    with IntervalClick {
  @override
  Widget build(BuildContext context) {
    return createButton(context);
  }

  Widget createButton(BuildContext context) {
    Color primaryColor, borderColor, textColor;
    if (widget.isBorderStyle) {
      primaryColor = widget.setSubColor;
      borderColor = widget.setMainColor;
      textColor = widget.setMainColor;
    } else {
      primaryColor = widget.setMainColor;
      borderColor = widget.setTransColor;
      textColor = widget.setSubColor;
    }
    var actionButton = GestureDetector(
        onTap: () => intervalClick(widget.needTimes, widget.onPressed),
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical:
                    widget.backgroundVertical ?? UIDefine.getPixelHeight(5),
                horizontal:
                    widget.backgroundHorizontal ?? UIDefine.getPixelWidth(10)),
            decoration: AppStyle().styleColorBorderBackground(
                borderLine: widget.borderSize,
                radius: widget.radius,
                color: borderColor,
                backgroundColor: primaryColor),
            child: Text(
              widget.btnText,
              textAlign: TextAlign.center,
              style: AppTextStyle.getBaseStyle(
                  color: textColor,
                  fontSize: widget.fontSize ?? UIDefine.fontSize16),
            )));

    return widget.isFillWidth
        ? Container(
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
