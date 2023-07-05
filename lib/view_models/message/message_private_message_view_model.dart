import 'package:base_project/models/http/data/dynamic_info_data.dart';
import 'package:base_project/utils/pitch_data_util.dart';
import 'package:base_project/view_models/message/websocket/web_socket_util.dart';
import 'package:base_project/view_models/message/websocketdata/ws_send_message_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/enum/app_param_enum.dart';
import '../../constant/theme/global_data.dart';
import '../../models/app_shared_preferences.dart';
import '../../models/http/api/message_api.dart';
import '../../utils/date_format_util.dart';
import '../../../views/message/sqlite/data/chat_history_sqlite.dart';
import '../../views/message/sqlite/chat_history_db.dart';
import '../base_view_model.dart';
import '../../constant/call_back_function.dart';
import '../../views/message/data/message_chatroom_detail_response_data.dart';
import '../../models/app_shared_preferences.dart';
import '../dynmaic/is_rebecca_provider.dart';

final imgListProvider = Provider<List<String>>((ref) {
  final dynamicList = PitchDataUtil().buildSelf(8);
  final imgList = <String>[];
  for (var dynamicData in dynamicList) {
    imgList.add(dynamicData.images.first);
  }
  return imgList;
});

final showImageWallProvider = StateProvider<bool>((ref) => true);
final showRecordProvider = StateProvider.autoDispose<bool>((ref) => false);

final playingContentIdProvider = StateProvider<String>((ref) {
  return '';
});

final durationListProvider = StateProvider<Map<String,String>>((ref) {
  return {};
});

final readListProvider = StateProvider<List<String>>((ref) {
  return [];
});

class MessagePrivateGroupMessageViewModel extends BaseViewModel {
  final WidgetRef ref;
  MessagePrivateGroupMessageViewModel(this.ref);
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();
  bool bShowReply = false; // 回覆
  bool isFocus = false;
  String roomId = GlobalData.roomId;
  String receiverAcatarId = GlobalData.friendAvatarId;
  String rebeccaImg = PitchDataUtil().getAvatar(MyGramAI.Rebecca);
  String sType = '';
  ChatHistorySQLite replyByMessageData = ChatHistorySQLite(); // 暫存所要回覆的訊息
  MessageChatroomDetailResponseData _chatroomDetailData = MessageChatroomDetailResponseData();
  String filePrefix = '';
  // List<String> imageList = [];

  // Future<MessageChatroomDetailResponseData> getChatroomDetail(String roomId,
  //   {ResponseErrorFunction? onConnectFail}) async {
  //     return await MessageApi(onConnectFail: onConnectFail)
  //     .getChatroomDetail(roomId: roomId);
  // }

  final showingListProvider = StateProvider<List<ChatHistorySQLite>>((ref) => []);

  final StateProvider<List<String>> imgList = StateProvider((ref) => []);

  Future<void> onTapMicrophone(bool isOnTab) async {
    if (isOnTab) {
      ref.read(showRecordProvider.notifier).update((state) => false);
    } else {
      ref.read(showRecordProvider.notifier).update((state) => !state);
    }
  }

  Future<void> checkImgWall() async {
    AppSharedPreferences.checkWallClose(roomId).then((value) {
      if (value == null) {
        AppSharedPreferences.setWall(
          roomId,
          true,
        );
        ref.read(showImageWallProvider.notifier).update((state) => true);
      } else {
        ref.read(showImageWallProvider.notifier).update((state) => value);
      }
    });
  }

  Future<void> changeImgWallState(bool closeOrOpen) async {
    ref.read(showImageWallProvider.notifier).update((state) => closeOrOpen);
    AppSharedPreferences.setWall(roomId, closeOrOpen);
  }

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

  void onSendMessage(String sContent, bool bImage, String type) {
    if (!bImage) {
      // false=文字訊息 檢查是否空字串
      bool bShow = checkInputEmpty(sContent);
      if (!bShow) {
        return;
      }
    }
    sType = type;
    sendMessage(bShowReply, bImage, sContent, roomId, false);
    // 清掉
    // replyByMessageData = ChatHistorySQLite(chatData: ChatData());
    textController.clear(); // 發送完清除剛輸入的
  }

  void sendMessage(bool bShowReply, bool bImage, String sContent, String theRoom, bool bGroup) {
    roomId = theRoom;

    String sAction = 'MSG';
    String sTime = DateFormatUtil().getDateTimeStringNow();

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
      msgType: sType,
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
    sType = '';
  }

  Future<String> getFilePrefix() async {
    final data = await MessageApi().getFilePrefix();
    // filePrefix = data.data;
    return data.data;
  }

  Future<String> uploadFile(String fileType, String filePath) async {
    final data = await MessageApi().uploadFile(fileType, filePath);
    return data.data;
  }

 void onShowSelfDynamic(BuildContext context, int index) {
    ref.read(isRebeccaProvider.notifier).update((state) => true);
    BaseViewModel().changeMainScreenPage(AppNavigationBarType.typeDynamic,isRebecca: true,index: index);
  }
}
