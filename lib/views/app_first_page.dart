import 'package:easy_localization/easy_localization.dart';
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
        body: Container(
          width: UIDefine.getWidth(),
          decoration: BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: UIDefine.getHeight()*0.5,),
                Text('Mygram',style: AppTextStyle.getBaseStyle(fontSize: UIDefine.getPixelWidth(30),fontWeight: FontWeight.w500),),
                SizedBox(height: UIDefine.getHeight()*0.07),
                GestureDetector(
                    onTap: () => AppRoutes.pushRegister(context, removeUntil: false),
                    child: Text(tr('registerHint'), style: AppTextStyle.getGradientStyle())),
                SizedBox(height: UIDefine.getHeight()*0.25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(tr('haveAccount'),style: AppTextStyle.getBaseStyle(),),
                  GestureDetector(
                      onTap: () => AppRoutes.pushLogin(context, removeUntil: false),
                      child: Text(tr("login"), style: AppTextStyle.getGradientStyle())),
                ],)


                // TextButtonWidget(
                //     btnText: "showMain",
                //     onPressed: () => AppRoutes.pushRemoveMain(context))
              ],
            ))
      );
  }
}
