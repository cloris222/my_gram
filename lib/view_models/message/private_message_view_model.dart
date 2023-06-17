import 'package:base_project/view_models/base_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivateMessageViewModel extends BaseViewModel {
  PrivateMessageViewModel(this.ref);
  final WidgetRef ref;

  // void _setUserData() {
    // userData.memberId = _chatroomDetailData.chatMemberId;
    // userData.nickname = _chatroomDetailData.chatNickName;
    // userData.userId = _chatroomDetailData.chatUid;
    // userData.avatar = _chatroomDetailData.chatAvatar;
    // userData.mark = _chatroomDetailData.chatMemberMark;

    // ChatroomListSQLiteData dbData = ChatroomListSQLiteData();
    // dbData.roomId = roomId;
    // dbData.roomType = 'single';
    // dbData.blockStatus = _chatroomDetailData.blockStatus;
    // dbData.chatMemberMark = _chatroomDetailData.chatMemberMark;
    // dbData.uId = _chatroomDetailData.chatUid;
    // dbData.avatar = _chatroomDetailData.chatAvatar;
    // dbData.memberId = _chatroomDetailData.chatMemberId;
    // dbData.readTimeStatus = _chatroomDetailData.readTimeStatus;
    // ChatroomListDB.updateChatRoomDetail(dbData);

    // bReadTimeStatus = _chatroomDetailData.readTimeStatus == 'enable';

    // setState(() {});
  // }
}
