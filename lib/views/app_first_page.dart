import 'dart:ui';

import 'package:base_project/view_models/global_theme_provider.dart';
import 'package:base_project/views/pair/pair_main_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/theme/app_routes.dart';
import '../constant/theme/app_text_style.dart';
import '../constant/theme/ui_define.dart';
import '../view_models/base_view_model.dart';
import '../widgets/button/text_button_widget.dart';
import 'common_scaffold.dart';

class AppFirstPage extends StatefulWidget {
  const AppFirstPage({Key? key}) : super(key: key);

  @override
  State<AppFirstPage> createState() => _AppFirstPageState();
}

class _AppFirstPageState extends State<AppFirstPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        body: (isDark) => GestureDetector(
          onTap: (){
            BaseViewModel().pushPage(context, const PairMainPage());
          },
          child: Container(
            width: UIDefine.getWidth(),
            height: UIDefine.getHeight(),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImagePath.loginBgImage,),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),),
            ),
            child: Column(
              children: [
                SizedBox(height: UIDefine.getViewHeight()*0.5,),
                Container(
                  width: UIDefine.getPixelWidth(90),
                  height: UIDefine.getPixelWidth(90),
                  child: Image.asset(AppImagePath.logoImage,fit: BoxFit.cover,),
                ),
                SizedBox(height:  UIDefine.getPixelWidth(15),),
                Container(
                  width: UIDefine.getPixelWidth(120),
                  child: Image.asset(AppImagePath.logoTextImage,fit: BoxFit.cover,),
                ),
                SizedBox(height:  UIDefine.getPixelWidth(20),),
                ClipRRect(
                  borderRadius:BorderRadius.circular(40),
                  child: Container(
                    width: UIDefine.getWidth()*0.85,
                    padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(25)),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                          padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButtonWidget(
                                    textColor: AppColors.mainBackground,
                                    fontWeight: FontWeight.w500,
                                    fontSize: UIDefine.fontSize14,
                                    isFillWidth: false,
                                    setWidth: UIDefine.getWidth()*0.6,
                                    setHeight: UIDefine.getPixelWidth(30),
                                    isGradient: true,
                                    btnText: tr('registerWithEmail'),
                                    onPressed: () {  },),
                                ],
                              ),
                              SizedBox(height: UIDefine.getPixelWidth(20),),
                              Container(
                                width: UIDefine.getWidth()*0.6,
                                child: Row(
                                  children: [
                                    Container(
                                      width: UIDefine.getPixelWidth(50),
                                      height: 1,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                    Expanded(child: Container()),
                                    Text(tr('otherRegisterWay'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12),),
                                    Expanded(child: Container()),
                                    Container(
                                      width: UIDefine.getPixelWidth(50),
                                      height: 1,
                                      color: Colors.white.withOpacity(0.6),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: UIDefine.getPixelWidth(20),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildIconButton(AppImagePath.googleIcon),
                                  _buildIconButton(AppImagePath.fbIcon),
                                  _buildIconButton(AppImagePath.appleIcon),
                                ],
                              )
                            ],
                          ),

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildIconButton(String image){
    return Container(
      width: UIDefine.getPixelWidth(50),
      height: UIDefine.getPixelWidth(50),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Colors.grey.withOpacity(0.5),
            child: Image.asset(image,),
          ),
        ),
      ),
    );
  }

}
