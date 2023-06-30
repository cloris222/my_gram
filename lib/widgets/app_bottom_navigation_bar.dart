import 'dart:io';

import 'package:base_project/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import '../constant/enum/app_param_enum.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/theme/global_data.dart';
import '../constant/theme/ui_define.dart';
import '../view_models/base_view_model.dart';

typedef AppBottomFunction = Function(AppNavigationBarType type);

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar(
      {Key? key,
      required this.initType,
      this.bottomFunction,
      this.bStartTimer = false})
      : super(key: key);

  final bool bStartTimer;
  final AppNavigationBarType initType;
  final AppBottomFunction? bottomFunction;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar>
    with WidgetsBindingObserver {
  BaseViewModel viewModel = BaseViewModel();

  @override
  void didUpdateWidget(covariant AppBottomNavigationBar oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    /// 生命週期
    WidgetsBinding.instance.addObserver(this);
    GlobalData.mainBottomType = widget.initType;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        GlobalData.printLog('-----App onResumed------');
        break;

      case AppLifecycleState.paused:
        GlobalData.printLog('-----App paused------');
        break;

      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
    }
  }

  @override
  Widget build(BuildContext context) {
    return _barBuilder(context);
  }

  Widget _barBuilder(BuildContext context) {
    return Container(
        color: AppColors.mainBackground.getColor(),
        height: UIDefine.getPixelWidth(Platform.isIOS ? 50 : 40),
        padding: EdgeInsets.only(
            right: UIDefine.getPixelWidth(10),
            left: UIDefine.getPixelWidth(10),
            top: UIDefine.getPixelWidth(8),
            bottom: UIDefine.getPixelWidth(Platform.isIOS ? 15 : 5)),
        child: Row(
          children: [
            buildButton(AppNavigationBarType.typeDynamic),
            buildButton(AppNavigationBarType.typeExplore),
            buildButton(AppNavigationBarType.typePair),
            buildButton(AppNavigationBarType.typeMessage),
            buildButton(AppNavigationBarType.typeCreate),
          ],
        ));
  }

  Widget buildButton(AppNavigationBarType type) {
    return Expanded(
        child: GestureDetector(
            onTap: () => _navigationTapped(
                AppNavigationBarType.values.indexOf(type), setState),
            behavior: HitTestBehavior.translucent,
            child: Center(
              child: getIcon(type),
            )));
  }

  Widget getIcon(AppNavigationBarType type) {
    bool isSelect = (GlobalData.mainBottomType == type);
    String asset = format("${AppImagePath.btnPath}/btn_{name}_{status}.png",
        {"name": type.name, "status": isSelect ? "02" : "01"});

    // 暫時先拔掉
    // return Image.asset(asset,
    //     height: UIDefine.getPixelWidth(25), fit: BoxFit.fitHeight);
    return Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Image.asset(isSelect ? type.onIcon : type.icon));
  }

  _navigationTapped(int index, void Function(VoidCallback fn) setState) {
    var type = AppNavigationBarType.values[index];
    if (type == AppNavigationBarType.typeExplore) {
      return;
    }
    if (widget.bottomFunction != null) {
      setState(() {
        widget.bottomFunction!(type);
      });
    } else {
      //清除所有頁面並回到首頁
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => MainScreen(type: type)),
        ModalRoute.withName('/'),
      );
    }
  }
}
