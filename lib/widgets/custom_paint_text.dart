import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';

class CustomPaintText extends StatefulWidget {
  final String text;
  final double maxWidth;
  final TextStyle? textStyle;
  final void Function(int lineCount)? onLineCountChanged;
  const CustomPaintText({
    required this.text,
    required this.maxWidth,
    this.textStyle,
    this.onLineCountChanged,Key? key}) : super(key: key);

  @override
  State<CustomPaintText> createState() => _CustomPaintTextState();
}

class _CustomPaintTextState extends State<CustomPaintText> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PostTextPainter(widget.text, widget.maxWidth, widget.textStyle,widget.onLineCountChanged),
    );
  }
}

class _PostTextPainter extends CustomPainter {
  final String text;
  final double maxWidth;
  final TextStyle? textStyle;
  final void Function(int lineCount)? onLineCountChanged;
  _PostTextPainter(this.text, this.maxWidth, this.textStyle,this.onLineCountChanged);

  int lineCount = 0;

  @override
  void paint(Canvas canvas, Size size) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle ?? AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w300),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout(maxWidth: maxWidth);
    textPainter.paint(canvas, Offset(-180.0, -10.0));
    final newLineCount = textPainter.computeLineMetrics().length;
    if (newLineCount != lineCount) {
      lineCount = newLineCount;
      if (onLineCountChanged != null) {
        onLineCountChanged!(lineCount);
      }
    }
  }

  @override
  bool shouldRepaint(_PostTextPainter oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.maxWidth != maxWidth ||
        oldDelegate.textStyle != textStyle;
  }
}
