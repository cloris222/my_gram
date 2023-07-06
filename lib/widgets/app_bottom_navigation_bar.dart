import 'dart:io';

import 'package:base_project/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import '../constant/enum/app_param_enum.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/theme/global_data.dart';
import '../constant/theme/ui_define.dart';
import '../view_models/base_view_model.dart';

typedef AppBottomFunction = Function(AppNavigationBarType type);

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({Key? key, required this.initType, this.bottomFunction, this.bStartTimer = false}) : super(key: key);

  final bool bStartTimer;
  final AppNavigationBarType initType;
  final AppBottomFunction? bottomFunction;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> with WidgetsBindingObserver {
  BaseViewModel viewModel = BaseViewModel();
  Map<String, Image> preImages = {};

  @override
  void didUpdateWidget(covariant AppBottomNavigationBar oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    for (var element in AppNavigationBarType.values) {
      preImages["${element.name}_off"] = Image.asset(element.icon, fit: BoxFit.contain);
      preImages["${element.name}_on"] = Image.asset(element.onIcon, fit: BoxFit.contain);
    }
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        preImages.forEach((key, value) => precacheImage(value.image, context));
      });
    });

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
    return GlassContainer(
      width: UIDefine.getWidth(),
      border: 0.0,
      blur: 8,
      radius: 0,
      linearGradient: LinearGradient(
        colors: [AppColors.mainBackground.getColor().withOpacity(0.8), AppColors.mainBackground.getColor().withOpacity(0.8)],
      ),
      child: Container(
          // color: AppColors.mainBackground.getColor().withOpacity(0.8),
          height: UIDefine.getNavigationBarHeight(),
          padding: EdgeInsets.only(
            right: UIDefine.getPixelWidth(6),
            left: UIDefine.getPixelWidth(6),
            bottom: UIDefine.getPixelWidth(Platform.isIOS ? 10 : 0),
          ),
          child: Row(
            children: [
              buildButton(AppNavigationBarType.typeDynamic),
              buildButton(AppNavigationBarType.typeExplore),
              buildButton(AppNavigationBarType.typePair),
              buildButton(AppNavigationBarType.typeMessage),
              buildButton(AppNavigationBarType.typeCreate),
            ],
          )),
    );
  }

  Widget buildButton(AppNavigationBarType type) {
    return Expanded(
        child: GestureDetector(
            onTap: () => _navigationTapped(AppNavigationBarType.values.indexOf(type), setState),
            behavior: HitTestBehavior.translucent,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(8)),
              child: getIcon(type),
            )));
  }

  Widget getIcon(AppNavigationBarType type) {
    bool isSelect = (GlobalData.mainBottomType == type);
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: isSelect ? preImages["${type.name}_on"] : preImages["${type.name}_off"],
    );
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
        MaterialPageRoute<void>(builder: (BuildContext context) => MainScreen(type: type)),
        ModalRoute.withName('/'),
      );
    }
  }
}
