import 'package:base_project/views/login/register_by_email_view.dart';
import 'package:base_project/views/login/register_by_phone_view.dart';
import 'package:flutter/cupertino.dart';


class RegisterTypePage extends StatefulWidget {
  const RegisterTypePage(
      {super.key, required this.currentType});

  final String currentType;

  @override
  State<StatefulWidget> createState() => _RegisterTypePage();
}

class _RegisterTypePage extends State<RegisterTypePage> {
  String get currentType {
    return widget.currentType;
  }

  @override
  Widget build(BuildContext context) {
    return _initView();
  }

  Widget _initView() {
    if (currentType == 'Phone') {
      return RegisterByPhoneView();
    } else {
      return RegisterByEmailView();
    }
  }
}
