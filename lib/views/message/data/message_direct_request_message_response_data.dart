import 'dart:convert';

import '../../../view_models/message/websocketdata/ws_send_message_data.dart';
List<MessageDirectRequestMessageResponseData> messageDirectRequestMessageResponseDataFromJson(String str) => 
List<MessageDirectRequestMessageResponseData>.from(json.decode(str).map((x) => MessageDirectRequestMessageResponseData.fromJson(x)));

String messageDirectRequestMessageResponseDataToJson(List<MessageDirectRequestMessageResponseData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageDirectRequestMessageResponseData {
  MessageDirectRequestMessageResponseData({
    this.roomId = '',
    this.roomType = '',
    this.lastMsgTime = '',
    this.pushStatus = '',
    this.groupType = '',
    this.groupName = '',
    this.groupImgUrl = '',
    this.groupJoinTime = '',
    this.unreadCount = 0,
    this.unreadUpdateCount = 0,
    required this.lastChatRecord,
    this.chatNickName = '',
    this.chatAvatar = '',
    this.chatMemberId = '',
    this.chatUid = '',
    this.chatMemberMark = '',
    this.blockStatus = '',
    this.followStatus = '',
    this.readTimeStatus = '',
  });

  String roomId;
  String roomType;
  String lastMsgTime;
  String pushStatus;
  String groupType;
  String groupName;
  String groupImgUrl;
  String groupJoinTime;
  num unreadCount;
  num unreadUpdateCount;
  LastChatRecord lastChatRecord;
  String chatNickName;
  String chatAvatar;
  String chatMemberId;
  String chatUid;
  String chatMemberMark;
  String blockStatus;
  String followStatus;
  String readTimeStatus;

  factory MessageDirectRequestMessageResponseData.fromJson(Map<String, dynamic> json) => MessageDirectRequestMessageResponseData(
    roomId: json["roomId"]??'',
    roomType: json["roomType"]??'',
    lastMsgTime: json["lastMsgTime"]??'',
    pushStatus: json["pushStatus"]??'',
    groupType: json["groupType"]??'',
    groupName: json["groupName"]??'',
    groupImgUrl: json["groupImgUrl"]??'',
    groupJoinTime: json["groupJoinTime"]??'',
    unreadCount: json["unreadCount"]??0,
    unreadUpdateCount: json["unreadUpdateCount"]??0,
    lastChatRecord: json["lastChatRecord"] != null ? LastChatRecord.fromJson(json["lastChatRecord"]) : LastChatRecord(content: Content()),
    chatNickName: json["chatNickName"]??'',
    chatAvatar: json["chatAvatar"]??'',
    chatMemberId: json["chatMemberId"]??'',
    chatUid: json["chatUid"]??'',
    chatMemberMark: json["chatMemberMark"]??'',
    blockStatus: json["blockStatus"]??'',
    followStatus: json["followStatus"]??'followed',
    readTimeStatus: json["readTimeStatus"]??'',
  );

  Map<String, dynamic> toJson() => {
    "roomId": roomId,
    "roomType": roomType,
    "lastMsgTime": lastMsgTime,
    "pushStatus": pushStatus,
    "groupType": groupType,
    "groupName": groupName,
    "groupImgUrl": groupImgUrl,
    "groupJoinTime": groupJoinTime,
    "unreadCount": unreadCount,
    "unreadUpdateCount": unreadUpdateCount,
    "lastChatRecord": lastChatRecord.toJson(),
    "chatNickName": chatNickName,
    "chatAvatar": chatAvatar,
    "chatMemberId": chatMemberId,
    "chatUid": chatUid,
    "chatMemberMark": chatMemberMark,
    "blockStatus": blockStatus,
    "followStatus": followStatus,
    "readTimeStatus": readTimeStatus,
  };
}

class LastChatRecord {
  LastChatRecord({
    this.id = '',
    this.roomId = '',
    this.memberId = '',
    required this.content,
    this.createTime = '',
    this.reads = const [],
  });

  String id;
  String roomId;
  String memberId;
  Content content;
  String createTime;
  List<String> reads;

  factory LastChatRecord.fromJson(Map<String, dynamic> json) => LastChatRecord(
    id: json["id"]??'',
    roomId: json["roomId"]??'',
    memberId: json["memberId"]??'',
    content: json["content"] != null ? Content.fromJson(json["content"]) : Content(),
    createTime: json["createTime"]??'',
    reads: json["reads"] != null ? List<String>.from(json["reads"].map((x) => x)) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roomId": roomId,
    "memberId": memberId,
    "content": content.toJson(),
    "createTime": createTime,
    "reads": List<dynamic>.from(reads.map((x) => x)),
  };
}