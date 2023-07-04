import 'package:base_project/constant/enum/app_param_enum.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/main.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:base_project/view_models/message/message_private_message_view_model.dart';
import 'package:base_project/views/login/register_main_page.dart';
import 'package:easy_localization/easy_localization.dart';
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

  static AppBar personalAppBar(BuildContext context, {required double height}) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: height,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap:(){
                // Navigator.pop(context);
                BaseViewModel().changeMainScreenPage( AppNavigationBarType.typePair);
              },
              child: Container(
                  width: UIDefine.getPixelWidth(24),
                  height: UIDefine.getPixelWidth(24),
                  child: Image.asset(AppImagePath.arrowLeft,fit: BoxFit.fill,))),
          Expanded(child: Container()),
          Text(
            'Rebecca',
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize16,
                fontWeight: FontWeight.w600),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {},
            child: Container(
                width: UIDefine.getPixelWidth(30),
                height: UIDefine.getPixelWidth(30),
                child: Image.asset(AppImagePath.hotIcon,fit: BoxFit.fill,)),
          )
        ],
      ),
    );
  }

  static AppBar actionWordAppBar(
    BuildContext context, {
    required String title,
    required String actionWord,
    onClickFunction? pressApply,
    onClickFunction? onPressBack,
  }) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.mainBackground.dark,
      titleSpacing: 0,
      leading: Padding(
        padding: EdgeInsets.all(0),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      title: Container(
        child: Text("$title"),
      ),
      actions: [
        Container(
          child: GestureDetector(
            child: Text("$actionWord").tr(),
          ),
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
        child: Container(
          width: UIDefine.getPixelWidth(24),
          // height: UIDefine.getPixelHeight(24),
          child: IconButton(
              onPressed: () {
                if (onPressBack == null) {
                  FocusScope.of(context).unfocus();
                  // Navigator.pop(context);
                  BaseViewModel().changeMainScreenPage(AppNavigationBarType.typePersonal);
                } else {
                  onPressBack();
                }
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.iconPrimary.getColor())),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: UIDefine.getPixelWidth(8)),
            child: AvatarIconWidget(
              imageUrl: avatar,
            ),
          ),
          Flexible(
              child: Container(
                  child: Text(nickName,
                      style:
                          AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16, overflow: TextOverflow.ellipsis)))),
          ref.watch(showImageWallProvider)
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(left: UIDefine.getPixelWidth(8)),
                  child: Container(
                    alignment: Alignment.center,
                    width: UIDefine.getPixelWidth(24),
                    child: GestureDetector(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.buttonCameraBg.light,
                      ),
                      onTap: () {
                        bool open = true;
                        MessagePrivateGroupMessageViewModel(ref).changeImgWallState(open);
                      },
                    ),
                  ),
                ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
            UIDefine.getPixelWidth(30),
            UIDefine.getPixelHeight(7),
            UIDefine.getPixelWidth(16),
            UIDefine.getPixelHeight(7),
          ),
          child: Row(
            children: [
              Container(
                width: UIDefine.getPixelWidth(32),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    color: AppColors.buttonCameraBg.light,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: AppColors.buttonCameraBg.dark, width: 1)),
                child: GestureDetector(
                  child: Image.asset(AppImagePath.searchIcon),
                ),
              ),
              SizedBox(
                width: UIDefine.getPixelWidth(16),
              ),
              Container(
                width: UIDefine.getPixelWidth(32),
                // height: UIDefine.getPixelWidth(40),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    color: AppColors.buttonCameraBg.light,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: AppColors.buttonCameraBg.dark, width: 1)),
                child: GestureDetector(
                  child: Image.asset(AppImagePath.otherIcon),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
