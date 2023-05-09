import 'package:base_project/models/database/table/base_table.dart';
import 'package:sqflite/sqflite.dart';

class ChatHistoryTable extends BaseTable {
  static const String tableName = 'chatHistory';
  static const String contentId = 'contentId';
  static const String action = 'action';
  static const String type = 'type';
  static const String roomId = 'roomId';
  static const String uid = 'uid';
  static const String nickName = 'nickName';
  static const String memberId = 'memberId';
  static const String memberAvatar = 'memberAvatar';
  static const String otherSideMemberId = 'otherSideMemberId';
  static const String msgType = 'msgType';
  static const String content = 'content';
  static const String hasRead = 'hasRead';
  static const String recall = 'recall';
  static const String time = 'time';
  static const String replyByContentId = 'replyByContentId';
  static const String replyByMsg = 'replyByMsg';
  static const String replyById = 'replyById';
  static const String replyByNickName = 'replyByNickName';
  static const String replyByUid = 'replyByUid';
  static const String replyByAvatar = 'replyByAvatar';

  @override
  List<String> values() {
    return [
      contentId,
      action,
      type,
      roomId,
      uid,
      nickName,
      memberId,
      memberAvatar,
      otherSideMemberId,
      msgType,
      content,
      hasRead,
      recall,
      time,
      replyByContentId,
      replyByMsg,
      replyById,
      replyByNickName,
      replyByUid,
      replyByAvatar,
    ];
  }

  @override
  Future createTable(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableName ( 
 $contentId TEXT PRIMARY KEY,
$action TEXT,
$type TEXT,
$roomId TEXT,
$uid TEXT,
$nickName TEXT,
$memberId TEXT,
$memberAvatar TEXT,
$otherSideMemberId TEXT,
$msgType TEXT,
$content TEXT,
$hasRead BOOLEAN,
$recall BOOLEAN,
$time TEXT,
$replyByContentId TEXT,
$replyByMsg TEXT,
$replyById TEXT,
$replyByNickName TEXT,
$replyByUid TEXT,
$replyByAvatar TEXT
  )
''');
  }
}
