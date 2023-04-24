import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/enum/app_param_enum.dart';
import '../constant/theme/global_data.dart';
import '../constant/theme/ui_define.dart';
import '../view_models/base_view_model.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import '../widgets/appbar/custom_app_bar.dart';

///MARK:用於推出來的頁面
class CommonAppbarView extends ConsumerWidget {
  const CommonAppbarView({
    super.key,
    required this.body,
    this.onPressed,
    this.type,
    required this.needScrollView,
    this.needCover = false,
    this.backgroundColor = Colors.white,
    this.needAppBar = true,
    this.needBottom = true,
  });

  final Widget body;
  final VoidCallback? onPressed;
  final AppNavigationBarType? type;
  final bool needScrollView;
  final bool needCover;
  final Color backgroundColor;
  final bool needAppBar;
  final bool needBottom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        appBar: needAppBar ? CustomAppBar.mainAppBar(context) : null,
        body: GestureDetector(
          onTap: () => BaseViewModel().clearAllFocus(),
          child: Stack(children: [
            Container(
                color: backgroundColor,
                height: UIDefine.getHeight(),
                width: UIDefine.getWidth(),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom +
                        UIDefine.getScreenWidth(1.38)),
                child:
                    needScrollView ? SingleChildScrollView(child: body) : body),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: needBottom
                    ? AppBottomNavigationBar(
                        initType: type ?? GlobalData.mainBottomType)
                    : const SizedBox())
          ]),
        ),
        extendBody: true);
  }
}
