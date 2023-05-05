import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/login/register_data_page.dart';
import 'package:base_project/views/login/register_type_page.dart';
import 'package:base_project/views/login/register_with_email_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/app_routes.dart';
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
  BaseViewModel viewModel = BaseViewModel();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.registerAppBar(context),
        body: GestureDetector(
          onTap:()=>BaseViewModel().clearAllFocus(),
          child: SingleChildScrollView(child:
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(7)),
            height: UIDefine.getHeight(),
              width: UIDefine.getWidth(),
              decoration: BoxDecoration(color: Colors.black),
              child:
              Center(
                  child: Column(
                children: [
                  Text(tr('register'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(25)),),
                  SizedBox(height: UIDefine.getHeight()*0.02,),
                  RegisterWithEmailView(),
                  SizedBox(height: UIDefine.getPixelWidth(20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(tr('haveAccount'),style: AppTextStyle.getBaseStyle(),),
                      GestureDetector(
                          onTap: () => AppRoutes.pushLogin(context, removeUntil: false),
                          child: Text(tr("login"), style: AppTextStyle.getGradientStyle())),
                    ],)
                ],
              )
              )
          ))
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
