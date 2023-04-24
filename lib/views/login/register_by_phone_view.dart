import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';

class RegisterByPhoneView extends StatefulWidget {
  const RegisterByPhoneView({Key? key}) : super(key: key);

  @override
  State<RegisterByPhoneView> createState() => _RegisterByPhoneViewState();
}

class _RegisterByPhoneViewState extends State<RegisterByPhoneView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('register by phone',style: AppTextStyle.getGradientStyle()));
  }
}
