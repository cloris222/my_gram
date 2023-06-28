import 'package:base_project/constant/enum/app_param_enum.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:base_project/view_models/message/message_private_message_view_model.dart';
import 'package:base_project/views/login/register_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  child: Row(mainAxisAlignment: mainAxisAlignment, children: actions)))
        ]);
  }

  static AppBar getCustomAppBar({required List<Widget> actions}) {
    return _getCustomAppBar(actions: actions);
  }

  static AppBar registerAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainBackground.getColor(),
        centerTitle: true,
        title: Image.asset(AppImagePath.logoTextImage),
        // title: Text("MyGram", style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize36)),
        // actions: <Widget>[IconButton(onPressed: () {}, icon: const Icon(Icons.language))]
    );
  }

  static AppBar mainAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainBackground.getColor(),
        centerTitle: true,
        title: Text("MyGram", style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize36)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                BaseViewModel().pushPage(context, RegisterMainPage());
              },
              icon: Icon(
                Icons.store_mall_directory,
                color: AppColors.iconPrimary.getColor(),
              ))
        ]);
  }

  static AppBar titleAppBar(BuildContext context, {required String title, onClickFunction? onPressBack}) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.mainBackground.getColor(),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            if (onPressBack == null) {
              Navigator.pop(context);
            } else {
              onPressBack();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.iconPrimary.getColor(),
          )),
      title: Text(title, style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize36)),
    );
  }

  static AppBar personalAppBar(BuildContext context, {required String title, onClickFunction? onPressBack}) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          if (onPressBack == null) {
            Navigator.pop(context);
          } else {
            onPressBack();
          }
        },
        child: Image.asset(AppImagePath.arrowLeft),
      ),
      title: Text(title, style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w600)),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Image.asset(AppImagePath.hotIcon),
        )
      ],
    );
  }

  static AppBar chatRoomAppBar(
    WidgetRef ref,
    BuildContext context, {
    required String nickName,
    required String avatar,
    onClickFunction? onPressBack,
  }) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.mainBackground.dark,
      titleSpacing: 0,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: IconButton(
            onPressed: () {
              if (onPressBack == null) {
                // Navigator.pop(context);
                BaseViewModel().changeMainScreenPage(AppNavigationBarType.typePair);
              } else {
                onPressBack();
              }
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.iconPrimary.getColor())),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AvatarIconWidget(
            imageUrl: avatar,
          ),
          SizedBox(
            width: UIDefine.getPixelWidth(10),
          ),
          Text(nickName, style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16)),
          ref.watch(showImageWallProvider)?
          Container():
          IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.buttonCameraBg.light,
              ),
              onPressed: () {
                bool open = true;
                MessagePrivateGroupMessageViewModel(ref).changeImgWallState(open);
              })
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(7), horizontal: UIDefine.getPixelWidth(10)),
          child: Container(
              width: UIDefine.getPixelWidth(40),
              // height: UIDefine.getPixelWidth(40),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.buttonCameraBg.light,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  border: Border.all(color: AppColors.buttonCameraBg.dark, width: 1)),
              child: IconButton(
                // iconSize: ,
                onPressed: () {
                  BaseViewModel().pushPage(context, RegisterMainPage());
                },
                icon: Icon(Icons.search),
              )),
        )
      ],
    );
  }
}
