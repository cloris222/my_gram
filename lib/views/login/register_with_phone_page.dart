import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/views/login/register_choose_gender_page.dart';
import 'package:base_project/views/login/register_preference_choose_main_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_image_path.dart';
import '../../models/data/validate_result_data.dart';
import '../../view_models/gobal_provider/global_tag_controller_provider.dart';
import '../../view_models/login/register_main_view_model.dart';
import '../../widgets/button/countdown_button_widget.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/drop_buttom/custom_drop_button.dart';
import '../../widgets/label/error_text_widget.dart';
import '../../widgets/label/login_param_view.dart';

class RegisterWithPhoneView extends ConsumerStatefulWidget {
  const RegisterWithPhoneView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterWithPhoneViewState();
}

class _RegisterWithPhoneViewState extends ConsumerState<RegisterWithPhoneView> {
  int currentAreaNumber = 0;
  late RegisterMainViewModel viewModel;

  bool get isAcceptProtocol =>
      ref.read(globalBoolProvider(viewModel.tagAcceptProtocol));

  @override
  void initState() {
    super.initState();
    viewModel = RegisterMainViewModel(ref);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(globalValidateDataProvider(viewModel.tagEmail));

    ref.watch(globalBoolProvider(viewModel.tagAcceptProtocol));
    Widget space = SizedBox(height: UIDefine.getPixelWidth(10));
    return Container(
      width: UIDefine.getWidth(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('emailAddress'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(16)),),
          space,
          ///手機號碼
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
              viewModel.emailController.text.isNotEmpty?
              CountdownButtonWidget(
                setWidth: UIDefine.getPixelWidth(100),
                setHeight: UIDefine.getPixelWidth(36),
                isGradient: true,
                initEnable: true,
                btnText: tr('getValidate'),
                onPress: () {},
              ):
              TextButtonWidget(
                setMainColor: Colors.grey,
                setWidth: UIDefine.getPixelWidth(100),
                setHeight: UIDefine.getPixelWidth(36),
                isFillWidth: false,
                btnText: tr('getValidate'),
                onPressed: (){},
              )
            ],),
          space,
          ///密碼
          Text(tr('password'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(16)),),
          space,
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
          space,
          Text(tr('confirmPW'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(16)),),
          space,
          LoginParamView(
            hindTitle: true,
            titleText: tr('confirmPW_placeHolder'),
            hintText: tr("confirmPW_placeHolder"),
            controller: viewModel.rePasswordController,
            data: ref.watch(
              globalValidateDataProvider(viewModel.tagRePassword)),
              isSecure: true,
              onChanged: viewModel.onPasswordChanged),
          space,
          Center(child: _buildAcceptProtocol()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                setWidth: UIDefine.getPixelWidth(100),
                radius: 4,
                textColor: AppColors.textBlack,
                isFillWidth: false,
                isGradient: true,
                btnText: tr('next'),
                onPressed: (){
                  if(viewModel.checkNotEmpty() && viewModel.checkSendRequest()){
                    viewModel.pushPage(context,const registerChooseGenderPage());
                  }
                },
              )
            ],),
        ],
      ));
  }

  Widget _buildAcceptProtocol() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            GestureDetector(
                onTap: _onAcceptPress,
                child: Container(
                  padding: EdgeInsets.only(
                      top: UIDefine.getPixelWidth(10),
                      bottom: UIDefine.getPixelWidth(10),
                      right: UIDefine.getPixelWidth(10)),

                  child: Container(
                    width: UIDefine.getPixelWidth(20),
                    height: UIDefine.getPixelWidth(20),
                    child:Image.asset(isAcceptProtocol
                      ? AppImagePath.checkedIcon:AppImagePath.unCheckedIcon
                    ),)
                )),
            GestureDetector(
              onTap: _onAcceptPress,
              child: Container(
                color: Colors.transparent,
                child: Text(tr('registerTermHint'),
                    style:
                    AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14)),
              ),
            ),
            SizedBox(width: UIDefine.getPixelWidth(10)),
            GestureDetector(
              onTap: viewModel.showAcceptProtocol,
              child: Container(
                color: Colors.transparent,
                child: Text(tr('registerTerm'),
                    style: AppTextStyle.getGradientStyle()),
              ),
            ),
          ],
        ),
        SizedBox(height: UIDefine.getPixelWidth(1)),
        ErrorTextWidget(data:ref.watch(
            globalValidateDataProvider(viewModel.tagAcceptProtocol)), alignment: Alignment.center),
      ],
    );
  }

  void _onAcceptPress() {
      ref.read(
          globalValidateDataProvider(viewModel.tagAcceptProtocol)
      .notifier)
      .update((state) =>ValidateResultData());
      ref
          .read(globalBoolProvider(viewModel.tagAcceptProtocol)
          .notifier)
          .update((state) => !isAcceptProtocol);

  }

}



