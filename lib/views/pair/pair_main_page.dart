import 'package:flutter/material.dart';

import '../../constant/theme/app_text_style.dart';

class PairMainPage extends StatelessWidget {
  const PairMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("pair", style: AppTextStyle.getBaseStyle()));
  }
}
