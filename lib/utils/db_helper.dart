import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart'
    as sql; //medium between dart and data base stored on phone
import 'package:path/path.dart' as path;
import 'package:sqflite/utils/utils.dart';
import 'package:words_app/config/paths.dart';

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

  /// Method execute creation of two tables by using helper function _onCreate
  static Future<sql.Database> database() async {
    //first we create a data base if we don't have one
    final dbPath = await sql.getDatabasesPath();
    //it will open existing data base or otherwise will create data base with specified name
    return await sql.openDatabase(path.join(dbPath, DB_NAME),
        version: 1, onCreate: _onCreate);
  }

  /// Method  creates specified tables to DB,
  static _onCreate(sql.Database db, int version) async {
    await db.execute(
        'CREATE TABLE collections(id TEXT PRIMARY KEY, title TEXT, language TEXT, wordCount INTEGER DEFAULT 0)');
    await db.execute(
        'CREATE TABLE words(collectionId Text, id TEXT PRIMARY KEY, targetLang TEXT, ownLang TEXT, secondLang TEXT, thirdLang TEXT, partName TEXT, partColor TEXT, image TEXT, example TEXT, exampleTranslations TEXT, difficulty INTEGER)');
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

  static Future<int> fetchWordCount(String id) async {
    final db = await DBHelper.database();
    var wordCount = firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM words WHERE collectionId='$id'"));
    return wordCount;
  }

  static Future<void> populateList(
      String table, Map<String, Object> data) async {
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

  //update item in db
  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> incrementCounter(String id) async {
    final db = await DBHelper.database();
    await db.rawQuery(
        "UPDATE collections SET wordCount = wordCount + 1 WHERE id='$id'");
  }

  static Future<void> dicrementtCounter(String id) async {
    final db = await DBHelper.database();
    await db.rawQuery(
        "UPDATE collections SET wordCount = wordCount - 1 WHERE id='$id'");
  }

  /// Delete collection method
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
