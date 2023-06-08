import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_routes.dart';
import '../common_scaffold.dart';

class ResetPasswordFinishPage extends StatelessWidget {
  const ResetPasswordFinishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CustomAppBar.registerAppBar(context),
      body: (isDark) => SizedBox(
        width: UIDefine.getWidth(),
        height: UIDefine.getHeight(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              tr('resetPassword'),
              style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),
            ),
            Container(
              width: UIDefine.getPixelWidth(100),
              height: UIDefine.getPixelWidth(100),
              child: Image.asset(
                AppImagePath.checkedIcon,
                fit: BoxFit.cover,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButtonWidget(
                textColor: AppColors.buttonPrimaryText,
                isFillWidth: false,
                isGradient: true,
                setWidth: UIDefine.getPixelWidth(150),
                setHeight: UIDefine.getPixelWidth(45),
                btnText: tr('login'),
                onPressed: () =>
                    AppRoutes.pushLogin(context, removeUntil: true),
              )
            ])
          ],
        ),
      ),
    );
  }
}
