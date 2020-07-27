import 'package:sqflite/sqflite.dart'
    as sql; //medium between dart and data base stored on phone
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    //first we create a data base if we don't have one
    final dbPath = await sql.getDatabasesPath();
    //it will open existing data base or otherwise will create data base with specified name
    return sql.openDatabase(path.join(dbPath, 'words_app.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE words(id TEXT PRIMARY KEY, word1 TEXT, word2 TEXT, translation TEXT, part TEXT, image TEXT)');
    }, version: 1);
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

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
