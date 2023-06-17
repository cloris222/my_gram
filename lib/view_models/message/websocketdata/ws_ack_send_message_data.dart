import 'dart:convert';
import '../../../view_models/message/websocketdata/ws_send_message_data.dart';

WsAckSendMessageData wsAckSendMessageDataFromJson(String str) => WsAckSendMessageData.fromJson(json.decode(str));

String wsAckSendMessageDataToJson(WsAckSendMessageData data) => json.encode(data.toJson());

class WsAckSendMessageData {
  // ChatData 跟 Content 沿用發送訊息的
  WsAckSendMessageData({
    this.topic = '',
    this.action = '',
    required this.chatData,
    this.code = '',
    this.message = '',
    this.timestamp = 0,
  });

  String action; // 訊息:message、已讀:read、收回:recall、emoji回應:stickerReply、訊息回應:messageReply
  ChatData chatData;
  String code;
  String message;
  int timestamp;
  String topic;

  factory WsAckSendMessageData.fromJson(Map<String, dynamic> json) => WsAckSendMessageData(
    topic: json["topic"] ?? '',
    action: json["action"] ?? '',
    chatData: ChatData.fromJson(json["chatData"]),
    // json["chatData"] != null
    //   ? ChatData.fromJson(json["chatData"])
    //   : ChatData(),
    code: json["code"] ?? '',
    message: json["message"] ?? '',
    timestamp: json["timestamp"] ?? -1,
  );

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "action": action,
    "chatData": chatData.toJson(),
    "code": code,
    "message": message,
    "timestamp": timestamp,
  };
}
