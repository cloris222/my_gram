// To parse this JSON data, do
//
//     final messageRecordResponseData = messageRecordResponseDataFromJson(jsonString);

import 'dart:convert';
import '../../../view_models/message/websocketdata/ws_send_message_data.dart';

MessageRecordResponseData messageRecordResponseDataFromJson(String str) => MessageRecordResponseData.fromJson(json.decode(str));

String messageRecordResponseDataToJson(MessageRecordResponseData data) => json.encode(data.toJson());

class MessageRecordResponseData {
  MessageRecordResponseData({
    this.type = 'chat',
    this.id = '',
    this.roomId = '',
    this.memberId = '',
    this.createTime = '',
    this.callStatus = '',
    this.callDuration = '',
    this.reads = const [],
    required this.content,
    required this.chatroomUpdateInfo,
  });

  String type; // chat:聊天記錄、update:修改記錄
  String id; // 訊息編號
  String roomId;
  String memberId;
  String createTime;
  String callStatus; // calling:開啟通話、timeOut:超時未接(取消通話)、reject:拒絕通話、end:結束通話
  String callDuration; // 通話時長
  List<String> reads;
  Content content;
  ChatroomUpdateInfo chatroomUpdateInfo;

  factory MessageRecordResponseData.fromJson(Map<String, dynamic> json) => MessageRecordResponseData(
    id: json["id"]??'',
    type: json["type"]??'',
    roomId: json["roomId"]??'',
    memberId: json["memberId"]??'',
    callStatus: json["callStatus"]??'',
    callDuration: json["callDuration"]??'',
    content: json["content"] != null ? Content.fromJson(json["content"]) : Content(),
    createTime: json["createTime"]??'',
    reads: json["reads"] == null ? [] : List<String>.from(json["reads"]!.map((x) => x)),
    chatroomUpdateInfo: json["chatroomUpdateInfo"] != null ? ChatroomUpdateInfo.fromJson(json["chatroomUpdateInfo"]) : ChatroomUpdateInfo(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "roomId": roomId,
    "memberId": memberId,
    "callStatus": callStatus,
    "callDuration": callDuration,
    "content": content.toJson(),
    "chatroomUpdateInfo": chatroomUpdateInfo.toJson(),
    "createTime": createTime,
    "reads": reads.isEmpty ? [] : List<dynamic>.from(reads.map((x) => x)),
  };
}

class ChatroomUpdateInfo {
  ChatroomUpdateInfo({
    this.action = '',
    this.afterValue = '',
    this.beforeValue = '',
    this.createTime = '',
    this.id = '',
    this.memberAvatar = '',
    this.memberId = '',
    this.memberUid = '',
    this.operator = '',
    this.operatorAvatar = '',
    this.operatorUid = '',
    this.roomId = '',
  });

  String action;
  String afterValue;
  String beforeValue;
  String createTime;
  String id;
  String memberAvatar;
  String memberId;
  String memberUid;
  String operator;
  String operatorAvatar;
  String operatorUid;
  String roomId;

  factory ChatroomUpdateInfo.fromJson(Map<String, dynamic> json) => ChatroomUpdateInfo(
    action: json["action"]??'',
    afterValue: json["afterValue"]??'',
    beforeValue: json["beforeValue"]??'',
    createTime: json["createTime"]??'',
    memberAvatar: json["memberAvatar"]??'',
    memberId: json["memberId"]??'',
    memberUid: json["memberUid"]??'',
    operator: json["operator"]??'',
    operatorAvatar: json["operatorAvatar"]??'',
    operatorUid: json["operatorUid"]??'',
    id: json["id"]??'',
    roomId: json["roomId"]??'',
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "afterValue": afterValue,
    "beforeValue": beforeValue,
    "createTime": createTime,
    "memberAvatar": memberAvatar,
    "memberId": memberId,
    "memberUid": memberUid,
    "operator": operator,
    "operatorAvatar": operatorAvatar,
    "operatorUid": operatorUid,
    "id": id,
    "roomId": roomId,
  };
}