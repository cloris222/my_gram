import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/label/custom_gradient_icon.dart';
import 'dynamic_info_view.dart';

class DynamicMainPage extends StatefulWidget {
  const DynamicMainPage({Key? key}) : super(key: key);

  @override
  State<DynamicMainPage> createState() => _DynamicMainPageState();
}

class _DynamicMainPageState extends State<DynamicMainPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(child: CustomGradientIcon(
        icon:Icons.favorite,
        size: 60.0,
        gradient:LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red, Colors.yellow,Colors.green],
        ),
      ),));
  }

  void _onFollow(int value) {
  }
}
