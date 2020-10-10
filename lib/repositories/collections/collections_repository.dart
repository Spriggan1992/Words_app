import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:words_app/config/paths.dart';
import 'package:words_app/entities/collection_entity.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/utils/db_helper.dart';
import '../../models/collection.dart';
import '../words/words_repository.dart';

class CollectionsRepository {
  WordsRepository wordsRepository;
  List<Collection> _collections = [];

  /// This method is responsible for adding new  [Collection] to DB,
  ///
  /// DBHelper.insert is responsible for inserting [Collection] to DB,
  Future<Collection> addNewCollection({Collection collection}) async {
    DBHelper.insert(
      Paths.collections,
      collection.toEntity().toDb(),
    );

    return collection;
  }

  /// This method is responsible for fetching all Collections from DB and returning it to collections_bloc
  Future<List<Collection>> fetchAndSetCollection() async {
    final dataList = await DBHelper.getData('collections');
    _collections = dataList
        .map(
          (data) => Collection.fromEntity(CollectionEntity.fromDb(data)),
        )
        .toList();
    return _collections;
  }

  /// This method returns quantity of words in collection by ID
  Future<int> getWordCount(String id) async {
    return await DBHelper.fetchWordCount(id);
  }

  /// This method is responsible for deleting [<Collection>] by id from DB
  void deleteCollection(String collectionId) async {
    // Here we receive all Word items by collectionId
    final dataList =
        await DBHelper.getData('words', collectionId: collectionId);
    // Loop through them and deleting all files that are assosiated with collectionId collection
    dataList.forEach((item) async {
      // Simply deleting file using metod from dart.io
      try {
        await File(item['image']).delete();
      } on FileSystemException {}
    });
    DBHelper.delete('collections', collectionId);
  }

  ///update [Collection] by ID receiving <Map>[data]
  Future<void> updateCollection({Map<String, Object> data}) async {
    final db = await DBHelper.database();
    db.update(
      'collections',
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
