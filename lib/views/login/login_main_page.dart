import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class LoginMainPage extends StatelessWidget {
  const LoginMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text("login", style: AppTextStyle.getBaseStyle())));
  }
}
