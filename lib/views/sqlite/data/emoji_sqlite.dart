class EmojiSQLite {
  EmojiSQLite(
      {this.contentId = '',
        this.memberId = '',
        this.memberAvatar = '',
        this.memberUid = '',
        this.roomId = '',
        this.emoji = '',
        this.createTime = '',
      });

  String contentId; // 訊息ID
  String memberId; // 發送者ID
  String memberAvatar; // 發送者頭像
  String memberUid; // 發送者UID
  String roomId; // 房間ID
  String emoji; // 空字串等於無表情(取消表情時發生)
  String createTime; // 發送時間 (沒用到)

  Map<String, dynamic> toMap() {
    return {
      'contentId': contentId,
      'memberId': memberId,
      'memberAvatar': memberAvatar,
      'memberUid': memberUid,
      'roomId': roomId,
      'emoji': emoji,
      'createTime': createTime,
    };
  }
}
