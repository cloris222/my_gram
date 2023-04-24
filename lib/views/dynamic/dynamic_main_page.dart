import 'package:flutter/material.dart';

import '../../constant/theme/app_text_style.dart';

class DynamicMainPage extends StatelessWidget {
  const DynamicMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("dynamic", style: AppTextStyle.getBaseStyle()));
  }
}
