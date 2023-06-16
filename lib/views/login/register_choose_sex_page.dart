import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/login/register_choose_country_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/enum/user_enum.dart';
import '../../view_models/login/register_param_provider.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/label/custom_linear_progress.dart';
import '../common_scaffold.dart';

class RegisterChooseSexPage extends ConsumerStatefulWidget {
  const RegisterChooseSexPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterChooseSexPageState();
}

class _RegisterChooseSexPageState extends ConsumerState<RegisterChooseSexPage> {
  List<GenderType> get genderList => GenderType.values;

  String get sexSection => ref.read(registerParamProvider).preferGender;
  BaseViewModel viewModel = BaseViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerParamProvider);
    List<Widget> buttons = [];
    for (var i = 0; i < genderList.length; i++) {
      bool isSelected = (sexSection == genderList[i].name);
      buttons.add(Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                isTextGradient: !isSelected,
                fontSize: UIDefine.fontSize18,
                radius: 4,
                isGradient: isSelected,
                textColor: isSelected
                    ? AppColors.buttonPrimaryText
                    : AppColors.mainThemeButton,
                isFillWidth: false,
                isBorderStyle: !isSelected,
                isBorderGradient: true,
                setMainColor: AppColors.mainThemeButton,
                setSubColor: AppColors.transparent,
                backgroundVertical: UIDefine.getPixelWidth(8),
                setHeight: UIDefine.getPixelWidth(44),
                setWidth: UIDefine.getWidth() * 0.4,
                btnText: tr(genderList[i].name.toLowerCase()),
                onPressed: () {
                  ref
                      .read(registerParamProvider.notifier)
                      .setPreferGender(genderList[i].name);
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
                SizedBox(
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
                        if (sexSection.isNotEmpty) {
                          viewModel.pushPage(
                              context, const RegisterChooseCountryPage());
                        }
                      },
                    ),
                  ],
                )
              ],
            ));
  }
}
