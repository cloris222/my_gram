import 'package:sqflite/sqflite.dart';

import '../base_table.dart';

/// 聊天室清單
class ChatRoomTable extends BaseTable {
  static const String tableName = 'chatRoom';
  static const String roomId = 'roomId';
  static const String memberId = 'memberId';
  static const String content = 'content';
  static const String msgType = 'msgType';
  static const String muteStatus = 'muteStatus';
  static const String unreadCount = 'unreadCount';
  static const String time = 'time';

  @override
  List<String> values() {
    return [
      roomId,
      memberId,
      content,
      msgType,
      muteStatus,
      unreadCount,
      time,
    ];
  }

  @override
  Future createTable(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableName ( 
$roomId TEXT PRIMARY KEY,
$memberId TEXT,
$content TEXT,
$msgType TEXT,
$muteStatus TEXT,
$unreadCount INTEGER,
$time TEXT
  )
''');
  }
}
