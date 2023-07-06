import 'dart:ui';

import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/view_models/global_theme_provider.dart';
import 'package:base_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:base_project/views/login/login_main_page.dart';
import 'package:base_project/views/main_screen.dart';
import 'package:base_project/views/pair/pair_main_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/theme/app_routes.dart';
import '../constant/theme/app_text_style.dart';
import '../constant/theme/ui_define.dart';
import '../view_models/base_view_model.dart';
import '../widgets/button/text_button_widget.dart';
import 'common_scaffold.dart';
import 'main_screen.dart';

class AppFirstPage extends ConsumerStatefulWidget {
  const AppFirstPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AppFirstPageState();
}

class _AppFirstPageState extends ConsumerState<AppFirstPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        body: (isDark) => GestureDetector(
              onTap: _onPress,
              child: Stack(
                children: [
                  SizedBox(
                      height: UIDefine.getHeight(), width: UIDefine.getWidth()),
                  Container(
                      width: UIDefine.getWidth(),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImagePath.loginBgImage),
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                  /// 底部圓角
                  // Positioned(
                  //     top: UIDefine.getHeight() * 0.65,
                  //     right: 0,
                  //     left: 0,
                  //     bottom: 0,
                  //     child: Container(
                  //       decoration: AppStyle().styleColorsRadiusBackground(
                  //         color: AppColors.firstAppMarkBackground.getColor(),
                  //         radius: 10,
                  //       ),
                  //     )),
                  /// 遮罩
                  // Positioned(
                  //   top: UIDefine.getViewHeight() * 0.6,
                  //   child: Container(
                  //     width: UIDefine.getWidth(),
                  //     height: UIDefine.getViewHeight() * 0.4,
                  //     decoration: const BoxDecoration(
                  //         gradient: LinearGradient(
                  //             begin: Alignment(0.0, -0.9),
                  //             end: Alignment(0.0, 0.1),
                  //             colors: [Colors.transparent, Colors.black])),
                  //   ),
                  // ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          AppImagePath.fullLogo,
                          width: UIDefine.getPixelWidth(106),
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          height: UIDefine.getPixelWidth(32),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(UIDefine.getHeight()>600?24:20)),
                            constraints: BoxConstraints(
                                maxHeight: UIDefine.getPixelWidth(UIDefine.getHeight()>600?296:248),
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: AppColors.dynamicButtonsBorder.getColor().withOpacity(0.1),
                                borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(40))
                            ),
                            child: GlassContainer(
                              border: 0.0,
                              blur: 10,
                              linearGradient: LinearGradient(
                                  colors: [ AppColors.dynamicButtons.getColor().withOpacity(0.2),AppColors.dynamicButtons.getColor().withOpacity(0.2)]
                              ),
                              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(40)),
                              child: Container(
                                width: UIDefine.getHeight()>600?UIDefine.getWidth():UIDefine.getWidth()*0.85,
                                padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(32)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButtonWidget(
                                        textColor:
                                        AppColors.mainBackground,
                                        fontWeight: FontWeight.w500,
                                        fontSize: UIDefine.fontSize14,
                                        isFillWidth: true,
                                        setHeight:
                                        UIDefine.getPixelWidth(44),
                                        isGradient: true,
                                        btnText: tr('registerWithEmail'),
                                        onPressed: _onPress),
                                    SizedBox(
                                      width: UIDefine.getWidth(),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: UIDefine.getPixelWidth(15)),
                                              height: 1,
                                              color: AppColors.subThemePurple
                                                  .getColor()
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          Text(
                                            tr('or'),
                                            style: AppTextStyle.getBaseStyle(
                                                fontSize:
                                                UIDefine.fontSize12),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: UIDefine.getPixelWidth(15)),
                                              height: 1,
                                              color: AppColors.subThemePurple
                                                  .getColor()
                                                  .withOpacity(0.3),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                          height: UIDefine.getHeight()*0.05,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _buildIconButton(String image) {
    return GestureDetector(
      onTap: _onPress,
      child: Container(
        width: UIDefine.getPixelWidth(63),
        height: UIDefine.getPixelWidth(63),
        // margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(15)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: UIDefine.getPixelWidth(24),
              height: UIDefine.getPixelWidth(24),
              color: Colors.grey.withOpacity(0.3),
              child: Image.asset(
                image,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPress() {
    /// 綁定帳號 自動登入
    // ref
    //     .read(userInfoProvider.notifier)
    //     .loginWithMail(
    //     email: "mygram001@gmail.com", password: "123456")
    //     // email: "lily@locas.com.tw", password: "0")
    //     .then((value) async {
    //   BaseViewModel().pushAndRemoveUntil(context, const MainScreen());
    // });
    // return ;
    if (GlobalData.userToken.isNotEmpty) {
      BaseViewModel().pushPage(context, const MainScreen());
    } else {
      BaseViewModel().pushPage(context, const LoginMainPage());
    }
  }
}
