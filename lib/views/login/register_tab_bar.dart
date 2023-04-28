import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';

class RegisterTabBar {

  Widget getRegisterButtons(
      {required String currentRegisterType,
        required List<String> dataList,
        required Function(String exploreType) changePage}) {
    List<Widget> buttons = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      bool isCurrent = (dataList[i] == currentRegisterType);
      buttons.add(
          Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
            child: Column(
              children: [
                SizedBox(
                  height: UIDefine.getScreenWidth(12),
                  child: TextButton(
                    onPressed: () {
                      changePage(dataList[i]);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.5), 0, UIDefine.getScreenWidth(3), 0),
                      child: Text(
                        _getTabTitle(dataList[i]),
                        style: isCurrent?AppTextStyle.getGradientStyle(fontSize: UIDefine.fontSize16):AppTextStyle.getBaseStyle(color: AppColors.textWhite,fontSize: UIDefine.getPixelWidth(18)),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                ),
                Container(
                  height: _getLineHeight(isCurrent),
                  decoration: BoxDecoration(gradient:LinearGradient(colors: _getLineColor(isCurrent)) ),
                ),
              ],
            ),
          )
        )
      );
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buttons
    );
  }

  String _getTabTitle(String value) {
    switch(value) {
      case 'Phone':
        return tr('phone');
      case 'Email':
        return tr('email');
    }
    return '';
  }



  double _getLineHeight(bool isCurrent) {
    if (isCurrent) return 2.5;
    return 1;
  }

  List<Color> _getLineColor(bool isCurrent) {
    if (isCurrent) return AppColors.gradientBaseColorBg;
    return [Colors.white,Colors.white];
  }

  List<Color> _getButtonColor(bool isCurrent) {
    if (isCurrent) return AppColors.gradientBaseColorBg;
    return [Colors.grey];
  }

}
