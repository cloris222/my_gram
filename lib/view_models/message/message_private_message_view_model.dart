import 'package:base_project/view_models/message/websocket/web_socket_util.dart';
import 'package:base_project/view_models/message/websocketdata/ws_send_message_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/theme/global_data.dart';
import '../../utils/date_format_util.dart';
import '../../../views/message/sqlite/data/chat_history_sqlite.dart';
import '../../views/message/sqlite/chat_history_db.dart';
import '../base_view_model.dart';
import '../../constant/call_back_function.dart';
import '../../views/message/data/message_chatroom_detail_response_data.dart';

class MessagePrivateGroupMessageViewModel extends BaseViewModel {
  final TextEditingController textController = TextEditingController();
  bool bShowReply = false; // 回覆
  String roomId = "1";
  String receiverAcatarId = "3";
  ChatHistorySQLite replyByMessageData = ChatHistorySQLite(); // 暫存所要回覆的訊息
  MessageChatroomDetailResponseData _chatroomDetailData = MessageChatroomDetailResponseData();

  // Future<MessageChatroomDetailResponseData> getChatroomDetail(String roomId,
  //   {ResponseErrorFunction? onConnectFail}) async {
  //     return await MessageApi(onConnectFail: onConnectFail)
  //     .getChatroomDetail(roomId: roomId);
  // }

  final showingListProvider = StateProvider<List<ChatHistorySQLite>>((ref) => []);

  bool checkInputEmpty(String sContent) {
    if (sContent.isEmpty) {
      return false;
    }
    for (int i = 0; i < sContent.length; i++) {
      String sTemp = sContent.substring(i, i + 1);
      if (sTemp != '') {
        return true;
      }
    }
    return false;
  }

  void onSendMessage(String sContent, bool bImage) {
    if (!bImage) {
      // false=文字訊息 檢查是否空字串
      bool bShow = checkInputEmpty(sContent);
      if (!bShow) {
        return;
      }
    }
    // roomId = "1";
    sendMessage(bShowReply, bImage, sContent, roomId, false);
    // 清掉
    // replyByMessageData = ChatHistorySQLite(chatData: ChatData());
    textController.clear(); // 發送完清除剛輸入的
  }

  void sendMessage(bool bShowReply, bool bImage, String sContent, String theRoom, bool bGroup) {
    roomId = theRoom;

    String sAction = 'MSG';
    String sTime = DateFormatUtil().getDateTimeStringNow();
    String sType = 'text';
    if (bShowReply) {
      sAction = 'messageReply';
    }
    if (bImage) {
      sType = 'image';
    }

    // Content content = Content(
    // msgType: sType,
    // content: sContent,
    // time: sTime,
    // replyById: replyByMessageData.memberId,
    // replyByMsg: replyByMessageData.content,
    // replyByContentId: replyByMessageData.contentId,
    // replyByAvatar: replyByMessageData.memberAvatar,
    // replyByNickName: replyByMessageData.nickName,
    // replyByUid: replyByMessageData.uid,
    // otherSideUid: userInfoData.chatUid,
    // otherSideAvatar: userInfoData.chatAvatar,
    // otherSideMemberId: userInfoData.chatMemberId,
    // otherSideNickname: userInfoData.chatNickName,
    // senderAvatar: GlobalData.userInfo.avatar,
    // senderMemberId: GlobalData.userInfo.memberId,
    // senderUid: GlobalData.userInfo.userId,
    // senderNickname: GlobalData.userInfo.nickname,
    // groupType: userInfoData.groupType,
    // groupImgUrl: userInfoData.groupImgUrl,
    // groupName: userInfoData.groupName,
    // roomType: bGroup ? 'group' : 'single'
    // );

    ChatData chatData = ChatData(
      roomId: roomId,
      receiverAvatarId: receiverAcatarId,
      msgType: 'TEXT',
      content: sContent,
      // otherSideMemberId: userInfoData.chatMemberId,
      // content: content,
      // contentId: replyByMessageData.contentId, updateInfo: UpdateInfo() // ChatData
    );

    WsSendMessageData data = WsSendMessageData(
      topic: bGroup ? 'chatGroup' : 'CHAT',
      timestamp: DateTime.now().microsecond,
      action: sAction,
      chatData: chatData,
    );
    WebSocketUtil().sendMessage(data); // 發送msg -> WS
  }
}
