import '../../../../constant/enum/chat_enum.dart';
import '../../table/chat/chat_history_table.dart';

/// 訊息紀錄
class ChatHistoryData {
  const ChatHistoryData({
    this.contentId = "",
    this.action = ChatAction.message,
    this.type = ChatType.chat,
    this.roomId = "",
    this.uid = "",
    this.nickName = "",
    this.memberId = "",
    this.memberAvatar = "",
    this.otherSideMemberId = "",
    this.msgType = ChatContextType.text,
    this.content = "",
    this.hasRead = false,
    this.recall = false,
    this.time = "",
    this.replyByContentId = "",
    this.replyByMsg = "",
    this.replyById = "",
    this.replyByNickName = "",
    this.replyByUid = "",
    this.replyByAvatar = "",
  });

  /// 訊息ID 唯一值
  final String contentId;

  /// 動作紀錄
  final ChatAction action;

  /// 類型
  final ChatType type;

  /// 房間號
  final String roomId;

  /// 發送者UID or 被修改者UID
  final String uid;

  /// 發送者暱稱
  final String nickName;

  /// 發送者ID or 被修改者ID
  final String memberId;

  /// 發送者頭像 or 被修改者頭像
  final String memberAvatar;

  /// 接收者ID
  final String otherSideMemberId;

  /// 訊息內容類型
  final ChatContextType msgType;

  /// 訊息內容
  final String content;

  /// 是否已讀過
  final bool hasRead;

  /// 是否收回
  final bool recall;

  /// 建立時間 yyyy/mm/dd hh:mm:ss.sss
  final String time;

  /// 回覆的 某則訊息ID
  final String replyByContentId;

  /// 回覆的 某則訊息
  final String replyByMsg;

  /// 回覆的 某則訊息之所屬memberID
  final String replyById;

  /// 回覆的 某則訊息之所屬的暱稱
  final String replyByNickName;

  /// 回覆的 某則訊息之所屬的uid
  final String replyByUid;

  /// 回覆的 某則訊息之所屬的頭像
  final String replyByAvatar;

  static ChatHistoryData fromJson(Map<String, Object?> json) => ChatHistoryData(
        contentId: json[ChatHistoryTable.contentId] as String,
        action: parseAction(json[ChatHistoryTable.action] as String),
        type: parseType(json[ChatHistoryTable.type] as String),
        roomId: json[ChatHistoryTable.roomId] as String,
        uid: json[ChatHistoryTable.uid] as String,
        nickName: json[ChatHistoryTable.nickName] as String,
        memberId: json[ChatHistoryTable.memberId] as String,
        memberAvatar: json[ChatHistoryTable.memberAvatar] as String,
        otherSideMemberId: json[ChatHistoryTable.otherSideMemberId] as String,
        msgType: parseMsgType(json[ChatHistoryTable.msgType] as String),
        content: json[ChatHistoryTable.content] as String,
        hasRead: json[ChatHistoryTable.hasRead] == 1,
        recall: json[ChatHistoryTable.recall] == 1,
        time: json[ChatHistoryTable.time] as String,
        replyByContentId: json[ChatHistoryTable.replyByContentId] as String,
        replyByMsg: json[ChatHistoryTable.replyByMsg] as String,
        replyById: json[ChatHistoryTable.replyById] as String,
        replyByNickName: json[ChatHistoryTable.replyByNickName] as String,
        replyByUid: json[ChatHistoryTable.replyByUid] as String,
        replyByAvatar: json[ChatHistoryTable.replyByAvatar] as String,
      );

  Map<String, Object?> toJson() => {
        ChatHistoryTable.contentId: contentId,
        ChatHistoryTable.action: action.name,
        ChatHistoryTable.type: type.name,
        ChatHistoryTable.roomId: roomId,
        ChatHistoryTable.uid: uid,
        ChatHistoryTable.nickName: nickName,
        ChatHistoryTable.memberId: memberId,
        ChatHistoryTable.memberAvatar: memberAvatar,
        ChatHistoryTable.otherSideMemberId: otherSideMemberId,
        ChatHistoryTable.msgType: msgType.name,
        ChatHistoryTable.content: content,
        ChatHistoryTable.hasRead: hasRead ? 1 : 0,
        ChatHistoryTable.recall: recall ? 1 : 0,
        ChatHistoryTable.time: time,
        ChatHistoryTable.replyByContentId: replyByContentId,
        ChatHistoryTable.replyByMsg: replyByMsg,
        ChatHistoryTable.replyById: replyById,
        ChatHistoryTable.replyByNickName: replyByNickName,
        ChatHistoryTable.replyByUid: replyByUid,
        ChatHistoryTable.replyByAvatar: replyByAvatar,
      };

  ChatHistoryData copy({
    String? contentId,
    ChatAction? action,
    ChatType? type,
    String? roomId,
    String? uid,
    String? nickName,
    String? memberId,
    String? memberAvatar,
    String? otherSideMemberId,
    ChatContextType? msgType,
    String? content,
    bool? hasRead,
    bool? recall,
    String? time,
    String? replyByContentId,
    String? replyByMsg,
    String? replyById,
    String? replyByNickName,
    String? replyByUid,
    String? replyByAvatar,
  }) =>
      ChatHistoryData(
        contentId: contentId ?? this.contentId,
        action: action ?? this.action,
        type: type ?? this.type,
        roomId: roomId ?? this.roomId,
        uid: uid ?? this.uid,
        nickName: nickName ?? this.nickName,
        memberId: memberId ?? this.memberId,
        memberAvatar: memberAvatar ?? this.memberAvatar,
        otherSideMemberId: otherSideMemberId ?? this.otherSideMemberId,
        msgType: msgType ?? this.msgType,
        content: content ?? this.content,
        hasRead: hasRead ?? this.hasRead,
        recall: recall ?? this.recall,
        time: time ?? this.time,
        replyByContentId: replyByContentId ?? this.replyByContentId,
        replyByMsg: replyByMsg ?? this.replyByMsg,
        replyById: replyById ?? this.replyById,
        replyByNickName: replyByNickName ?? this.replyByNickName,
        replyByUid: replyByUid ?? this.replyByUid,
        replyByAvatar: replyByAvatar ?? this.replyByAvatar,
      );

  ///將字串轉型成enum
  static ChatAction parseAction(String type) {
    for (var element in ChatAction.values) {
      if (type == element.name) {
        return element;
      }
    }
    return ChatAction.values.first;
  }

  static ChatType parseType(String type) {
    for (var element in ChatType.values) {
      if (type == element.name) {
        return element;
      }
    }
    return ChatType.values.first;
  }

  static ChatContextType parseMsgType(String type) {
    for (var element in ChatContextType.values) {
      if (type == element.name) {
        return element;
      }
    }
    return ChatContextType.values.first;
  }
}
