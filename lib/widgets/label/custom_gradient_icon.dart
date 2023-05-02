import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGradientIcon extends StatefulWidget {
  const CustomGradientIcon({
    required this.icon,
    required this.colors,

    Key? key,
  }) : super(key: key);
  final Icon icon;
  final List<Color> colors;

  @override
  State<CustomGradientIcon> createState() => _CustomGradientIconState();
}

class _CustomGradientIconState extends State<CustomGradientIcon> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: widget.colors,
        ).createShader(bounds);
      },
      child: widget.icon,
    );
}}
