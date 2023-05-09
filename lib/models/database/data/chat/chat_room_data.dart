import '../../../../constant/enum/chat_enum.dart';
import '../../table/chat/chat_room_table.dart';

/// 聊天室清單
class ChatRoomData {
  const ChatRoomData({
    this.roomId = "",
    this.memberId = "",
    this.content = "",
    this.msgType = ChatContextType.text,
    this.muteStatus = "",
    this.unreadCount = 0,
    this.time = "",
  });

  /// 鍵值
  final String roomId;

  /// 對方的會員編號
  final String memberId;

  /// 最新訊息內容
  final String content;

  /// 訊息內容類型
  final ChatContextType msgType;

  /// 靜音狀態
  final String muteStatus;

  /// 未讀數量
  final num unreadCount;

  /// 最新訊息時間
  final String time;

  static ChatRoomData fromJson(Map<String, Object?> json) => ChatRoomData(
        roomId: json[ChatRoomTable.roomId] as String,
        memberId: json[ChatRoomTable.memberId] as String,
        content: json[ChatRoomTable.content] as String,
        msgType: parseMsgType(json[ChatRoomTable.msgType] as String),
        muteStatus: json[ChatRoomTable.muteStatus] as String,
        unreadCount: json[ChatRoomTable.unreadCount] as num,
        time: json[ChatRoomTable.time] as String,
      );

  Map<String, Object?> toJson() => {
        ChatRoomTable.roomId: roomId,
        ChatRoomTable.memberId: memberId,
        ChatRoomTable.content: content,
        ChatRoomTable.msgType: msgType,
        ChatRoomTable.muteStatus: muteStatus,
        ChatRoomTable.unreadCount: unreadCount,
        ChatRoomTable.time: time,
      };

  ChatRoomData copy({
    String? roomId,
    String? memberId,
    String? content,
    ChatContextType? msgType,
    String? muteStatus,
    num? unreadCount,
    String? time,
  }) =>
      ChatRoomData(
        roomId: roomId ?? this.roomId,
        memberId: memberId ?? this.memberId,
        content: content ?? this.content,
        msgType: msgType ?? this.msgType,
        muteStatus: muteStatus ?? this.muteStatus,
        unreadCount: unreadCount ?? this.unreadCount,
        time: time ?? this.time,
      );

  static ChatContextType parseMsgType(String type) {
    for (var element in ChatContextType.values) {
      if (type == element.name) {
        return element;
      }
    }
    return ChatContextType.values.first;
  }
}
