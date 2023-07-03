import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/widgets/app_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/enum/app_param_enum.dart';
import '../constant/theme/ui_define.dart';
import '../utils/observer_pattern/main_screen/main_screen_observer.dart';
import '../view_models/gobal_provider/main_bottom_bar_provider.dart';
import '../view_models/dynmaic/is_rebecca_provider.dart';
import '../view_models/gobal_provider/user_info_provider.dart';
import 'common_scaffold.dart';

/// App一開啟後的主頁
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    Key? key,
    this.type = AppNavigationBarType.typePair,
  }) : super(key: key);
  final AppNavigationBarType type;

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late PageController controller;
  late MainScreenObserver observer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  void initState() {
    controller = PageController(initialPage: widget.type.index);
    observer = MainScreenObserver("main",
        changeMainPage: (AppNavigationBarType type, bool isRebecca) =>
            _changePage(type, needRecover: !isRebecca));
    GlobalData.mainScreenSubject.registerObserver(observer);

    /// 更新資料
    Future.delayed(Duration.zero).then((value) async {
      if (GlobalData.userToken.isNotEmpty) {
        /// 更新個人資料&聊天室
        ref.read(userInfoProvider.notifier).updateUserInfo(ref);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    GlobalData.mainScreenSubject.unregisterObserver(observer);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mainBottomBarProvider, (previous, next) {
      _changePage(AppNavigationBarType.values[next]);
    });
    return CommonScaffold(
        canPop: false,
        // appBar: CustomAppBar.mainAppBar(context),
        // bottomNavigationBar: ,
        body: (isDark) => Stack(
              children: [
                PageView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List<Widget>.generate(
                      AppNavigationBarType.values.length,
                      (index) => AppNavigationBarType.values[index].typePage),
                ),
                Positioned(
                    bottom: 0,
                    child: AppBottomNavigationBar(
                      initType: widget.type,
                      bottomFunction: _changePage,
                    ))
              ],
            ));
  }

  void _changePage(AppNavigationBarType type, {bool needRecover = true}) {
    setState(() {
      if (needRecover) {
        ref.read(isRebeccaProvider.notifier).update((state) => false);
      }

      /// 判斷是否在同一頁切換
      if (type == AppNavigationBarType.typeDynamic &&
          GlobalData.mainBottomType == AppNavigationBarType.typeDynamic) {
        GlobalData.dynamicSubject.scrollTop();
      }
      GlobalData.mainBottomType = type;
      controller.jumpToPage(type.index);
    });
  }
}
