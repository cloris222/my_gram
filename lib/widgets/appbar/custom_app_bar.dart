import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:base_project/views/login/login_main_page.dart';
import 'package:base_project/views/login/register_main_page.dart';
import 'package:base_project/views/login/register_with_email_page.dart';
import 'package:flutter/material.dart';

import '../label/avatar_icon_widget.dart';

class CustomAppBar {
  const CustomAppBar._();

  static AppBar _getCustomAppBar(
      {required List<Widget> actions,
      double? appBarHeight,
      ShapeBorder? shape,
      Color color = Colors.black,
      Color? fillColor,
      EdgeInsetsGeometry? margin,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: color,
        toolbarHeight: appBarHeight,
        shape: shape,
        actions: <Widget>[
          Expanded(
              child: Container(
                  margin: margin,
                  color: fillColor,
                  constraints: const BoxConstraints.expand(),
                  child: Row(
                      mainAxisAlignment: mainAxisAlignment, children: actions)))
        ]);
  }

  static AppBar getCustomAppBar({required List<Widget> actions}) {
    return _getCustomAppBar(actions: actions);
  }

  static AppBar registerAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("MyGram",
            style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize36)),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.language))
        ]);
  }

  static AppBar mainAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("MyGram",
            style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize36)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                BaseViewModel().pushPage(context, RegisterMainPage());
              }, icon: const Icon(Icons.store_mall_directory))
        ]);
  }

  static AppBar titleAppBar(BuildContext context,
      {required String title, onClickFunction? onPressBack}) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            if (onPressBack == null) {
              Navigator.pop(context);
            } else {
              onPressBack();
            }
          },
          icon: const Icon(Icons.arrow_back_ios)),
      title: Text(title,
          style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize36)),
    );
  }

  static AppBar chatRoomAppBar(BuildContext context,{required String nickName,required String avatar, onClickFunction? onPressBack}) {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.dialogBackground,
        leading: IconButton(
            onPressed: () {
              if (onPressBack == null) {
                Navigator.pop(context);
              } else {
                onPressBack();
              }
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AvatarIconWidget(
              imageUrl:avatar ,
            ),
            SizedBox(width: UIDefine.getPixelWidth(10),),
            Text(nickName,
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16)),
          ],
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                BaseViewModel().pushPage(context, RegisterMainPage());
              }, icon: const Icon(Icons.search))
        ],
       );
  }
}
