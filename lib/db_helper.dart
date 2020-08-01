import 'package:sqflite/sqflite.dart'
    as sql; //medium between dart and data base stored on phone
import 'package:path/path.dart' as path;

class DBHelper {
  // static sql.Database _db;

  static const String DB_NAME = 'words_app.db';

  // static Future<sql.Database> database() async {
  //   //first we create a data base if we don't have one
  //   final dbPath = await sql.getDatabasesPath();
  //   //it will open existing data base or otherwise will create data base with specified name
  //   return sql.openDatabase(path.join(dbPath, DB_NAME),
  //       onCreate: (db, version) {
  //     return db.execute(
  //         'CREATE TABLE collections(id TEXT PRIMARY KEY, title TEXT, language TEXT)');
  //   }, version: 1);
  // }

  static Future<sql.Database> database() async {
    //first we create a data base if we don't have one
    final dbPath = await sql.getDatabasesPath();
    //it will open existing data base or otherwise will create data base with specified name
    return await sql.openDatabase(path.join(dbPath, DB_NAME),
        version: 1, onCreate: _onCreate);
  }

  static _onCreate(sql.Database db, int version) async {
    await db.execute(
        'CREATE TABLE collections(id TEXT PRIMARY KEY, title TEXT, language TEXT)');
    await db.execute(
        'CREATE TABLE words(collectionId Text, id TEXT PRIMARY KEY, word1 TEXT, word2 TEXT, translation TEXT, part TEXT, image TEXT)');
  }

  //method's will all be static So we don't need to create an instance of it, to work with it

  static Future<void> insert(String table, Map<String, Object> data) async {
    //if table is created it's created with specified table structure
    //where's ID is a Primary key,

    // sql.ConflictAlgorithm.replace if the entry already exists, it will override it
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String table, Map<String, Object> data) async {
    //if table is created it's created with specified table structure
    //where's ID is a Primary key,

    // sql.ConflictAlgorithm.replace if the entry already exists, it will override it
    final db = await DBHelper.database();
    db.update(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }


  //TODO: create ui delete collection method
  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table,
      {String collectionId}) async {
    final db = await DBHelper.database();
    return collectionId == null
        ? db.query(table)
        : db.query(table, where: 'collectionId = ?', whereArgs: [collectionId]);
  }
}
