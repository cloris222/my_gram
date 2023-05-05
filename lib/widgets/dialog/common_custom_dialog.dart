import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/enum/border_style_type.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';
import '../button/action_button_widget.dart';
import '../button/text_button_widget.dart';
import 'base_dialog.dart';

/// 可選圖,單/雙按鈕,標題,內容 的共用Dialog
class CommonCustomDialog extends BaseDialog {
  CommonCustomDialog(
    super.context, {
    super.isDialogCancel,
    required this.type,
    this.title = '',
    this.content = '',
        this.titleColor,
    this.bOneButton = true,
    this.leftBtnText = '',
    this.rightBtnText = '',
    required this.onLeftPress,
    required this.onRightPress,
  });

  DialogImageType type;
  String title;
  String content;
  Color? titleColor;
  bool bOneButton;
  String leftBtnText;
  String rightBtnText;
  Function onLeftPress;
  Function onRightPress;

  @override
  Widget initTitle() {
    return const SizedBox();
  }

  @override
  Future<void> initValue() async {}

  @override
  Widget initContent(
      BuildContext context, StateSetter setState, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // AnimationTypeWidget(
        //     type: type,
        //     height: UIDefine.getPixelWidth(70),
        //     width: UIDefine.getPixelWidth(70)),
        Visibility(
            visible: title != '',
            child: Column(
              children: [
                SizedBox(height: UIDefine.getScreenWidth(2.7)),
                Text(title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize24,
                        fontWeight: FontWeight.w500,
                        color: titleColor??_getTitleColor(type)))
              ],
            )),
        SizedBox(height: UIDefine.getScreenWidth(10)),
        Container(
          child: Image.asset(_getImage(type))
        ),
        Visibility(
            visible: content != '',
            child: Column(
              children: [
                SizedBox(height: UIDefine.getScreenWidth(2.7)),
                Text(content,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textGrey
                    ))
              ],
            )),
        SizedBox(height: UIDefine.getScreenWidth(8.5)),
        Divider(height: 1.0,color: AppColors.textWhite,),
        _getButton(),
      ],
    );
  }

  Widget _getButton() {
    if (bOneButton) {
      return _solidButton();
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: _hollowButton()),
        SizedBox(width: UIDefine.getScreenWidth(2.7)),
        Expanded(child: _solidButton())
      ]);
    }
  }

  Widget _solidButton() {
    /// 實心按鈕
    return TextButtonWidget(
      setHeight: UIDefine.getPixelWidth(50),
      setMainColor: AppColors.dialogBackground,
        btnText: rightBtnText,
        onPressed: () => onRightPress(),
        radius: 10,
        fontWeight: FontWeight.w500,
        fontSize: UIDefine.fontSize16,
        isFillWidth: bOneButton);
  }

  Widget _hollowButton() {
    /// 空心按鈕
    return TextButtonWidget(
      setMainColor: AppColors.dialogBackground,
      isFillWidth: false,
      isBorderStyle: true,
      setSubColor: Colors.transparent,
      btnText: leftBtnText,
      onPressed: () => onLeftPress(),
      radius: 10,
      fontWeight: FontWeight.w500,
      fontSize: UIDefine.fontSize16,
    );
  }

  String _getImage(DialogImageType type) {
    String imagePath;
    switch(type) {
      case DialogImageType.success:
        imagePath = AppImagePath.checkedIcon;
        break;
      case DialogImageType.fail:
        imagePath = AppImagePath.unCheckedIcon;
        break;
      case DialogImageType.warning:
        imagePath = AppImagePath.demoImage;
        break;
      default:
        imagePath = AppImagePath.checkedIcon;
        break;
    }
    return imagePath;
  }

  Color _getTitleColor(DialogImageType type) {
    Color titleColor;
    switch(type) {
      case DialogImageType.success:
        titleColor = AppColors.textSuccess;
        break;
      case DialogImageType.fail:
        titleColor = AppColors.textFail;
        break;
      case DialogImageType.warning:
        titleColor = AppColors.textWarning;
        break;
      default:
        titleColor = AppColors.textWhite;
        break;
    }
    return titleColor;
  }

}
