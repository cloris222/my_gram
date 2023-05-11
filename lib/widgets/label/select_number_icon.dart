import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectNumberIcon extends StatelessWidget {
  final int number;
  const SelectNumberIcon({Key? key,required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: UIDefine.getPixelWidth(25),
      height: UIDefine.getPixelWidth(25),
      decoration: BoxDecoration(
            color:AppColors.chatBubbleColor,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 3,color: Colors.white)
      ),
      child: Text(number.toString(),style: AppTextStyle.getBaseStyle(color: AppColors.textBlack,fontWeight: FontWeight.w700),),
    );
  }
}
