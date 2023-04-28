import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGradientIcon extends StatefulWidget {
  const CustomGradientIcon({
    required this.icon,
    required this.gradient,
    required this.size,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  State<CustomGradientIcon> createState() => _CustomGradientIconState();
}

class _CustomGradientIconState extends State<CustomGradientIcon> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      child: SizedBox(
        width: widget.size*1.2,
        height: widget.size*1.2,
        child: Icon(
          widget.icon,
          size: widget.size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, widget.size, widget.size);
        return widget.gradient.createShader(rect);
      },
    );
}}
