import 'package:sqflite/sqflite.dart';

import '../chat_history_database.dart';

abstract class BaseTable {
  ChatHistoryDataBase get instance => ChatHistoryDataBase.instance;

  Future createTable(Database db, int version);

  List<String> values();
}
