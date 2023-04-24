import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/ui_define.dart';
class LoginMainPage extends StatefulWidget {
  const LoginMainPage({Key? key}) : super(key: key);

  @override
  State<LoginMainPage> createState() => _LoginMainPageState();
}

class _LoginMainPageState extends State<LoginMainPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text(tr("login"), style: AppTextStyle.getBaseStyle())));
  }
}
