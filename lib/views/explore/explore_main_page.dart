import 'package:flutter/material.dart';

import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';

class ExploreMainPage extends StatelessWidget {
  const ExploreMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: UIDefine.getNavigationBarHeight()),
      child: Center(child: Text("explore", style: AppTextStyle.getBaseStyle())),
    );
  }
}
