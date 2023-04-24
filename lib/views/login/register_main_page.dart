import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/views/login/register_tab_bar.dart';
import 'package:base_project/views/login/register_type_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/ui_define.dart';
import '../../widgets/appbar/custom_app_bar.dart';
class RegisterMainPage extends StatefulWidget {
  const RegisterMainPage({Key? key}) : super(key: key);

  @override
  State<RegisterMainPage> createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {
  String currentRegisterType = 'Phone';
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];
  List<String> dataList = ['Phone', 'Email'];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.mainAppBar(context),
        body: Container(
          width: UIDefine.getWidth(),
          decoration: BoxDecoration(color: Colors.black),
            child: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: UIDefine.getPixelWidth(10),),
            Text(tr("register"), style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(24))),
            RegisterTabBar().getRegisterButtons(
                currentRegisterType:currentRegisterType,
                dataList: dataList,
                changePage: (String value) {
                  print(value);
                }
            ),
            SizedBox(height: UIDefine.getPixelWidth(20),),
            Flexible(
                child: PageView(
                  controller: pageController,
                  onPageChanged: _onPageChange,
                  children: pages,
                ))

          ],))
        ));
  }

  @override
  void initState() {
    super.initState();
    _setPage();
  }

  void _setPage() {
    pages = List<Widget>.generate(
        dataList.length,
        (index) => RegisterTypePage(
            currentType: dataList[index],
            ));
   print(pages.length);
  }


  void _changePage(String registerType) {
    setState(() {
      currentRegisterType = registerType;
      pageController.jumpToPage(_getRegisterTypeIndex(currentRegisterType));
    });
  }

  void _onPageChange(int value) {
    setState(() {
      currentRegisterType = dataList[value];
      // listController.jumpTo(value * 25);
    });
  }

  int _getRegisterTypeIndex(String type) {
    for (int i = 0; i < dataList.length; i++) {
      if (type == dataList[i]) {
        return i;
      }
    }
    return -1;
  }


}
