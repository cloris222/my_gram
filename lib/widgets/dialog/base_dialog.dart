// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/app_theme.dart';
import '../../constant/theme/ui_define.dart';

abstract class BaseDialog {
  BaseDialog(
    this.context, {
    this.radius = 10,
    this.isDialogCancel = true,
    this.contentSizeHeight = 15.0,
    this.backgroundColor = AppColors.dialogBackground,
    this.needClose = true,
    this.closeColor,
  });

  BuildContext context;
  double radius;
  bool isDialogCancel;
  double contentSizeHeight;
  AppColors backgroundColor;
  bool needClose;
  AppColors? closeColor;

  Future<void> initValue();

  Widget? initTitle();

  Widget initContent(BuildContext context, StateSetter setState, WidgetRef ref);

  List<Widget> initAction() {
    return <Widget>[];
  }

  Future<void> show() async {
    await initValue();

    await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return GestureDetector(
            onTap: () {
              if (isDialogCancel) {
                closeDialog();
              }
            },
            child: Scaffold(
                backgroundColor: AppColors.opacityBackground.getColor(),
                body: WillPopScope(
                  onWillPop: () async {
                    return isDialogCancel;
                  },
                  child: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: backgroundColor.getColor(),
                            borderRadius: BorderRadius.circular(radius)),
                        margin: defaultInsetMargin(),
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              Container(
                                  // padding: defaultInsetPadding(),
                                  width: UIDefine.getWidth(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      initTitle() ?? const SizedBox(),
                                      SingleChildScrollView(child: Consumer(
                                        builder: (context, ref, child) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return initContent(
                                                  context, setState, ref);
                                            },
                                          );
                                        },
                                      )),
                                      Row(
                                          children: List<Widget>.generate(
                                              initAction().length,
                                              (index) => Expanded(
                                                  child: initAction()[index])))
                                    ],
                                  )),
                              defaultBtnCloseMargin(
                                child: Visibility(
                                    visible: needClose,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color:
                                            (closeColor ?? AppColors.textPrimary)
                                                .getColor(),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          );
        },
        opaque: false));
  }

  void closeDialog() {
    Navigator.pop(context);
  }

  //測試用用 可從下淡入
  @deprecated
  Future<void> _showGeneral() async {
    showGeneralDialog(
        context: context,
        pageBuilder: (buildContext, _, __) {
          return Container(margin: const EdgeInsets.all(50), color: Colors.red);
        },
        barrierDismissible: false,
        barrierColor: Colors.black87.withOpacity(0.2),
        transitionDuration: const Duration(milliseconds: 1500),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: const Offset(0.0, 0.0))
                  .animate(CurvedAnimation(
                      parent: animation, curve: Curves.fastOutSlowIn)),
              child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.linear)),
                  child: child));
        });
  }

  void onCancel() {
    closeDialog();
  }

  Widget createGeneralTitle({String title = ''}) {
    if (title.isNotEmpty) {
      return Stack(
        alignment: Alignment.centerRight,
        children: [
          AppTheme.style.styleFillText(title,
              alignment: Alignment.center,
              style: AppTextStyle.getBaseStyle(fontWeight: FontWeight.w500)),
          createDialogCloseIcon(),
        ],
      );
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [createDialogCloseIcon()]);
    }
  }

  Widget createDialogCloseIcon() {
    return IconButton(
        onPressed: onCancel,
        icon: Image.asset(AppImagePath.btnCancel, width: 15, height: 15));
  }

  Widget createImageWidget(
      {required String asset, double? width, double? height}) {
    return Image.asset(asset,
        width: width ?? UIDefine.getPixelWidth(100),
        height: height ?? UIDefine.getPixelWidth(100),
        fit: BoxFit.contain);
  }

  Widget createContentPadding() {
    return SizedBox(height: contentSizeHeight);
  }

  void clearFocus() {
    FocusScope.of(context).unfocus();
  }

  EdgeInsets defaultInsetPadding() {
    return EdgeInsets.symmetric(
        horizontal: UIDefine.getPixelWidth(40),
        vertical: UIDefine.getPixelWidth(24));
  }

  EdgeInsets defaultInsetMargin() {
    return EdgeInsets.symmetric(
        horizontal: UIDefine.getPixelWidth(40),
        vertical: UIDefine.getPixelWidth(24));
  }

  Positioned defaultBtnCloseMargin({required Widget child}) {
    return Positioned(
        right: UIDefine.getPixelWidth(5),
        top: UIDefine.getPixelWidth(5),
        child: child);
  }
}
