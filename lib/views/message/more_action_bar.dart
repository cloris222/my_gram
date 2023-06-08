import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:flutter/cupertino.dart';

class MoreActionBar extends StatelessWidget {
  final IconData icon;
  final AppColors iconColor;
  final String title;
  final AppColors titleColor;
  final onClickFunction onClick;
  const MoreActionBar({
        Key? key,
        this.iconColor = AppColors.textPrimary,
        this.titleColor = AppColors.textPrimary,
        required this.icon,
        required this.title,
        required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        onClick();
    },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
          width: UIDefine.getWidth()*0.8,
          height: UIDefine.getPixelWidth(45),
          padding: EdgeInsets.only(left: UIDefine.getPixelWidth(10)),
          decoration: BoxDecoration(
            color: AppColors.moreActionBarBackground.getColor(),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Center(
                  child: Text(title,style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize16,
                      color: titleColor
                  ),)
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(icon,color:iconColor.getColor(),size: UIDefine.getPixelWidth(28),)
              )
            ],
          )
      )
    );
  }
}
