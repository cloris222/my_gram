import 'package:base_project/constant/enum/country_enum.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:base_project/views/login/register_finish_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
import '../../view_models/login/register_param_provider.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/drop_buttom/custom_drop_button.dart';
import '../../widgets/label/custom_linear_progress.dart';
import '../common_scaffold.dart';

class RegisterChooseCountryPage extends ConsumerStatefulWidget {
  const RegisterChooseCountryPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterChooseCountryPageState();
}

class _RegisterChooseCountryPageState
    extends ConsumerState<RegisterChooseCountryPage> {
  List<countryType> countryList = [
    countryType.Taiwan,
    countryType.China,
    countryType.Japan,
    countryType.Korea,
    countryType.other
  ];

  String get countrySection => ref.read(registerParamProvider).country;
  BaseViewModel viewModel = BaseViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerParamProvider);
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
                      percentage: 1,
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
                      tr('countryChooseTitle'),
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.getPixelWidth(20),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: UIDefine.getHeight() * 0.08,
                    ),
                    _buildCountrySectionDropDownBar(),
                  ],
                ),
                SizedBox(
                  height: UIDefine.getHeight() * 0.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButtonWidget(
                      fontWeight: FontWeight.w500,
                      fontSize: UIDefine.fontSize18,
                      radius: 4,
                      isGradient: countrySection != '',
                      setMainColor: countrySection == ''
                          ? AppColors.buttonUnable
                          : AppColors.transparent,
                      textColor: countrySection == ''
                          ? AppColors.textPrimary
                          : AppColors.buttonPrimaryText,
                      isFillWidth: false,
                      backgroundVertical: UIDefine.getPixelWidth(8),
                      setHeight: UIDefine.getPixelWidth(44),
                      setWidth: UIDefine.getWidth() * 0.4,
                      btnText: tr('next'),
                      onPressed: () {
                        if (countrySection.isNotEmpty) {
                          ref
                              .read(userInfoProvider.notifier)
                              .registerWithMail(
                                  data: ref.read(registerParamProvider))
                              .then((value) {
                            viewModel.pushPage(context, RegisterFinishPage());
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ));
  }

  Widget _buildCountrySectionDropDownBar() {
    return SizedBox(
        width: UIDefine.getWidth() * 0.8,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomDropButton(
            hintSelect:
                countrySection == '' ? tr('chooseCountryHint') : countrySection,
            listLength: countryList.length,
            itemString: (int index, bool needArrow) {
              return countryList[index].name;
            },
            onChanged: (int index) {
              ref.read(registerParamProvider.notifier).setCountry(
                  country: countryList[index].name,
                  areaCode: countryList[index].areaCode);
            },
          ),
        ]));
  }

  countryType getCountryType(String country) {
    switch (country) {
      case "Taiwan":
        return countryType.Taiwan;
      case "China":
        return countryType.China;
      case "Japan":
        return countryType.Japan;
      case "Korea":
        return countryType.Korea;
      default:
        return countryType.other;
    }
  }
}
