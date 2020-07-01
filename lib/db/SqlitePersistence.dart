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
    print("database is opende");
    //   return openDatabase(
    //   join(await getDatabasesPath(), DatabaseName),
    //   onCreate: (db, version) {
    //     return db.execute(
    //       '''CREATE TABLE $MoviesWatchedTableName(
    //         id INTEGER PRIMARY KEY,
    //         imdbId INTEGER,
    //         name STRING,
    //         imageUrl STRING,
    //         year STRING,
    //         watchedOn INTEGER
    //       )''',
    //     );
    //   },
    //   version: 1,
    // );
    return openDatabase(
      join(await getDatabasesPath(), DatabaseName),
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE $TableName(
               id INTEGER PRIMARY KEY, 
                title STRING, 
                img STRING, 
                catName STRING,
                column INTEGER,
                 quantity INTEGER,
                  price INTEGER, 
                  weight INTEGER
            )''');
      },
      version: 1,
    );
  }

  // Future<List<Map<String, dynamic>>> getUniqueObjects() async {
  //   final ret = await db.rawQuery(
  //       'SELECT * FROM $TableName ');
  //   return ret;
  // }

  Future<List<Map<String, dynamic>>> getCartfromDB() async {
    print("calling getcart inside db");
    final ret = await db.rawQuery('SELECT * FROM $TableName ');

    return ret;
  }

  void createUpdate(Map<String, dynamic> object) async {
    print("inside create update" + object["title"]);
    await db.insert(TableName, object,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deletefrmTable(int cartId) async {
    await db.rawDelete("DELETE FROM $TableName WHERE id==$cartId");
  }

  void updateTable(int cartQuantity, int cartId) async {
    print("updating the table inside sql");
    await db.rawUpdate('''UPDATE $TableName
SET quantity = $cartQuantity
WHERE id==$cartId''');
  }

  Future<void> clearTable() async {
    await db.delete(TableName);
  }

  Future<void> removeObject(int key) async {
    await db.delete(
      TableName,
      where: 'id = ?',
      whereArgs: [key],
    );
  }
}
