import 'dart:convert';

WsSendMessageData wsSendMessageDataFromJson(String str) => WsSendMessageData.fromJson(json.decode(str));

String wsSendMessageDataToJson(WsSendMessageData data) => json.encode(data.toJson());

class WsSendMessageData {
  WsSendMessageData({
    required this.topic,
    required this.action,
    required this.chatData,
    required this.timestamp,
  });

  String topic;
  String action;
  ChatData chatData;
  int timestamp;

  factory WsSendMessageData.fromJson(Map<String, dynamic> json) => WsSendMessageData(
    topic: json["topic"] ?? '',
    action: json["action"] ?? '',
    chatData: ChatData.fromJson(json["chatData"]),
    timestamp: json["timestamp"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "action": action,
    "chatData": chatData.toJson(),
    "timestamp": timestamp,
  };
}

class ChatData {
  ChatData({
    this.roomId = "0",
    this.receiverAvatarId = "0",
    this.msgType = '',
    this.content = '',
    this.contentId = '',

    // this.otherSideMemberId = '',
    // this.chatMemberId = '',
    // this.contentId,
    // this.callAction = '',
    // this.callStatus = '',
    // this.callDuration = '',
    // this.callId = '',
    // this.emoji = '',
    // this.readAllTime = '',
    // this.stickerReply = const [],
    // this.read = const [],
    // this.readRooms = const [],
    // required this.content,
    // this.updateInfo,
    // this.agoraInfo,
  });

  String roomId;
  String receiverAvatarId;
  String msgType;
  String content;
  String contentId;

  // String emoji;
  // String otherSideMemberId;
  // String chatMemberId;
  // String callAction;
  // String callStatus;
  // String callDuration;
  // String callId;
  // String readAllTime;
  // Content content;
  // dynamic contentId;
  // List<StickerReply> stickerReply;
  // List<String> read;
  // List<String> readRooms;
  // UpdateInfo? updateInfo;
  // AgoraInfo? agoraInfo;

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        roomId: (json["roomId"] ?? 0).toString(),
        receiverAvatarId: (json["receiverAvatarId"] ?? 0).toString(),
        msgType: json["msgType"] ?? '',
        content: json["content"] ?? '',
        contentId: json["contentId"]??'',
        // emoji: json["emoji"] ?? '',
        // otherSideMemberId: json["otherSideMemberId"] ?? '',
        // chatMemberId: json["otherSideMemberId"] ?? '',
        // callAction: json["callAction"] ?? '',
        // callStatus: json["callStatus"] ?? '',
        // callDuration: json["callDuration"] ?? '',
        // callId: json["callId"] ?? '',
        // readAllTime: json["readAllTime"] ?? '',
        // content: json["content"] != null ? Content.fromJson(json["content"]) : Content(),
        // stickerReply: json["stickerReply"] != null
        //     ? List<StickerReply>.from(json["stickerReply"].map((x) => StickerReply.fromJson(x)))
        //     : [],
        // read: json["read"] != null ? List<String>.from(json["read"].map((x) => x)) : [],
        // readRooms: json["readRooms"] != null ? List<String>.from(json["readRooms"].map((x) => x)) : [],
        // contentId: json["contentId"] ?? '',
        // updateInfo: json["updateInfo"] != null ? UpdateInfo.fromJson(json["updateInfo"]) : UpdateInfo(),
        // agoraInfo: json["agoraInfo"] != null? AgoraInfo.fromJson(json["agoraInfo"]) : AgoraInfo(),
      );

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "receiverAvatarId": receiverAvatarId,
        "msgType": msgType,
        "content": content,
        "contentId": contentId,
        // "emoji": emoji,
        // "otherSideMemberId": otherSideMemberId,
        // "chatMemberId": chatMemberId,
        // "callAction": callAction,
        // "callStatus": callStatus,
        // "callDuration": callDuration,
        // "callId": callId,
        // "readAllTime": readAllTime,
        // "content": content.toJson(),
        // "updateInfo": updateInfo?.toJson(),
        // "contentId": contentId,
        // "stickerReply": List<dynamic>.from(stickerReply.map((x) => x.toJson())),
        // "read": List<dynamic>.from(read.map((x) => x)),
        // "readRooms": List<dynamic>.from(readRooms.map((x) => x)),
        // "agoraInfo": agoraInfo?.toJson(),
      };
}

class UpdateInfo {
  UpdateInfo({
    this.action = '',
    this.afterValue = '',
    this.beforeValue = '',
    this.createTime = '',
    this.memberAvatar = '',
    this.memberId = '',
    this.memberUid = '',
    this.operator = '',
    this.operatorAvatar = '',
    this.operatorUid = '',
  });

  String action;
  String afterValue;
  String beforeValue;
  String createTime;
  String memberAvatar;
  String memberId;
  String memberUid;
  String operator;
  String operatorAvatar;
  String operatorUid;

  factory UpdateInfo.fromJson(Map<String, dynamic> json) => UpdateInfo(
        action: json["action"] ?? '',
        afterValue: json["afterValue"] ?? '',
        beforeValue: json["beforeValue"] ?? '',
        createTime: json["createTime"] ?? '',
        memberAvatar: json["memberAvatar"] ?? '',
        memberId: json["memberId"] ?? '',
        memberUid: json["memberUid"] ?? '',
        operator: json["operator"] ?? '',
        operatorAvatar: json["operatorAvatar"] ?? '',
        operatorUid: json["operatorUid"] ?? '',
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
      };
}

class Content {
  Content({
    this.content = '',

    // this.msgType = '',
    // this.message = '',
    // this.replyByContentId = '',
    // this.replyByMsg = '',
    // this.replyById = '',
    // this.replyByAvatar = '',
    // this.replyByNickName = '',
    // this.replyByUid = '',
    // this.time = '',
    // this.otherSideMemberId = '',
    // this.otherSideUid = '',
    // this.otherSideNickname = '',
    // this.otherSideAvatar = '',
    // this.senderUid = '',
    // this.senderNickname = '',
    // this.senderMemberId = '',
    // this.senderAvatar = '',
    // this.groupType = '',
    // this.groupName = '',
    // this.groupImgUrl = '',
    // this.roomType = '',
    // this.type = '',
    // this.creatorInfo,
    // this.joinerInfo
  });

  String content;

  // String msgType; // 文字或是圖片 text/image
  // String type;
  // String message;
  // String replyByContentId;
  // String replyByMsg;
  // String replyById;
  // String replyByAvatar;
  // String replyByNickName;
  // String replyByUid;
  // String time;
  // String otherSideMemberId;
  // String otherSideUid;
  // String otherSideAvatar;
  // String otherSideNickname;
  // String senderUid;
  // String senderMemberId;
  // String senderAvatar;
  // String senderNickname;
  // String groupType;
  // String groupName;
  // String groupImgUrl;
  // String roomType;
  // UserInfoData? creatorInfo;
  // UserInfoData? joinerInfo;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        content: json["content"] ?? '',

        // msgType: json["msgType"]??'',
        // message: json["message"]??'',
        // replyByContentId: json["replyByContentId"]??'',
        // replyByMsg: json["replyByMsg"]??'',
        // replyById: json["replyById"]??'',
        // replyByAvatar: json["replyByAvatar"]??'',
        // replyByNickName: json["replyByNickName"]??'',
        // replyByUid: json["replyByUid"]??'',
        // time: json["time"]??'',
        // otherSideMemberId: json["otherSideMemberId"]??'',
        // otherSideUid: json["otherSideUid"]??'',
        // otherSideAvatar: json["otherSideAvatar"]??'',
        // otherSideNickname: json["otherSideNickname"]??'',
        // senderUid: json["senderUid"]??'',
        // senderMemberId: json["senderMemberId"]??'',
        // senderAvatar: json["senderAvatar"]??'',
        // senderNickname: json["senderNickname"]??'',
        // groupType: json["groupType"]??'',
        // groupName: json["groupName"]??'',
        // groupImgUrl: json["groupImgUrl"]??'',
        // roomType: json["roomType"]??'',
        // type: json["type"]??'',
        // creatorInfo: json["creatorInfo"] != null? UserInfoData.fromJson(json["creatorInfo"]) : UserInfoData(avatar: ''),
        // joinerInfo: json["joinerInfo"] != null? UserInfoData.fromJson(json["joinerInfo"]) : UserInfoData(avatar: ''),
      );

  Map<String, dynamic> toJson() => {
        "content": content,

        // "msgType": msgType,
        // "message": message,
        // "replyByContentId": replyByContentId,
        // "replyByMsg": replyByMsg,
        // "replyById": replyById,
        // "replyByAvatar": replyByAvatar,
        // "replyByNickName": replyByNickName,
        // "replyByUid": replyByUid,
        // "time": time,
        // "otherSideMemberId": otherSideMemberId,
        // "otherSideUid": otherSideUid,
        // "otherSideAvatar": otherSideAvatar,
        // "otherSideNickname": otherSideNickname,
        // "senderUid": senderUid,
        // "senderMemberId": senderMemberId,
        // "senderAvatar": senderAvatar,
        // "senderNickname": senderNickname,
        // "groupType": groupType,
        // "groupName": groupName,
        // "groupImgUrl": groupImgUrl,
        // "roomType": roomType,
        // "type":type,
        // "creatorInfo": creatorInfo?.toJson(),
        // "joinerInfo": joinerInfo?.toJson(),
      };
}

class StickerReply {
  StickerReply(
      {this.memberId = '', // 發送者
      this.emoji = ''});

  String memberId;
  String emoji;

  factory StickerReply.fromJson(Map<String, dynamic> json) =>
      StickerReply(memberId: json["memberId"] ?? '', emoji: json["emoji"] ?? '');

  Map<String, dynamic> toJson() => {"memberId": memberId, "emoji": emoji};
}
