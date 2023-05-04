import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';
import '../../view_models/gobal_provider/global_tag_controller_provider.dart';
import '../../view_models/login/forget_password_view_model.dart';
import '../../widgets/button/countdown_button_widget.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/label/login_param_view.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  final String emailAddress;
  final String validate;
  const ResetPasswordPage({
    Key? key,
    required this.emailAddress,
    required this.validate,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  late ForgetPasswordViewModel viewModel;

  @override
  void initState() {
    viewModel = ForgetPasswordViewModel(ref);
    viewModel.passwordController.addListener(() {
      setState(() {

      });
      viewModel.rePasswordController.addListener(() {
        setState(() {

        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.registerAppBar(context),
      body: GestureDetector(
        onTap:(){
          BaseViewModel().clearAllFocus();
        },
        child: SingleChildScrollView(
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
                    child: Text(tr('resetPassword'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),),
                  ),
                  SizedBox(height: UIDefine.getHeight()*0.1,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///密碼
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
                        ///確認密碼
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        Text(tr('confirmPW'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(16)),),
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        LoginParamView(
                            hindTitle: true,
                            titleText: tr('confirmPW_placeHolder'),
                            hintText: tr("confirmPW_placeHolder"),
                            controller: viewModel.rePasswordController,
                            data: ref.watch(
                                globalValidateDataProvider(viewModel.tagRePassword)),
                            isSecure: true,
                            onChanged: viewModel.onPasswordChanged),
                      ],
                    ),
                  ),
                  SizedBox(height: UIDefine.getHeight()*0.2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (viewModel.passwordController.text.isNotEmpty&&viewModel.rePasswordController.text.isNotEmpty)?
                      TextButtonWidget(
                          textColor: AppColors.textBlack,
                          isFillWidth: false,
                          setWidth: UIDefine.getPixelWidth(150),
                          setHeight: UIDefine.getPixelWidth(45),
                          isGradient: true,
                          btnText: tr('reset'),
                          onPressed: (){
                            viewModel.onPressReset(context,widget.emailAddress,widget.validate);
                          }):
                      TextButtonWidget(
                          textColor: AppColors.textWhite,
                          isFillWidth: false,
                          setWidth: UIDefine.getPixelWidth(150),
                          setHeight: UIDefine.getPixelWidth(45),
                          setMainColor: AppColors.textGrey,
                          btnText: tr('reset'),
                          onPressed: (){})
                    ],
                  ),
                ],
              ),
            ),)
        ),
      ),
    );
  }
}
