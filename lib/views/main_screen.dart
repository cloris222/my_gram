import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/widgets/app_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/enum/app_param_enum.dart';
import '../constant/theme/ui_define.dart';
import '../widgets/appbar/custom_app_bar.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  void initState() {
    controller = PageController(initialPage: widget.type.index);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomAppBar.mainAppBar(),
        bottomNavigationBar: AppBottomNavigationBar(
          initType: widget.type,
          bottomFunction: _changePage,
        ),
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: List<Widget>.generate(AppNavigationBarType.values.length,
              (index) => AppNavigationBarType.values[index].typePage),
        ));
  }

  void _changePage(AppNavigationBarType type) {
    setState(() {
      GlobalData.mainBottomType = type;
      controller.jumpToPage(type.index);
    });
  }


}
