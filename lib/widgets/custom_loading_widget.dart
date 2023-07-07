import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color? baseColor;
  final Color? highlightColor;
  const CustomLoadingWidget({
    required this.width,
    required this.height,
    this.baseColor,
    this.highlightColor,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: baseColor?? Colors.grey.shade400,
        highlightColor: highlightColor?? Colors.grey.shade100,
        child: Container(
          color: baseColor?? Colors.grey.shade300,
          width: width,
          height:height,
        ),
      ),
    );
  }
}
