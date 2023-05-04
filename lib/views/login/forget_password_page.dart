import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_routes.dart';
import '../../view_models/gobal_provider/global_tag_controller_provider.dart';
import '../../view_models/login/forget_password_view_model.dart';
import '../../widgets/button/countdown_button_widget.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/label/login_param_view.dart';

class ForgetPasswordPage extends ConsumerStatefulWidget {
  const ForgetPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends ConsumerState<ForgetPasswordPage> {
  late ForgetPasswordViewModel viewModel;

  @override
  void initState() {
    viewModel = ForgetPasswordViewModel(ref);
    viewModel.emailController.addListener(() {
      setState(() {

      });
      viewModel.validateController.addListener(() {
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
    ref.watch(globalValidateDataProvider(viewModel.tagEmail));
    ref.watch(globalValidateDataProvider(viewModel.tagValidate));
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
              SizedBox(height: UIDefine.getHeight()*0.1,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(7)),
                child: Column(
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
                          value = viewModel.emailController.text;
                          viewModel.onEmailChanged(value);
                        }
                    ),
                    ///驗證碼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///輸入驗證碼
                        Expanded(
                          child: LoginParamView(
                            keyboardType: TextInputType.number,
                            hindTitle: true,
                            titleText: tr('validateHint_placeHolder'),
                            hintText: tr("validateHint_placeHolder"),
                            controller: viewModel.validateController,
                            data: ref.watch(
                                globalValidateDataProvider(viewModel.tagValidate)),
                          ),),
                        SizedBox(width: UIDefine.getPixelWidth(10),),
                        ///獲取驗證碼btn
                        viewModel.emailController.text.isEmpty?
                        TextButtonWidget(
                          setMainColor: Colors.grey,
                          setWidth: UIDefine.getPixelWidth(100),
                          setHeight: UIDefine.getPixelWidth(36),
                          isFillWidth: false,
                          btnText: tr('getValidate'),
                          onPressed: (){},
                        ):
                        CountdownButtonWidget(
                          setWidth: UIDefine.getPixelWidth(100),
                          setHeight: UIDefine.getPixelWidth(36),
                          isGradient: true,
                          initEnable: true,
                          btnText: tr('getValidate'),
                          onPress: () {},
                        )
                      ],),
                  ],
                ),
              ),
              SizedBox(height: UIDefine.getHeight()*0.2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (viewModel.emailController.text.isNotEmpty&&viewModel.validateController.text.isNotEmpty)?
                  TextButtonWidget(
                      textColor: AppColors.textBlack,
                      isFillWidth: false,
                      setWidth: UIDefine.getPixelWidth(150),
                      setHeight: UIDefine.getPixelWidth(45),
                      isGradient: true,
                      btnText: tr('next'),
                      onPressed: (){
                        viewModel.onPressNext(context);
                      }):
                  TextButtonWidget(
                      textColor: AppColors.textWhite,
                      isFillWidth: false,
                      setWidth: UIDefine.getPixelWidth(150),
                      setHeight: UIDefine.getPixelWidth(45),
                      setMainColor: AppColors.textGrey,
                      btnText: tr('next'),
                      onPressed: (){})
                ],
              ),
              SizedBox(height: UIDefine.getHeight()*0.1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tr('haveAccount'),style: AppTextStyle.getBaseStyle(),),
                  GestureDetector(
                      onTap: () => AppRoutes.pushLogin(context, removeUntil: false),
                      child: Text(tr("login"), style: AppTextStyle.getGradientStyle())),
                ],)
            ],
          ),
        ),)

      ),
    );
  }
}
