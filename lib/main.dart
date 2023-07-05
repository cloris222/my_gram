import 'dart:async';
import 'dart:io';
import 'package:base_project/view_models/global_theme_provider.dart';
import 'package:base_project/view_models/message/message_private_message_view_model.dart';
import 'package:base_project/view_models/message/websocket/web_socket_util.dart';
import 'package:base_project/views/message/notifier/userToken_notifier.dart';
import 'package:base_project/views/message/sqlite/chat_history_db.dart';
import 'package:base_project/views/splash_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constant/theme/app_routes.dart';
import 'constant/theme/app_text_style.dart';
import 'constant/theme/global_data.dart';
import 'models/app_shared_preferences.dart';
import 'utils/language_util.dart';
import 'view_models/base_view_model.dart';
import 'view_models/message/websocketdata/ws_ack_send_message_data.dart';
import '../../view_models/main_view_model.dart';

MainViewModel viewModel = MainViewModel();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  debugPaintSizeEnabled = false;
  if (Platform.isAndroid) {
    ///MARK:
    /// 以下兩行 設定android狀態列為透明的沉浸。寫在元件渲染之後，是為了在渲染後進行set賦值，覆蓋狀態列，寫在渲染之前MaterialApp元件會覆蓋掉這個值。
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    /// 隱藏下方function列用的
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
  }
  initApp();
}

Future<void> initApp() async {
  BaseViewModel baseViewModel = BaseViewModel();
  // await baseViewModel.getCountry();
  await LanguageUtil.init();

  /// 資料庫初始化
  // ChatHistoryDataBase.instance.database;
  ChatHistoryDB.instance.database2;

  ///MARK: 自動登入
  bool isLogin = false;
  try {
    /// 先不讀token 值
    if (false && await AppSharedPreferences.getLogIn()) {
      GlobalData.userToken = await AppSharedPreferences.getToken();
      GlobalData.userMemberId = await AppSharedPreferences.getMemberID();
      if (GlobalData.userToken.isNotEmpty && GlobalData.userMemberId.isNotEmpty) {
        isLogin = true;
        if (isLogin) {}

        ///MARK: 更新使用者登入相關
        ///baseViewModel.uploadPersonalInfo().....
        ///baseViewModel.startUserListener();
      }
    }
  } catch (e) {}
  GlobalData.printLog("useToken:${GlobalData.userToken}");
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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key, required this.isLogin}) : super(key: key);
  final bool isLogin;

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late StreamSubscription _streamSubscription;
  late UserTokenNotifier _userTokenNotifier;
  Timer? timer;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      ref.read(globalThemeProvider.notifier).init();
    });
    if (GlobalData.userToken.isNotEmpty) {
      _initWebSocket();
      _onWebSocketListen();
    }

    /// 對Token監聽: 登入登出Flag
    _addUserTokenNotifier();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    try {
      if(timer != null) timer!.cancel();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    LanguageUtil.update(context);
    return MaterialApp(
      /// 深色／淺色模式
      themeMode: ref.watch(globalThemeProvider),
      routes: AppRoutes.define(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: LanguageUtil.getAppLocale(),
      navigatorKey: GlobalData.globalKey,
      title: 'MyGram',
      builder: AppTextStyle.setMainTextBuilder(),
      home: const SplashPage(),
      // home:  Demo(),
      // home: widget.isLogin ? const MainScreen() : const AppFirstPage(),
    );
  }

  void _initWebSocket() {
    WebSocketUtil().initWebSocket(
      onOpen: () {
        GlobalData.printLog('MainDart WS onOpen');
        WebSocketUtil().initHeartBeat(); // 心跳機制
        // viewModel.requestChatroomList(); // 取聊天列表紀錄
      },
      onMessage: (data) {
        GlobalData.printLog('MainDart WS onMessage');
      },
      onError: (error) {
        GlobalData.printLog('MainDart WS onError$error');
      },
    );
  }

  void _onWebSocketListen() {
    _streamSubscription = WebSocketUtil().streamController.stream.listen((message) async {
      WsAckSendMessageData data = WebSocketUtil().getACKData(message);
      if (data.message == 'SUCCESS') {
        if (data.action == 'MSG') {
          bool isSelfACK = (data.chatData.receiverAvatarId != GlobalData.selfAvatar.toString());
          if (ref.read(readListProvider).isNotEmpty && !isSelfACK) {
            ref.read(readListProvider.notifier).update((state) {
              state.removeWhere((el) => el == state[0]);
              return state;
            });
          }
          // await viewModel.updateChatroomData(data, isSelfACK); // 存進列表DB
          viewModel.addHistoryToDb(data, isSelfACK); // 單則訊息 存進聊天記錄DB
        }else if(data.action == 'READ'){
          timer?.cancel();
          ref.read(readListProvider.notifier).update((state) => [...state,data.timestamp]);
          timer = Timer(const Duration(seconds: 10),(){
            print('timer=${timer?.tick}');
            ref.read(readListProvider.notifier).update((state) => []);
            timer = null;
          });
        }
      }
    });
  }

  void _addUserTokenNotifier() {
    _userTokenNotifier = GlobalData.userTokenNotifier;
    _userTokenNotifier.addListener(() => mounted
        ? setState(() {
            GlobalData.printLog('userTokenNotifier監聽: MainDart');
            bool isLogin = _userTokenNotifier.userToken.isNotEmpty;
            if (isLogin) {
              /// 初始WS
              _initWebSocket();

              /// WS監聽
              _onWebSocketListen();
            } else {
              // 登出
              ChatHistoryDB.database = null;
              WebSocketUtil().closeSocket();
              _streamSubscription.cancel();
            }
          })
        : null);
  }
}
