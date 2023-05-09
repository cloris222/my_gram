import 'package:sqflite/sqflite.dart';

import '../data/demo_data.dart';
import 'base_table.dart';

/// 範例用
class DemoTable extends BaseTable {
  static const String tableName = 'demo';
  static const String id = 'id';

  @override
  List<String> values() {
    return [id];
  }

  @override
  Future createTable(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableName ( 
 $id INTEGER PRIMARY KEY AUTOINCREMENT
  )
''');
  }

  Future<DemoData> insert(DemoData data) async {
    final db = await instance.database;
    final id=await db.insert(tableName, data.toJson());
    return data.copy(id:id);
  }

  Future<DemoData> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: values(),
      where: '$id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DemoData.fromJson(maps.first);
    } else {
      throw Exception('contentId $id not found');
    }
  }

  Future<List<DemoData>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '$id ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableName, orderBy: orderBy);

    return result.map((json) => DemoData.fromJson(json)).toList();
  }

  Future<int> update(DemoData data) async {
    final db = await instance.database;

    return db.update(
      tableName,
      data.toJson(),
      where: '$id = ?',
      whereArgs: [data.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableName,
      where: '$id = ?',
      whereArgs: [id],
    );
  }
}
