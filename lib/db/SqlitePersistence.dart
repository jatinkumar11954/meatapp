import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqlitePersistence {
  static const DatabaseName = 'cart.db';
  static const TableName = 'cart';
  static const FavTable = 'fav';

  Database db;

  SqlitePersistence._(this.db);

  static Future<SqlitePersistence> create() async =>
      SqlitePersistence._(await database());
  static void creat(Database db) {
    db.execute('''CREATE TABLE $FavTable( id INTEGER PRIMARY KEY,   col INTEGER,   row INTEGER)''');
    db.execute('''CREATE TABLE $TableName(
               id INTEGER PRIMARY KEY, 
                title STRING, 
                img STRING, 
                catName STRING,
                column INTEGER,
                 quantity INTEGER,
                  price INTEGER, 
                  weight INTEGER  )''');
  }

  static Future<Database> database() async {
    print("database is opende");

    return openDatabase(
      join(await getDatabasesPath(), DatabaseName),
      onCreate: (db, version) => creat(db),
      version: 1,
    );
  }

  
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

 

  Future<void> clearTable() async {
    await db.delete(TableName);
        await db.delete(FavTable);

     await db.close();
  }

 
  Future<List<Map<String, dynamic>>> getFavfromDb() async {
    print("calling getfav inside db");
    final ret = await db.rawQuery('SELECT * FROM $FavTable ');

    return ret;
  }

  void createFav(Map<String, int> object) async {
    await db.insert(FavTable, object,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deletefromFav(int productId) async {
    await db.rawDelete("DELETE FROM $FavTable WHERE id==$productId");
  }
}
