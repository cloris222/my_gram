import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/utils/pitch_data_util.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/enum/app_param_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/ui_define.dart';
import '../../view_models/base_view_model.dart';
import '../../view_models/create/create_main_view_model.dart';
import '../../view_models/gobal_provider/global_tag_controller_provider.dart';
import '../../widgets/button/text_button_widget.dart';
import 'create_tags_view.dart';

class CreateMainPage extends ConsumerStatefulWidget {
  const CreateMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateMainPageState();
}

class _CreateMainPageState extends ConsumerState<CreateMainPage> {
  String mainAsset = "";
  late CreateMainViewModel viewModel;

  @override
  void initState() {
    mainAsset = PitchDataUtil().getRandomCreateDemo();
    viewModel = CreateMainViewModel(ref);
    viewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showRandomDialog =
        ref.watch(globalBoolProvider(viewModel.randomDialog));
    return Stack(children: [
      SizedBox(width: UIDefine.getWidth(), height: UIDefine.getViewHeight()),

      /// 中間主要展示圖
      Positioned(
          top: 0,
          bottom: UIDefine.getPixelWidth(250),
          right: 0,
          left: 0,
          child: _buildDemoImageView()),

      /// 標籤
      Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: SizedBox(
              height: UIDefine.getPixelWidth(300), child: _buildTagsView())),

      /// 右側功能鍵
      Positioned(
          top: UIDefine.getStatusBarHeight() + UIDefine.getPixelWidth(50),
          right: UIDefine.getPixelWidth(10),
          child: _buildRightFunction()),

      /// 左下功能鍵
      Positioned(
          bottom: UIDefine.getPixelWidth(320),
          left: UIDefine.getPixelWidth(10),
          child: _buildLeftFunction()),

      /// 中間成功彈窗
      Positioned(
          bottom: UIDefine.getPixelWidth(320),
          right: 0,
          left: 0,
          child: AnimatedOpacity(
            opacity: showRandomDialog ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: _buildRandomDialog(),
          )),

      /// appbar
      Positioned(
          top: UIDefine.getStatusBarHeight(),
          left: UIDefine.getPixelWidth(10),
          right: UIDefine.getPixelWidth(10),
          child: _buildAppBar()),
    ]);
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              BaseViewModel()
                  .changeMainScreenPage(AppNavigationBarType.typeDynamic);
            },
            child: Image.asset(AppImagePath.arrowLeft)),
        const Spacer(),
        TextButtonWidget(
          isFillWidth: false,
          backgroundVertical: UIDefine.getPixelWidth(1),
          isGradient: true,
          btnText: tr('createAI'),
          textColor: AppColors.textBlack,
          onPressed: () => viewModel.onPressCreate(context),
        ),
      ],
    );
  }

  Widget _buildDemoImageView() {
    return CommonNetworkImage(imageUrl: mainAsset, fit: BoxFit.cover);
  }

  Widget _buildTagsView() {
    return const CreateTagsView();
  }

  Widget _buildRightFunction() {
    return Container(
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      decoration: AppStyle().styleColorsRadiusBackground(
          color: AppColors.createFunctionBackground.getColor(), radius: 28),
      child: Column(
        children: [
          _buildFunctionIcon(
              AppImagePath.infoIcon, () => viewModel.onPressInfo(context)),
          _buildFunctionIcon(AppImagePath.spotlightIcon,
              () => viewModel.onPressSpotlight(context)),
          _buildFunctionIcon(
              AppImagePath.faceArIcon, () => viewModel.onPressFaceAR(context)),
          _buildFunctionIcon(
              AppImagePath.randomIcon, () => viewModel.onPressRandom(context)),
        ],
      ),
    );
  }

  Widget _buildFunctionIcon(String assetPath, Function() onPress,
      {double? vertical}) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: vertical ?? UIDefine.getPixelWidth(5)),
      child: GestureDetector(
        onTap: () => onPress(),
        behavior: HitTestBehavior.translucent,
        child: Image.asset(assetPath,
            width: UIDefine.getPixelWidth(24),
            height: UIDefine.getPixelWidth(24)),
      ),
    );
  }

  Widget _buildLeftFunction() {
    return Container(
        padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
        decoration: AppStyle().styleColorsRadiusBackground(
            color: AppColors.createFunctionBackground.getColor(), radius: 28),
        child:
            _buildFunctionIcon(AppImagePath.arIcon, () => null, vertical: 0));
  }

  Widget _buildRandomDialog() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButtonWidget(
            btnText: tr("createUseRandom"),
            setMainColor: AppColors.randomButton,
            backgroundHorizontal: UIDefine.getPixelWidth(12),
            backgroundVertical: UIDefine.getPixelWidth(12),
            isFillWidth: false,
            onPressed: () {}),
      ],
    );
  }
}
