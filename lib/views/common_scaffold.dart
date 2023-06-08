import 'package:base_project/constant/theme/global_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/theme/app_colors.dart';
import '../view_models/global_theme_provider.dart';

class CommonScaffold extends ConsumerWidget {
  const CommonScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.bottomNavigationBar,
  }) : super(key: key);
  final Widget Function(bool isDark) body;
  final PreferredSizeWidget? appBar;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(globalThemeProvider);
    return Scaffold(
      body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.translucent,
          child: body(GlobalData.isDark)),
      appBar: appBar,
      backgroundColor: AppColors.mainBackground.getColor(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
