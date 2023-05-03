import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/personal/personal_home_page.dart';
import 'package:flutter/material.dart';

class PersonalMainPage extends StatelessWidget {
  const PersonalMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          BaseViewModel().pushPage(context, PersonalHomePage());
        },
        child: Text('push to change page'));
  }
}
