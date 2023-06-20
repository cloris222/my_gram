import 'package:base_project/view_models/message/websocketdata/ws_send_message_data.dart';
import 'package:flutter/cupertino.dart';
import '../sqlite/data/chat_history_sqlite.dart';

class ChatMsgNotifier extends ChangeNotifier {
  ChatHistorySQLite _msgData = ChatHistorySQLite(); // 聊天訊息
  bool _isSelfACK = false; // 自己發的or異動通知 都會是true

  ChatHistorySQLite get msgData => _msgData;
  bool get isSelfACK => _isSelfACK;

  set setMsgData(ChatHistorySQLite value) {
    _msgData = value;
    notifyListeners();
  }

  set setIsSelfACK(bool bValue) {
    _isSelfACK = bValue;
  }

  void notifier() {
    notifyListeners();
  }
}