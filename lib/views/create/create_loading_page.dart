import 'package:base_project/constant/theme/app_animation_path.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/models/http/api/create_ai_api.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_gradient_colors.dart';

class CreateLoadingPage extends StatefulWidget {
  const CreateLoadingPage({Key? key, required this.features}) : super(key: key);
  final List<String> features;

  @override
  State<CreateLoadingPage> createState() => _CreateLoadingPageState();
}

class _CreateLoadingPageState extends State<CreateLoadingPage> {
  bool isAnimationFinish = false;
  bool isCreateFinish = false;

  @override
  void initState() {
    _startCreate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: WillPopScope(
            onWillPop: () async {
              // return false;
              return true;
            },
            child: Container(
              width: UIDefine.getWidth(),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppImagePath.gradientBg),fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: UIDefine.getPixelWidth(150),
                      height: UIDefine.getPixelWidth(150),
                      child: Lottie.asset(AppAnimationPath.createLoading,
                          fit: BoxFit.contain)),
                  SizedBox(height: UIDefine.getPixelWidth(10)),
                  Opacity(
                      opacity: 0.5,
                      child: Text(
                        tr("createAILoading"),
                        style: AppTextStyle.getBaseStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w400,
                            fontSize: UIDefine.fontSize14),
                      ))
                ],
              ),
            )));
  }

  void _startCreate() {
    /// 5秒動畫
    Future.delayed(const Duration(seconds: 5)).then((value) => _checkFinish());
    CreateAiAPI(onConnectFail: _onFail)
        .createAi(widget.features)
        .then((value) => _checkFinish());
  }

  void _checkFinish() {
    if (isAnimationFinish && isCreateFinish) {
      Navigator.of(context).pop();
    }
  }

  void _onFail(String errorMessage) {
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      Navigator.of(context).pop();
      BaseViewModel()
          .showToast(BaseViewModel().getGlobalContext(), tr("createFail"));
    });
  }
}
