import 'package:sqflite/sqflite.dart';

import '../../data/chat/chat_member_data.dart';
import '../base_table.dart';

/// 聊天對象清單
class ChatMemberTable extends BaseTable {
  static const String tableName = 'chatMemberInfo';
  static const String memberId = 'memberId';
  static const String memberAvatar = 'memberAvatar';
  static const String nickName = 'nickName';
  static const String oldNickName = 'oldNickName';
  static const String uid = 'uid';
  static const String oldUid = 'oldUid';
  static const String time = 'time';

  @override
  List<String> values() {
    return [
      memberId,
      memberAvatar,
      nickName,
      oldNickName,
      uid,
      oldUid,
      time,
    ];
  }

  @override
  Future createTable(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableName ( 
$memberId TEXT PRIMARY KEY,
$memberAvatar TEXT,
$nickName TEXT,
$oldNickName TEXT,
$uid TEXT,
$oldUid TEXT,
$time TEXT
  )
''');
  }
  Future<ChatMemberData> insert(ChatMemberData data) async {
    final db = await instance.database;
    await db.insert(tableName, data.toJson());
    return data;
  }
}
