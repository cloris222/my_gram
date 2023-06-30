import 'dart:io';

import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/models/http/data/create_ai_info.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/ui_define.dart';
import '../../widgets/button/text_button_widget.dart';

/// 創建完成
class CreateSuccessPage extends StatelessWidget {
  const CreateSuccessPage({Key? key, required this.resultInfo})
      : super(key: key);
  final CreateAiInfo resultInfo;

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
              padding: EdgeInsets.only(
                  top: UIDefine.getStatusBarHeight() +
                      UIDefine.getPixelWidth(20),
                  bottom: Platform.isIOS
                      ? UIDefine.getPixelWidth(25)
                      : UIDefine.getPixelWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImagePath.success,
                    width: UIDefine.getPixelWidth(60),
                    height: UIDefine.getPixelWidth(60),
                  ),
                  Text(tr("createSuccessTitle"),
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize16,
                          fontWeight: FontWeight.w500)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: UIDefine.getPixelWidth(32)),
                      child: CommonNetworkImage(
                        background: Colors.transparent,
                        imageUrl: "${GlobalData.urlPrefix}${resultInfo.imgUrl}",
                        width: UIDefine.getWidth(),
                        fit: UIDefine.getViewHeight() * 0.75 >=
                                UIDefine.getPixelWidth(500)
                            ? BoxFit.fitWidth
                            : BoxFit.contain,
                      ),
                    ),
                  ),
                  _buildButton(context),
                ],
              ),
            )));
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButtonWidget(
              backgroundVertical: 0,
              backgroundHorizontal: 0,
              setHeight: UIDefine.getPixelWidth(40),
              isFillWidth: true,
              btnText: tr('ReCreate'),
              setMainColor: AppColors.buttonUnable,
              textColor: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: UIDefine.fontSize14,
              onPressed: () => _onReCreate(context),
            ),
          ),
          SizedBox(
            width: UIDefine.getPixelWidth(24),
          ),
          Expanded(
            child: TextButtonWidget(
              backgroundVertical: 0,
              backgroundHorizontal: 0,
              setHeight: UIDefine.getPixelWidth(40),
              isFillWidth: true,
              isGradient: true,
              btnText: tr('confirm'),
              textColor: AppColors.textBlack,
              fontWeight: FontWeight.w500,
              fontSize: UIDefine.fontSize14,
              onPressed: () => _onConfirm(context),
            ),
          ),
        ],
      ),
    );
  }

  void _onReCreate(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onConfirm(BuildContext context) {
    Navigator.of(context).pop();
  }
}
