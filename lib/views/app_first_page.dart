import 'dart:ui';

import 'package:base_project/view_models/global_theme_provider.dart';
import 'package:base_project/views/main_screen.dart';
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
import 'main_screen.dart';

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
            BaseViewModel().pushPage(context, const MainScreen());
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
                SizedBox(height: UIDefine.getViewHeight()*0.45,),
                Container(
                  width: UIDefine.getWidth()*0.2,
                  height: UIDefine.getWidth()*0.2,
                  child: Image.asset(AppImagePath.logoImage,fit: BoxFit.cover,),
                ),
                SizedBox(height:  UIDefine.getPixelWidth(15),),
                Container(
                  width: UIDefine.getPixelWidth(120),
                  child: Image.asset(AppImagePath.logoTextImage,fit: BoxFit.cover,),
                ),
                SizedBox(height: UIDefine.getViewHeight()*0.03,),
                Expanded(
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(40),
                    child: Container(
                      width: UIDefine.getWidth()*0.85,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      onPressed: () {
                                        BaseViewModel().pushPage(context, const MainScreen());
                                      },),
                                  ],
                                ),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildIconButton(AppImagePath.googleIcon),
                                    _buildIconButton(AppImagePath.fbIcon),
                                    _buildIconButton(AppImagePath.appleIcon),
                                  ],
                                ),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: UIDefine.getViewHeight()*0.05,),
              ],
            ),
          ),
        ));
  }

  Widget _buildIconButton(String image){
    return GestureDetector(
      onTap: (){
        BaseViewModel().pushPage(context, const MainScreen());
      },
      child: Container(
        width: UIDefine.getWidth()*0.1,
        height: UIDefine.getWidth()*0.1,
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
      ),
    );
  }

}
