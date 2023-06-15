import 'package:base_project/view_models/global_theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/theme/app_image_path.dart';
import '../constant/theme/app_routes.dart';
import '../constant/theme/app_text_style.dart';
import '../constant/theme/ui_define.dart';
import '../widgets/button/text_button_widget.dart';
import 'common_scaffold.dart';

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
    return CommonScaffold(
        body: (isDark) => Container(
          width: UIDefine.getWidth(),
          height: UIDefine.getHeight(),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImagePath.loginBgImage,),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),),
          ),
          child: Column(
            children: [
              SizedBox(height: UIDefine.getViewHeight()*0.5,),
              Container(
                width: UIDefine.getPixelWidth(100),
                height: UIDefine.getPixelWidth(120),
                child: Image.asset(AppImagePath.demoImage),
              ),
            ],
          ),
        ));
  }
}
