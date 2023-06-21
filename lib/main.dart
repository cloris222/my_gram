import 'dart:async';
import 'dart:io';
import 'package:base_project/view_models/global_theme_provider.dart';
import 'package:base_project/view_models/message/websocket/web_socket_util.dart';
import 'package:base_project/views/app_first_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constant/theme/app_routes.dart';
import 'constant/theme/app_text_style.dart';
import 'constant/theme/global_data.dart';
import 'models/app_shared_preferences.dart';
import 'models/database/chat_history_database.dart';
import 'utils/language_util.dart';
import 'view_models/base_view_model.dart';
import 'view_models/message/websocketdata/ws_ack_send_message_data.dart';
import 'views/main_screen.dart';

// MainViewModel viewModel = MainViewModel();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  debugPaintSizeEnabled = false;

  if (Platform.isAndroid) {
    ///MARK:
    /// 以下兩行 設定android狀態列為透明的沉浸。寫在元件渲染之後，是為了在渲染後進行set賦值，覆蓋狀態列，寫在渲染之前MaterialApp元件會覆蓋掉這個值。
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  initApp();
}

Future<void> initApp() async {
  BaseViewModel baseViewModel = BaseViewModel();
  // await baseViewModel.getCountry();
  await LanguageUtil.init();

  /// 資料庫初始化
  ChatHistoryDataBase.instance.database;

  ///MARK: 自動登入
  bool isLogin = false;
  try {
    if (await AppSharedPreferences.getLogIn()) {
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
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      ref.read(globalThemeProvider.notifier).init();
    });
    _initWebSocket();
    _onWebSocketListen();
    super.initState();
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
      home:AppFirstPage()
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
        if (data.topic == 'chatSingle' || data.topic == 'chatGroup') {
          if (data.action == 'message' || data.action == 'messageReply') {
            // isSelfACK true的話, 代表是我自己訊息的ACK
            // bool isSelfACK = data.chatData.content.senderMemberId == GlobalData.userMemberId;
            // await viewModel.updateChatroomData(data, isSelfACK); // 存進列表DB
            // viewModel.addHistoryToDb(data, isSelfACK); // 單則訊息 存進聊天記錄DB
          } else if (data.action == 'stickerReply') {
            // await viewModel.updateEmojiToDb(data);
          } else if (data.action == 'read') {
            // if (data.chatData.readRooms.isNotEmpty) {
              // 編輯模式的已讀
              // await viewModel.updateReadStatusFromEditMode(data);
            // } else {
              // 一般已讀
              // await viewModel.updateReadStatus(data);
            // }
            if (data.topic == 'chatGroup') {
              // 群聊的已讀 另外存已讀的member
              // await viewModel.updateReadStatusForGroup(data);
            }
          } else if (data.action == 'recall') {
            // await viewModel.updateRecallRecord(data);
          } else if (data.action == 'update') {
            // viewModel.addUpdateRecord(data);
          }
        }
      }
    });
  }
}
