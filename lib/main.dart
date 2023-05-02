import 'dart:io';
import 'package:base_project/views/app_first_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constant/theme/app_routes.dart';
import 'constant/theme/app_text_style.dart';
import 'constant/theme/app_theme.dart';
import 'constant/theme/global_data.dart';
import 'models/app_shared_preferences.dart';
import 'utils/language_util.dart';
import 'view_models/base_view_model.dart';
import 'views/main_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  debugPaintSizeEnabled = false;

  if (Platform.isAndroid) {
    ///MARK:
    /// 以下兩行 設定android狀態列為透明的沉浸。寫在元件渲染之後，是為了在渲染後進行set賦值，覆蓋狀態列，寫在渲染之前MaterialApp元件會覆蓋掉這個值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  initApp();
}

Future<void> initApp() async {
  BaseViewModel baseViewModel = BaseViewModel();
  // await baseViewModel.getCountry();
  await LanguageUtil.init();

  ///MARK: 自動登入
  bool isLogin = false;
  try {
    if (await AppSharedPreferences.getLogIn()) {
      GlobalData.userToken = await AppSharedPreferences.getToken();
      GlobalData.userMemberId = await AppSharedPreferences.getMemberID();
      if (GlobalData.userToken.isNotEmpty &&
          GlobalData.userMemberId.isNotEmpty) {
        isLogin = true;

        ///MARK: 更新使用者登入相關
        ///baseViewModel.uploadPersonalInfo().....
        ///baseViewModel.startUserListener();
      }
    }
  } catch (e) {}
  runApp(ProviderScope(child: localizations(MyApp(isLogin: isLogin))));
}

Widget localizations(Widget app) {
  // FmSharedPreferences.getLanguage().then((value) => {locale = value});
  return EasyLocalization(
      supportedLocales: LanguageUtil.getSupportLanguage(),
      // startLocale: GlobalData.locale,
      path: 'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),
      child: app);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.isLogin}) : super(key: key);
  final bool isLogin;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // 初始化ThemeStore，之后赋值到themeProvider中
    // AppTheme.init().then((value) {
    //   GlobalData.themeProvider.setThemeMode(AppTheme.getThemeMode());
    //   GlobalData.isDarkTheme = (AppTheme.getThemeMode() == ThemeMode.dark);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguageUtil.update(context);

    return MaterialApp(
      /// 深色／淺色模式
      themeMode: null,
      theme: AppTheme.define(),
      routes: AppRoutes.define(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: LanguageUtil.getAppLocale(),
      navigatorKey: GlobalData.globalKey,
      title: 'MyGram',
      builder: AppTextStyle.setMainTextBuilder(),
      // home: const DemoPage(),
      home: widget.isLogin ? const MainScreen() : const AppFirstPage(),
    );
  }
}
