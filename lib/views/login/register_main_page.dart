import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/ui_define.dart';
class RegisterMainPage extends StatefulWidget {
  const RegisterMainPage({Key? key}) : super(key: key);

  @override
  State<RegisterMainPage> createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text("register", style: AppTextStyle.getBaseStyle())));
  }
}
