import 'emoji_sqlite.dart';

class ChatHistorySQLite {
  ChatHistorySQLite(
      {this.roomId = '',
        this.uid = '',
        this.nickName = '',
        this.memberId = '',
        this.memberAvatar = '',
        this.action = '',
        this.type = '',
        this.callStatus = '',
        this.callDuration = '',
        this.msgType = '',
        this.content = '',
        this.contentId = '',
        this.hasRead = 'false',
        this.recall = '',
        this.time = '',
        this.replyByMsg = '',
        this.replyById = '',
        this.replyByNickName = '',
        this.replyByUid = '',
        this.replyByAvatar = '',
        this.replyByContentId = '',
        this.otherSideMemberId = '',
        this.emojiDataList = const [],
        this.afterValue = '',
        this.beforeValue = '',
        this.id = '',
        this.operator = '',
        this.operatorAvatar = '',
        this.operatorUid = '',
      });

  // 訊息的類別： message / stickerReply / read / recall
  // 修改的類別： memberUid / memberAvatar / groupName / groupImg / addToGroup / withdrawFromGroup
  //            groupType(目前沒有) / groupPermission
  String action;
  String type; // chat:聊天記錄、update:修改記錄\

  String callStatus; // calling:開啟通話、timeOut:超時未接or取消通話、reject:拒絕通話、end:結束通話
  String callDuration; // 通話時長
  String roomId; // 房間號
  String uid; // 發送者UID or 被修改者UID
  String nickName; // 發送者暱稱
  String memberId; // 發送者ID or 被修改者ID
  String memberAvatar; // 發送者頭像 or 被修改者頭像
  String otherSideMemberId; // 接收者ID
  String msgType; // 文字或是圖片 text / image
  String content; // 訊息內容
  String contentId; // 訊息ID 唯一值
  String hasRead; // 是否已讀過 true / false
  String recall; // 是否收回 true / false
  String time; // yyyy/mm/dd hh:mm:ss.sss
  String replyByMsg; // 回覆的 某則訊息
  String replyById; // 回覆的 某則訊息之所屬memberID
  String replyByNickName; // 回覆的 某則訊息之所屬的暱稱
  String replyByUid; // 回覆的 某則訊息之所屬的uid
  String replyByAvatar; // 回覆的 某則訊息之所屬的頭像
  String replyByContentId; // 回覆的 某則訊息ID
  List<EmojiSQLite> emojiDataList; // 回覆之表情List (List才可用於群聊)

  String afterValue; // 修改後的值
  String beforeValue; // 修改前的值
  String id; // 修改記錄單號
  String operator; // 操作人memberId
  String operatorAvatar; // 操作人頭像
  String operatorUid; // 操作人uid

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'uid': uid,
      'nickName': nickName,
      'memberId': memberId,
      'memberAvatar': memberAvatar,
      'action': action,
      'type': type,
      'callStatus': callStatus,
      'callDuration': callDuration,
      'msgType': msgType,
      'content': content,
      'contentId': contentId,
      'hasRead': hasRead,
      'recall': recall,
      'time': time,
      'replyByMsg': replyByMsg,
      'replyById': replyById,
      'replyByNickName': replyByNickName,
      'replyByUid': replyByUid,
      'replyByAvatar': replyByAvatar,
      'replyByContentId': replyByContentId,
      'otherSideMemberId': otherSideMemberId,
      'afterValue': afterValue,
      'beforeValue': beforeValue,
      'id': id,
      'operator': operator,
      'operatorAvatar': operatorAvatar,
      'operatorUid': operatorUid,
    };
  }
}