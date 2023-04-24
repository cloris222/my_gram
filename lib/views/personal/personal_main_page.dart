import 'package:flutter/material.dart';

import '../../constant/theme/app_text_style.dart';

class PersonalMainPage extends StatelessWidget {
  const PersonalMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("personal", style: AppTextStyle.getBaseStyle()));
  }
}
