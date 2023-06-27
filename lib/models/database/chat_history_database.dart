import 'dart:async';

import 'package:base_project/models/database/table/chat/chat_history_table.dart';
import 'package:base_project/models/database/table/chat/chat_member_table.dart';
import 'package:base_project/models/database/table/chat/chat_room_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../constant/theme/global_data.dart';

/*
* 對應資料表
* https://docs.google.com/spreadsheets/d/1Cfj8wFrtOEu6S-gnZiiFceWA2CE2Eo_LqP3kNUr0M4k/edit?usp=sharing
* */
class ChatHistoryDataBase {
  static final ChatHistoryDataBase instance = ChatHistoryDataBase._init();

  static Database? _database;

  ChatHistoryDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('ChatHistory2${GlobalData.userMemberId}.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 1, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  /// 建立資料庫
  Future _createDB(Database db, int version) async {
    // version: 1
    ChatHistoryTable().createTable(db, version);
    ChatMemberTable().createTable(db, version);
    ChatRoomTable().createTable(db, version);
  }

  /// 資料庫舊版升級新版用
  FutureOr<void> _upgradeDB(Database db, int oldVersion, int newVersion) {}

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
