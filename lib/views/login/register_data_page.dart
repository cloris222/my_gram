import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_image_path.dart';
import '../../view_models/gobal_provider/global_tag_controller_provider.dart';
import '../../view_models/login/register_main_view_model.dart';
import '../../widgets/button/countdown_button_widget.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/drop_buttom/custom_drop_button.dart';
import '../../widgets/label/login_param_view.dart';

class RegisterDataView extends ConsumerStatefulWidget {
  const RegisterDataView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterDataViewState();
}

class _RegisterDataViewState extends ConsumerState<RegisterDataView> {
  int currentAreaNumber = 0;
  List<String> areaNumber = ['123', '456', '789'];
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
    Widget space = SizedBox(height: UIDefine.getPixelWidth(5));
    return Container(
      width: UIDefine.getWidth(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('phone'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(16)),),
          space,
          ///手機號碼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///區碼
              IntrinsicWidth(child:
              CustomDropButton(
                dropdownWidth: UIDefine.getPixelWidth(100),
                hintSelect: areaNumber[currentAreaNumber],
                listLength: areaNumber.length,
                itemString: (int index, bool needArrow) => areaNumber[index],
                onChanged: (int index) => currentAreaNumber = index,
              )),
              SizedBox(width: UIDefine.getPixelWidth(10),),
              ///手機號碼
              Expanded(
                child: LoginParamView(
                  keyboardType: TextInputType.phone,
                    hindTitle: true,
                    titleText: tr('phone'),
                    hintText: tr("phone"),
                    controller: viewModel.phoneController,
                    data: ref.watch(
                        globalValidateDataProvider(viewModel.tagPhone)),
                    onChanged: (String value) {
                      value = viewModel.phoneController.text;
                      viewModel.onPhoneChanged(value);
                    }
                ),)
            ],
          ),
          ///驗證碼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ///輸入驗證碼
              Expanded(
                child: LoginParamView(
                  keyboardType: TextInputType.number,
                  hindTitle: true,
                  titleText: tr('validateHint'),
                  hintText: tr("validateHint"),
                  controller: viewModel.validateController,
                  data: ref.watch(
                      globalValidateDataProvider(viewModel.tagValidate)),
                ),),
            SizedBox(width: UIDefine.getPixelWidth(10),),
            ///獲取驗證碼btn
              CountdownButtonWidget(
                radius: 4,
                setHeight: UIDefine.getPixelWidth(36),
                isGradient: true,
                initEnable: false,
                btnText: tr('getValidate'),
                onPress: (){},
              )
          ],),
          space,
          ///密碼
          Text(tr('password'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(16)),),
          space,
          LoginParamView(
              hindTitle: true,
              titleText: tr('password'),
              hintText: tr("password"),
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
            titleText: tr('confirmPW'),
            hintText: tr("confirmPW"),
            controller: viewModel.rePasswordController,
            data: ref.watch(
              globalValidateDataProvider(viewModel.tagRePassword)),
              isSecure: true,
              onChanged: viewModel.onPasswordChanged),
          space,
          Center(child: _buildAcceptProtocol())

        ],
      ));
  }

  Widget _buildAcceptProtocol() {
    ref.watch(
        globalValidateDataProvider(viewModel.tagAcceptProtocol));
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
                      ? AppImagePath.unCheckedIcon
                      : AppImagePath.checkedIcon),)
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
            SizedBox(width: UIDefine.getPixelWidth(10)),
          ],
        ),
      ],
    );
  }

  void _onAcceptPress() {
    ref
        .read(globalBoolProvider(viewModel.tagAcceptProtocol)
        .notifier)
        .update((state) => !isAcceptProtocol);
    print('isAcceptProtocol$isAcceptProtocol');
  }

}



