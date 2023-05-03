import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordPage extends ConsumerStatefulWidget {
  const ForgetPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends ConsumerState<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.registerAppBar(context),
      body: GestureDetector(
        onTap: (){
          BaseViewModel().clearAllFocus();
        },
        child: Container(
          width: UIDefine.getWidth(),
          height: UIDefine.getHeight(),
          color: Colors.black,
          child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: UIDefine.getWidth(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        BaseViewModel().popPage(context);
                      },
                      child: Icon(Icons.chevron_left,color: AppColors.textWhite,size: UIDefine.getPixelWidth(30),),
                    ),
                    SizedBox(width: UIDefine.getWidth()*0.9,)
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(tr('forgetPassword'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),),
              ),
            ],
          ),
        ),)

      ),
    );
  }
}
