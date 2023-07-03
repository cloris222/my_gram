import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/ui_define.dart';
import '../common_scaffold.dart';

class OtherCreatePage extends ConsumerStatefulWidget {
  const OtherCreatePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _OtherCreatePageState();
}

class _OtherCreatePageState extends ConsumerState<OtherCreatePage> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CustomAppBar.actionWordAppBar(
        context, title: "tryOtherCreate".tr(), 
        actionWord: "apply".tr()),
      body: (isDark) =>
       Container(
         child: Column(
          children: [
            // Container(
            //   width: UIDefine.getWidth(),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: UIDefine.getPixelHeight(24),
            //         width: UIDefine.getPixelWidth(24),
            //         child: Image.asset(
            //           AppImagePath.closeSheet,
            //           color: Colors.white,
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           alignment: Alignment.center,
            //           child: Text(
            //             "tryOtherCreate".tr(),
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         child: GestureDetector(
            //           child: Text("apply".tr()),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: UIDefine.getPixelHeight(13)),
              child: Container(
                child: Text(
                  "otherCreaterMessage".tr(),
                  style: TextStyle(color: AppColors.tryOtherSheet.light),
                ),
              ),
            ),
            _buildTabBar(context)
            // TabBar(
            //   controller: _tabController,
            //   tabs: [
            //     Container(
            //       child: Text("最近"),
            //     ),
            //     Container(
            //       child: Text("熱門"),
            //     )
            // ])
          ],
             ),
       ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      height: UIDefine.getPixelHeight(36),
      decoration:  BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
          )),
      child: TabBar(
        indicator: UnderlineTabIndicator(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 3,color: AppColors.mainThemeButton.getColor()),
          insets: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(28))
        ),
        controller: _tabController,
        tabs: [
          Container(
            child: Text("test1"),
          ),
          Container(
            child: Text("test2"),
          )
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return Container();
  }
}
