import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:base_project/constant/theme/global_data.dart';
import '../../../views/message/sqlite/data/chat_history_sqlite.dart';

class ChatHistoryDB{
  static Database? database;
  static final ChatHistoryDB instance = ChatHistoryDB._init();
  ChatHistoryDB._init();

  Future<Database> get database2 async {
    if (database != null) return database!;

    database = await initDatabase();
    return database!;
  }

  static Future<Database?> getDBConnect() async {
    if (database != null) {
      return database;
    }
    return await initDatabase();
  }

  static Future<Database?> initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'ChatHistory${GlobalData.userMemberId}.db'),
      version: 1,
      onCreate: (db, version) {
        return _createDb(db);
      },
    );
    return database;
  }

  static void _createDb(Database db) async {
    Batch batch = db.batch();
    batch.execute(
        "CREATE TABLE ChatHistory("
        "contentId TEXT PRIMARY KEY, roomId TEXT, receiverAvatarId TEXT, msgType TEXT,"
        "content TEXT, timestamp TEXT, action TEXT)"
            // "contentId TEXT PRIMARY KEY, roomId TEXT, nickName TEXT, uid TEXT, memberAvatar TEXT, "
            // "memberId TEXT, action TEXT, type TEXT, msgType TEXT, content TEXT, hasRead TEXT, "
            // "recall TEXT, replyByContentId TEXT, time TEXT, callStatus TEXT, callDuration TEXT, "
            // "replyByMsg TEXT, replyById TEXT, replyByNickName TEXT, replyByUid TEXT, replyByAvatar TEXT, "
            // "otherSideMemberId TEXT, afterValue TEXT, beforeValue TEXT, id TEXT, operator TEXT, "
            // "operatorAvatar TEXT, operatorUid TEXT)"
    );
    // batch.execute(
    //     "CREATE TABLE EmojiHistory("
    //         "roomId TEXT, contentId TEXT, memberId TEXT, memberAvatar TEXT, memberUid TEXT, "
    //         "emoji TEXT, createTime TEXT)"
    // );
    // batch.execute(
    //     "CREATE TABLE ChatMemberInfo("
    //         "memberId TEXT PRIMARY KEY, uid TEXT, oldUid TEXT, "
    //         "nickName TEXT, oldNickName TEXT, "
    //         "memberAvatar TEXT, time TEXT)"
    // );
    // batch.execute(
    //     "CREATE TABLE ChatGroupMember("
    //         "roomId TEXT, memberId TEXT, uid TEXT, nickName TEXT, memberAvatar TEXT, readTimeStatus TEXT, "
    //         "readTime TEXT, blockStatus TEXT, friendStatus TEXT, permissionStatus TEXT)"
    // );
    // batch.execute(
    //     "CREATE TABLE ChatGroupRead("
    //         "contentId TEXT, memberId TEXT)"
    // );
    // batch.execute(
    //     "CREATE TABLE ChatroomUpdateRecord("
    //         "id TEXT PRIMARY KEY, roomId TEXT, action TEXT, beforeValue TEXT, afterValue TEXT, "
    //         "createTime TEXT, memberAvatar TEXT, memberId TEXT, memberUid TEXT, "
    //         "operator TEXT, operatorAvatar TEXT, operatorUid TEXT)"
    // );
    await batch.commit();
  }

  static Future<void> addHistory(ChatHistorySQLite chatHistorySQLite) async {
    final Database? db = await getDBConnect();
    await db?.insert(
      'ChatHistory',
      chatHistorySQLite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ChatHistorySQLite>> getHistory(int sRoomId) async {
    final Database? db = await getDBConnect();
    // final List<Map<String, dynamic>>? maps = await db?.query(
    //   'ChatHistory',
    //   where: 'roomId LIKE ?',
    //   whereArgs: ['%$sRoomId%'],
    // );

    final List<Map<String, dynamic>>? maps = await db?.rawQuery(
      'SELECT * From ChatHistory WHERE roomId = "$sRoomId"'
      // 'SELECT A.*,B.uid AS uid, B.memberAvatar AS memberAvatar, '
      // 'IFNULL(C.uid,"") AS replyByUid, IFNULL(C.memberAvatar,"") AS replyByAvatar '
      // 'FROM ChatHistory A LEFT JOIN ChatMemberInfo B ON A.memberId = B.memberId '
      // 'LEFT JOIN ChatMemberInfo C ON A.replyById = C.memberId WHERE A.roomId LIKE "$sRoomId"'
    );

    return List.generate(maps!.length, (i) {
      return ChatHistorySQLite(
        // topic: maps[i]['topic'],
        action: maps[i]['action'],
        roomId: maps[i]['roomId'],
        receiverAvatarId: maps[i]['receiverAvatarId'],
        msgType: maps[i]['msgType'],
        content: maps[i]['content'],
        contentId: maps[i]['contentId'],
        timestamp: maps[i]['timestamp'],

        // roomId: maps[i]['roomId'],
        // uid: maps[i]['uid']??'',
        // memberId: maps[i]['memberId'],
        // memberAvatar: maps[i]['memberAvatar']??'',
        // action: maps[i]['action'],
        // type: maps[i]['type'],
        // msgType: maps[i]['msgType'],
        // content: maps[i]['content'],
        // contentId: maps[i]['contentId'],
        // hasRead: maps[i]['hasRead'],
        // recall: maps[i]['recall'],
        // time: maps[i]['time'],
        // replyByMsg: maps[i]['replyByMsg'],
        // replyById: maps[i]['replyById'],
        // replyByUid: maps[i]['replyByUid']??'',
        // replyByNickName: maps[i]['replyByNickName']??'',
        // replyByAvatar: maps[i]['replyByAvatar']??'',
        // replyByContentId: maps[i]['replyByContentId'],
        // otherSideMemberId: maps[i]['otherSideMemberId'],
        // afterValue: maps[i]['afterValue']??'',
        // beforeValue: maps[i]['beforeValue']??'',
        // id: maps[i]['id']??'',
        // operator: maps[i]['operator']??'',
        // operatorAvatar: maps[i]['operatorAvatar']??'',
        // operatorUid: maps[i]['operatorUid']??'',
        // callStatus: maps[i]['callStatus']??'',
        // callDuration: maps[i]['callDuration']??'',
        // emojiDataList: []
      );
    });
  }
}