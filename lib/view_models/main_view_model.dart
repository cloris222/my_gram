import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';

import '../utils/date_format_util.dart';
import '../views/message/sqlite/chat_history_db.dart';
import '../views/message/sqlite/data/chat_history_sqlite.dart';
import 'base_view_model.dart';
import '../utils/fm_shared_Preferences.dart';
import '../constant/theme/global_data.dart';
import '../views/message/data/message_direct_request_message_response_data.dart';
import 'message/websocketdata/ws_ack_send_message_data.dart';

class MainViewModel extends BaseViewModel {
  bool bDuoBaoEnabled = true;
  String roomIdForCalling = '';
  String contentIdForCalling = '';
  // AgoraInfo agoraData = AgoraInfo();
  // UserInfoData creatorInfo = UserInfoData(avatar: '');
  // UserInfoData joinerInfo = UserInfoData(avatar: '');


  void addHistoryToDb(WsAckSendMessageData data, bool isSelfACK) {
    ChatHistorySQLite chatHistorySQLite = ChatHistorySQLite(
      // topic: data.topic,
      action: data.action,
      roomId: data.chatData.roomId,
      receiverAvatarId: data.chatData.receiverAvatarId,
      msgType: data.chatData.msgType,
      content: data.chatData.content,
      contentId: data.chatData.contentId,
      code: data.code,
      message: data.message,
      timestamp: data.timestamp,

      // roomId: data.chatData.roomId,
      // uid: data.chatData.content.senderUid,
      // nickName: data.chatData.content.senderUid, // test 有要暱稱？
      // memberAvatar: data.chatData.content.senderAvatar,
      // memberId: data.chatData.content.senderMemberId,
      // msgType: data.chatData.content.msgType,
      // type: 'chat',
      // action: data.chatData.content.replyByMsg == ''
      //     ? 'message'
      //     : 'messageReply',
      // content: data.chatData.content.message,
      // contentId: data.chatData.contentId,
      // hasRead: 'false', // 這裡給預設值
      // recall: 'false', // 這裡給預設值
      // time: data.chatData.content.time,
      // replyByMsg: data.chatData.content.replyByMsg,
      // replyById: data.chatData.content.replyById,
      // replyByContentId: data.chatData.content.replyByContentId,
      // replyByUid: data.chatData.content.replyByUid,
      // replyByNickName: data.chatData.content.replyByNickName,
      // replyByAvatar: data.chatData.content.replyByAvatar,
      // otherSideMemberId: data.chatData.otherSideMemberId,
      // emojiDataList: []
    );
    ChatHistoryDB.addHistory(chatHistorySQLite);

    GlobalData.chatMsgNotifier.setIsSelfACK = isSelfACK;
    GlobalData.chatMsgNotifier.setMsgData = chatHistorySQLite; // 存完通知Notifier 如當前為聊天室即可更新
  }
}
