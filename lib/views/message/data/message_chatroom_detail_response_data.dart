
import 'dart:convert';

MessageChatroomDetailResponseData messageChatroomDetailResponseDataFromJson(String str) => MessageChatroomDetailResponseData.fromJson(json.decode(str));

String messageChatroomDetailResponseDataToJson(MessageChatroomDetailResponseData data) => json.encode(data.toJson());

/// 聊天室資訊 以下資料為對方的
class MessageChatroomDetailResponseData {
  MessageChatroomDetailResponseData({
    this.roomType = '',
    this.groupType = '',
    this.groupName = '',
    this.groupImgUrl = '',
    this.readTimeStatus = '',
    this.readTime = '',
    this.chatNickName = '',
    this.chatAvatar = '',
    this.chatMemberId = '',
    this.chatUid = '',
    this.blockStatus = '',
    this.followStatus = 'followed',
    this.chatMemberMark = '',
    this.permissionStatus = '',
    this.members = const [],
  });

  String roomType;
  String groupType;
  String groupName;
  String groupImgUrl;
  String readTimeStatus;
  String readTime;
  String chatNickName;
  String chatAvatar;
  String chatMemberId;
  String chatUid;
  String blockStatus;
  String followStatus;
  String chatMemberMark;
  String permissionStatus;
  List<Member> members;

  factory MessageChatroomDetailResponseData.fromJson(Map<String, dynamic> json) => MessageChatroomDetailResponseData(
    readTimeStatus: json["readTimeStatus"]??'',
    groupType: json["groupType"]??'',
    groupName: json["groupName"]??'',
    groupImgUrl: json["groupImgUrl"]??'',
    roomType: json["roomType"]??'',
    readTime: json["readTime"]??'',
    chatNickName: json["chatNickName"]??'',
    chatAvatar: json["chatAvatar"]??'',
    chatMemberId: json["chatMemberId"]??'',
    chatUid: json["chatUid"]??'',
    blockStatus: json["blockStatus"]??'',
    followStatus: json["followStatus"]??'followed',
    chatMemberMark: json["chatMemberMark"]??'',
    permissionStatus: json["permissionStatus"]??'',
    members: json["members"] != null ? List<Member>.from(json["members"].map((x) => Member.fromJson(x))) : []
  );

  Map<String, dynamic> toJson() => {
    "readTimeStatus": readTimeStatus,
    "groupType": groupType,
    "groupName": groupName,
    "groupImgUrl": groupImgUrl,
    "roomType": roomType,
    "readTime": readTime,
    "chatNickName": chatNickName,
    "chatAvatar": chatAvatar,
    "chatMemberId": chatMemberId,
    "chatUid": chatUid,
    "blockStatus": blockStatus,
    "followStatus": followStatus,
    "chatMemberMark" :chatMemberMark,
    "permissionStatus" :permissionStatus,
    "members": List<dynamic>.from(members.map((x) => x.toJson()))
  };

  /// 有無回傳徽章
  bool hasMarked() {
    return (chatMemberMark.compareTo('blue') == 0);
  }
}

class Member {
  Member({
    this.readTimeStatus = '',
    this.readTime = '',
    this.chatNickName = '',
    this.chatAvatar = '',
    this.chatMemberId = '',
    this.chatUid = '',
    this.chatMemberMark = '',
    this.blockStatus = '',
    this.followStatus = '',
    this.permissionStatus = '',
  });

  String readTimeStatus; // 顯示:enable、不顯示:disable
  String readTime;
  String chatNickName;
  String chatAvatar;
  String chatMemberId;
  String chatUid;
  String chatMemberMark; // 空字串:無、藍勾:blue
  String blockStatus; // 正常:normal 封鎖:blocked
  String followStatus; // 已追蹤:followed 未追蹤:none
  String permissionStatus; // 禁言:silence、一般:normal、管理員:keeper

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    readTimeStatus: json["readTimeStatus"]??'',
    readTime: json["readTime"]??'',
    chatNickName: json["chatNickName"]??'',
    chatAvatar: json["chatAvatar"]??'',
    chatMemberId: json["chatMemberId"]??'',
    chatUid: json["chatUid"]??'',
    chatMemberMark: json["chatMemberMark"]??'',
    blockStatus: json["blockStatus"]??'',
    followStatus: json["followStatus"]??'',
    permissionStatus: json["permissionStatus"]??'',
  );

  Map<String, dynamic> toJson() => {
    "readTimeStatus": readTimeStatus,
    "readTime": readTime,
    "chatNickName": chatNickName,
    "chatAvatar": chatAvatar,
    "chatMemberId": chatMemberId,
    "chatUid": chatUid,
    "chatMemberMark": chatMemberMark,
    "blockStatus": blockStatus,
    "followStatus": followStatus,
    "permissionStatus": permissionStatus,
  };
}
