import 'dart:io';

import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/login/register_main_page.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/ui_define.dart';
import '../../view_models/gobal_provider/global_tag_controller_provider.dart';
import '../../view_models/login/login_main_view_model.dart';
import '../../widgets/label/login_param_view.dart';
import '../common_scaffold.dart';
import 'forget_password_page.dart';

class LoginMainPage extends ConsumerStatefulWidget {
  const LoginMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginMainPageState();
}

class _LoginMainPageState extends ConsumerState<LoginMainPage> {

  late LoginMainViewModel viewModel ;

  @override
  void initState() {
    viewModel = LoginMainViewModel(ref);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: CustomAppBar.registerAppBar(context),
        body:(isDark)=>GestureDetector(
          onTap: BaseViewModel().clearAllFocus,
          child: SizedBox(
            width: UIDefine.getWidth(),
            height: UIDefine.getHeight(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(tr('login'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(7)),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr('emailAddress'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(16)),),
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        ///email
                        LoginParamView(
                            keyboardType: TextInputType.emailAddress,
                            hindTitle: true,
                            titleText: tr('email_placeHolder'),
                            hintText: tr("email_placeHolder"),
                            controller: viewModel.emailController,
                            data: ref.watch(
                                globalValidateDataProvider(viewModel.tagEmail)),
                            onChanged: (String value) {
                              setState(() {
                                viewModel.onEmailChanged(value);
                              });
                            }
                        ),
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        Text(tr('password'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(16)),),
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        LoginParamView(
                            hindTitle: true,
                            titleText: tr('password_placeHolder'),
                            hintText: tr("password_placeHolder"),
                            controller: viewModel.passwordController,
                            data: ref.watch(
                                globalValidateDataProvider(viewModel.tagPassword)),
                            isSecure: true,
                            onChanged: viewModel.onPasswordChanged),
                        SizedBox(height: UIDefine.getPixelWidth(10),),
                        TextButtonWidget(
                            setHeight: UIDefine.getPixelWidth(40),
                            radius: 4,
                            isGradient: true,
                            fontWeight: FontWeight.w600,
                            btnText: tr('login'),
                            onPressed: (){
                              viewModel.onPressLogin(context);
                            }),
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        TextButtonWidget(
                            setHeight: UIDefine.getPixelWidth(40),
                            radius: 4,
                            isGradient: true,
                            fontWeight: FontWeight.w600,
                            btnText: tr('registerWithEmail'),
                            onPressed: (){
                              BaseViewModel().pushPage(context, const RegisterMainPage());
                            }),
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Divider(
                              height: UIDefine.getPixelWidth(1),
                              color: AppColors.textPrimary.getColor(),
                            ),
                            Container(
                              alignment: Alignment.center,
                              color: AppColors.mainBackground.getColor(),
                              width: UIDefine.getPixelWidth(100),
                              height: UIDefine.getPixelWidth(50),
                              child: Text('or',style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),),
                            )
                          ],
                        ),
                        TextButtonWidget(
                            setHeight: UIDefine.getPixelWidth(40),
                            radius: 4,
                            setMainColor: AppColors.textPrimary,
                            textColor: AppColors.buttonPrimaryText,
                            fontWeight: FontWeight.w600,
                            btnText: tr('registerWithGoogle'),
                            onPressed: (){}),
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        Visibility(
                          visible: Platform.isIOS,
                            child: TextButtonWidget(
                            setHeight: UIDefine.getPixelWidth(40),
                            radius: 4,
                            setMainColor: AppColors.textPrimary,
                            textColor: AppColors.buttonPrimaryText,
                            fontWeight: FontWeight.w600,
                            btnText: tr('registerWithApple'),
                            onPressed: (){})),
                      ],
                    ),
                  ),
                  SizedBox(height: UIDefine.getHeight()*0.05,),
                  GestureDetector(
                    onTap: (){
                      BaseViewModel().pushPage(context, const ForgetPasswordPage());
                      },
                    child: Text(tr('forgetPassword'),style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize16,
                        color: AppColors.textSubInfo),),
                  )
                ],
              ),
            ),
          )
        )
    );
  }

}


