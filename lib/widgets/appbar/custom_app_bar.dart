import 'package:base_project/constant/enum/app_param_enum.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:base_project/view_models/create/create_main_view_model.dart';
import 'package:base_project/view_models/message/message_private_message_view_model.dart';
import 'package:base_project/views/login/register_main_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_style.dart';
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

      flexibleSpace:Container(
          height:height,
          width: UIDefine.getWidth(),
          decoration: AppStyle().styleShadowBorderBackground(
              borderBgColor: Colors.transparent,
              shadowColor: AppColors.textBlack.getColor().withOpacity(0.4),
              radius: 5,
              offsetX: 0,
              offsetY: 0.5,
              blurRadius: 70),
        child: Column(
          children: [
            SizedBox(height: UIDefine.getStatusBarHeight() + UIDefine.getPixelWidth(15)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
          ],
        ),
      ),
      toolbarHeight:height,
    );
  }

  static AppBar popularCreateAppBar(
    WidgetRef ref,
    BuildContext context, {
    required String title,
    required String actionWord,
    onClickFunction? pressApply,
    onClickFunction? onPressBack,
  }) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      leading: Padding(
        padding: EdgeInsets.only(left: UIDefine.getPixelWidth(16)),
        child: IconButton(
          onPressed: () {
            if (onPressBack == null) {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
              // BaseViewModel().changeMainScreenPage(AppNavigationBarType.typeCreate);
            } else {
              onPressBack();
            }
          },
          icon:Image.asset(AppImagePath.arrowLeft),
        ),
      ),
      title: Container(
        child: Text(
          "$title",
          style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16, color: AppColors.textPrimary),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: UIDefine.getPixelWidth(16)),
          child: Container(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Text(
                "$actionWord".tr(),
                style: AppTextStyle.getBaseStyle(
                  color: ref.watch(popularSelectIdProvider).isNotEmpty || ref.watch(hotSelectIdProvider).isNotEmpty
                      ? AppColors.subThemePurple
                      : AppColors.textWhiteOpacity5,
                  fontSize: UIDefine.fontSize16,
                ),
              ),
              onTap: () {
                if (pressApply != null) {
                  pressApply();
                }
                // ref.read(popularSelectIdProvider.notifier).update((state) => "");
                // ref.read(hotSelectIdProvider.notifier).update((state) => "");
              },
            ),
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
          child: GestureDetector(
            child: Image.asset(AppImagePath.arrowLeft),
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (onPressBack == null) {
                BaseViewModel().changeMainScreenPage(AppNavigationBarType.typePersonal);
              } else {
                onPressBack();
              }
            },
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: UIDefine.getPixelWidth(8)),
            child: Container(
              height: UIDefine.getPixelWidth(32),
              width: UIDefine.getPixelWidth(32),
              child: AvatarIconWidget(
                imageUrl: avatar,
              ),
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
                    color: Color.fromARGB(65, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: AppColors.buttonCameraBg.dark, width: 0.5)),
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
                    color: Color.fromARGB(65, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: AppColors.buttonCameraBg.dark, width: 0.5)),
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
