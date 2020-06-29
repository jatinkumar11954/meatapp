import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqlitePersistence {
  static const DatabaseName = 'cart.db';
  static const TableName = 'cart';
  Database db;

  SqlitePersistence._(this.db);

  static Future<SqlitePersistence> create() async =>
      SqlitePersistence._(await database());

  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), DatabaseName),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE $TableName(
            id INTEGER PRIMARY KEY, 
            imdbId INTEGER, 
            name STRING, 
            imageUrl STRING, 
            year STRING, 
            watchedOn INTEGER
          )''',
        );
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getUniqueObjects() async {
    final ret = await db.rawQuery(
        'SELECT *, COUNT(*) as watchedTimes FROM $TableName group by imdbId');
    return ret;
  }

  Future<List<Map<String, dynamic>>> findObjects(String query) async {
    final ret = await db.rawQuery(
        'SELECT *, COUNT(*) as watchedTimes FROM $TableName where name like ? group by imdbId',
        ['%$query%']);

    return ret;
  }

  void createUpdate(int key, Map<String, dynamic> object) async {
    await db.insert(TableName, object,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeObject(int key) async {
    await db.delete(
      TableName,
      where: 'id = ?',
      whereArgs: [key],
    );
  }
}
