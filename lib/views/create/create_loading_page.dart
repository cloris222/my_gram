import 'package:base_project/constant/theme/app_animation_path.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/models/http/api/create_ai_api.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/create/create_success_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constant/theme/app_colors.dart';
import '../../models/http/data/create_ai_info.dart';

class CreateLoadingPage extends StatefulWidget {
  const CreateLoadingPage({Key? key, required this.features}) : super(key: key);
  final List<String> features;

  @override
  State<CreateLoadingPage> createState() => _CreateLoadingPageState();
}

class _CreateLoadingPageState extends State<CreateLoadingPage>
    with TickerProviderStateMixin {
  bool isAnimationFinish = false;
  bool isCreateFinish = false;
  CreateAiInfo? resultInfo;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
    );
    _startCreate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
              width: UIDefine.getWidth(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImagePath.gradientBg),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: UIDefine.getPixelWidth(150),
                      height: UIDefine.getPixelWidth(150),
                      child: Lottie.asset(AppAnimationPath.createLoading,
                          fit: BoxFit.contain,
                          controller: _controller,
                          animate: true, onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward().whenComplete(() {
                            isAnimationFinish = true;
                            _checkFinish();
                          });
                      })),
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
    CreateAiAPI(onConnectFail: _onTmpFail)
        .createAi(widget.features)
        .then((value) {
      isCreateFinish = true;
      resultInfo = value;
      _checkFinish();
    });
  }

  void _checkFinish() {
    if (isAnimationFinish && isCreateFinish) {
      if (resultInfo != null) {
        BaseViewModel().pushReplacement(
            context, CreateSuccessPage(resultInfo: resultInfo!));
      } else {
        _onFail("create fail");
      }
    }
  }

  // 暫時假資料
  void _onTmpFail(String errorMessage) {
    isCreateFinish = true;
    resultInfo = CreateAiInfo(
      id: '6490235f7df0a90bb9a10d7a',
      avatarId: '3',
      feature: [],
      prompt: '',
      type: '',
      imgUrl: 'admin/sd/feature/SD324202306211535150808SW.png',
    );
    _checkFinish();
  }

  void _onFail(String errorMessage) {
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      Navigator.of(context).pop();
      BaseViewModel()
          .showToast(BaseViewModel().getGlobalContext(), tr("createFail"));
    });
  }
}
