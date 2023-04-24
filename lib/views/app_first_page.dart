import 'package:flutter/material.dart';

import '../constant/theme/app_routes.dart';
import '../constant/theme/app_text_style.dart';
import '../constant/theme/ui_define.dart';
import '../widgets/button/text_button_widget.dart';
class AppFirstPage extends StatefulWidget {
  const AppFirstPage({Key? key}) : super(key: key);

  @override
  State<AppFirstPage> createState() => _AppFirstPageState();
}

class _AppFirstPageState extends State<AppFirstPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            onTap: () => AppRoutes.pushLogin(context, removeUntil: false),
            child: Text("login", style: AppTextStyle.getBaseStyle())),
        TextButtonWidget(
            btnText: "showMain",
            onPressed: () => AppRoutes.pushRemoveMain(context))
      ],
    )));
  }
}
