import 'package:base_project/constant/theme/app_animation_path.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/theme/app_colors.dart';
import '../view_models/base_view_model.dart';
import 'app_first_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textPrimary.getColor(),
      body: Center(
          child: Lottie.asset(AppAnimationPath.launchLoading,
              width: UIDefine.getPixelWidth(169),
              height: UIDefine.getPixelWidth(169),
              alignment: Alignment.center,
              controller: _controller,
              animate: true, onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward().whenComplete(() {
            _checkFinish();
          });
      }, fit: BoxFit.contain)),
    );
  }

  void _checkFinish() {
    BaseViewModel().pushReplacement(context, const AppFirstPage());
  }
}
