import '../../table/chat/chat_member_table.dart';

/// 聊天對象清單
class ChatMemberData {
  const ChatMemberData({this.memberId = "",
    this.memberAvatar = "",
    this.nickName = "",
    this.oldNickName = "",
    this.uid = "",
    this.oldUid = "",
    this.time = "",});

  /// ID
  final String memberId;
  /// 頭像
  final String memberAvatar;
  /// 暱稱
  final String nickName;
  /// 舊暱稱
  final String oldNickName;
  /// uid
  final String uid;
  /// 舊uid
  final String oldUid;
  /// yyyy/mm/dd hh:mm:ss.sss
  final String time;

  static ChatMemberData fromJson(Map<String, Object?> json) =>
      ChatMemberData(
        memberId : json[ChatMemberTable.memberId]as String,
        memberAvatar : json[ChatMemberTable.memberAvatar]as String,
        nickName : json[ChatMemberTable.nickName]as String,
        oldNickName : json[ChatMemberTable.oldNickName]as String,
        uid : json[ChatMemberTable.uid]as String,
        oldUid : json[ChatMemberTable.oldUid]as String,
        time : json[ChatMemberTable.time]as String,
      );

  Map<String, Object?> toJson() => {
    ChatMemberTable.memberId : memberId,
    ChatMemberTable.memberAvatar : memberAvatar,
    ChatMemberTable.nickName : nickName,
    ChatMemberTable.oldNickName : oldNickName,
    ChatMemberTable.uid : uid,
    ChatMemberTable.oldUid : oldUid,
    ChatMemberTable.time : time,
  };

  ChatMemberData copy({
    String? memberId,
    String? memberAvatar,
    String? nickName,
    String? oldNickName,
    String? uid,
    String? oldUid,
    String? time,
  }) =>
      ChatMemberData(
        memberId : memberId ?? this.memberId,
        memberAvatar : memberAvatar ?? this.memberAvatar,
        nickName : nickName ?? this.nickName,
        oldNickName : oldNickName ?? this.oldNickName,
        uid : uid ?? this.uid,
        oldUid : oldUid ?? this.oldUid,
        time : time ?? this.time,
      );
}
