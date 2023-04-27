import 'package:base_project/constant/enum/country_enum.dart';
import 'package:base_project/constant/enum/gender_enum.dart';
import 'package:base_project/constant/enum/sex_enum.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/enum/gender_enum.dart';
import '../../view_models/login/register_preference_choose_provider.dart';
import '../../widgets/button/text_button_widget.dart';


class registerChooseGenderPage extends ConsumerStatefulWidget {
  const registerChooseGenderPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _registerChooseGenderPageState();
}

class _registerChooseGenderPageState extends ConsumerState<registerChooseGenderPage> {
  List<genderType> genderList = [genderType.male,genderType.female,genderType.other];
  String? get genderSection=>ref.read(registerPreferenceChooseProvider).data['genderSection'];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ref.watch(registerPreferenceChooseProvider);
    List<Widget> buttons =[];
    for(var i = 0; i<genderList.length;i++){
      buttons.add(
        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                isGradient: true,
                isTextGradient: true,
                fontSize: UIDefine.fontSize20,
                radius: 4,
                textColor:AppColors.mainThemeButton,
                isFillWidth: false,
                isBorderStyle: true,
                setMainColor: AppColors.mainThemeButton,
                setSubColor: Colors.transparent,
                backgroundVertical: UIDefine.getPixelWidth(10),
                setHeight: UIDefine.getPixelWidth(44),
                setWidth: UIDefine.getWidth()*0.4,
                btnText: genderList[i].getgenderTypeValue(),
                onPressed:(){
                  ref.read(registerPreferenceChooseProvider.notifier).updategenderSection(genderList[i].getgenderTypeValue());
                  print('genderSection$genderSection');
                } ,
              ),],
          ),
          SizedBox(height: UIDefine.getPixelWidth(10),)
        ],)
        
          );
    }
    return Column(
      children: buttons,
    );
  }
}

genderType getgenderType(String gender) {
  switch (gender) {
    case "male":
      return genderType.male;
    case "female":
      return genderType.female;
    case "other":
      return genderType.other;
    default:
      return genderType.other;
  }
}

extension genderTypeExtension on genderType {
  String getgenderTypeValue() {
    switch (this) {
      case genderType.male:
        return "male";
      case genderType.female:
        return "female";
      case genderType.other:
        return "other";
      default:
        return "other";
    }
  }
}
