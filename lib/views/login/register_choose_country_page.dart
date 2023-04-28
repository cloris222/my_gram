import 'package:base_project/constant/enum/country_enum.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/login/register_finish_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
import '../../view_models/login/register_preference_choose_provider.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/drop_buttom/custom_drop_button.dart';
import '../../widgets/label/custom_linear_progress.dart';


class registerChooseCountryPage extends ConsumerStatefulWidget {
  const registerChooseCountryPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _registerChooseCountryPageState();
}

class _registerChooseCountryPageState extends ConsumerState<registerChooseCountryPage> {
  List<countryType> countryList = [countryType.Taiwan,countryType.China,countryType.Japan,countryType.Korea,countryType.other];
  String? get countrySection=>ref.read(registerPreferenceChooseProvider).data['countrySection'];
  BaseViewModel viewModel = BaseViewModel();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ref.watch(registerPreferenceChooseProvider);
    return Scaffold(
      body: Container(
        color: Colors.black,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: UIDefine.getHeight()*0.1,),
          Container(
            width: UIDefine.getWidth()*0.9,
            child: Center(
              child: CustomLinearProgress(
                percentage: 1,
                isGradient: true,
                height: UIDefine.getPixelWidth(3),
              ),
            ),
          ),
          SizedBox(height: UIDefine.getHeight()*0.01,),
          Row(
            children: [
              Expanded(child: TextButton(
                child: Icon(Icons.chevron_left,color: Colors.white,size: UIDefine.getPixelWidth(35),),
                onPressed: (){
                  viewModel.popPage(context);
                },
              ),),
              SizedBox(width: UIDefine.getWidth()*0.9,)
            ],
          ),
          SizedBox(height: UIDefine.getHeight()*0.05,),
          Column(
            children: [
              Text(tr('sexChooseTitle'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(20),fontWeight: FontWeight.w500),),
              SizedBox(height: UIDefine.getHeight()*0.08,),
              _buildCountrySectionDropDownBar(),
            ],
          ),
          SizedBox(height: UIDefine.getHeight()*0.3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                fontWeight: FontWeight.w500,
                fontSize: UIDefine.fontSize18,
                radius: 4,
                isGradient: countrySection!='',
                setMainColor: countrySection==''?Colors.grey:Colors.transparent,
                textColor:countrySection==''?AppColors.textWhite:AppColors.textBlack,
                isFillWidth: false,
                backgroundVertical: UIDefine.getPixelWidth(8),
                setHeight: UIDefine.getPixelWidth(44),
                setWidth: UIDefine.getWidth()*0.4,
                btnText: tr('next'),
                onPressed:(){
                  if(countrySection=='')return;
                  viewModel.pushPage(context, registerFinishPage());
                } ,
              ),
            ],)
        ],
      ))
    );
  }

  Widget _buildCountrySectionDropDownBar() {
    return Container(
      width: UIDefine.getWidth()*0.8,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CustomDropButton(
          hintSelect: countrySection==''?tr('chooseCountryHint'):countrySection,
          listLength:countryList.length ,
          itemString: (int index, bool needArrow){
            return countryList[index].getcountryTypeValue();
          },
          onChanged: (int index){
            ref.read(registerPreferenceChooseProvider.notifier).updatecountrySection(countryList[index].getcountryTypeValue());
          },
        ),
      ])
    );
  }
}



countryType getcountryType(String country) {
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

extension CountryTypeExtension on countryType {
  String getcountryTypeValue() {
    switch (this) {
      case countryType.Taiwan:
        return "Taiwan";
      case countryType.China:
        return "China";
      case countryType.Japan:
        return "Japan";
      case countryType.Korea:
        return "Korea";
      default:
        return "other";
    }
  }
}
