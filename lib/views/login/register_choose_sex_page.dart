import 'package:base_project/constant/enum/sex_enum.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/login/register_choose_country_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_models/login/register_preference_choose_provider.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/label/custom_linear_progress.dart';
import '../common_scaffold.dart';

class registerChooseSexPage extends ConsumerStatefulWidget {
  const registerChooseSexPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _registerChooseSexPageState();
}

class _registerChooseSexPageState extends ConsumerState<registerChooseSexPage> {
  List<sexType> sexList = [sexType.male, sexType.female, sexType.other];

  String? get sexSection =>
      ref.read(registerPreferenceChooseProvider).data['sexSection'];
  BaseViewModel viewModel = BaseViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerPreferenceChooseProvider);
    List<Widget> buttons = [];
    for (var i = 0; i < sexList.length; i++) {
      buttons.add(Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                isTextGradient: sexSection != sexList[i].name,
                fontSize: UIDefine.fontSize18,
                radius: 4,
                isGradient: sexSection == sexList[i].name,
                textColor: sexSection == sexList[i].name
                    ? AppColors.buttonPrimaryText
                    : AppColors.mainThemeButton,
                isFillWidth: false,
                isBorderStyle: sexSection != sexList[i].name,
                isBorderGradient: true,
                setMainColor: AppColors.mainThemeButton,
                setSubColor: AppColors.transparent,
                backgroundVertical: UIDefine.getPixelWidth(8),
                setHeight: UIDefine.getPixelWidth(44),
                setWidth: UIDefine.getWidth() * 0.4,
                btnText: sexList[i].name,
                onPressed: () {
                  ref
                      .read(registerPreferenceChooseProvider.notifier)
                      .updateSexSection(sexList[i].name);
                },
              ),
            ],
          ),
          SizedBox(
            height: UIDefine.getPixelWidth(10),
          )
        ],
      ));
    }
    return CommonScaffold(
        body: (isDark) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: UIDefine.getHeight() * 0.1,
                ),
                Container(
                  width: UIDefine.getWidth() * 0.9,
                  child: Center(
                    child: CustomLinearProgress(
                      percentage: 0.66,
                      isGradient: true,
                      height: UIDefine.getPixelWidth(3),
                    ),
                  ),
                ),
                SizedBox(
                  height: UIDefine.getHeight() * 0.01,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: UIDefine.getPixelWidth(35),
                        ),
                        onPressed: () {
                          viewModel.popPage(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: UIDefine.getWidth() * 0.9,
                    )
                  ],
                ),
                SizedBox(
                  height: UIDefine.getHeight() * 0.05,
                ),
                Column(
                  children: [
                    Text(
                      tr('sexChooseTitle'),
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.getPixelWidth(20),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: UIDefine.getHeight() * 0.08,
                    ),
                    Column(
                      children: buttons,
                    ),
                    SizedBox(
                      height: UIDefine.getHeight() * 0.1,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButtonWidget(
                      fontSize: UIDefine.fontSize18,
                      radius: 4,
                      isGradient: sexSection != '',
                      setMainColor: sexSection == ''
                          ? AppColors.buttonUnable
                          : AppColors.transparent,
                      textColor: sexSection == ''
                          ? AppColors.textPrimary
                          : AppColors.buttonPrimaryText,
                      isFillWidth: false,
                      backgroundVertical: UIDefine.getPixelWidth(8),
                      setHeight: UIDefine.getPixelWidth(44),
                      setWidth: UIDefine.getWidth() * 0.4,
                      btnText: tr('next'),
                      onPressed: () {
                        if (sexSection == '') return;
                        viewModel.pushPage(
                            context, const registerChooseCountryPage());
                      },
                    ),
                  ],
                )
              ],
            ));
  }

  sexType getSexType(String sex) {
    switch (sex) {
      case "male":
        return sexType.male;
      case "female":
        return sexType.female;
      case "other":
        return sexType.other;
      default:
        return sexType.other;
    }
  }
}
