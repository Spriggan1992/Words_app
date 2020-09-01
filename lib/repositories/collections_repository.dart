import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:words_app/utils/db_helper.dart';
import '../models/collection.dart';

class CollectionsRepository {
  List<Collection> _collections = [
    Collection(title: "nouns", language: 'eng'),
  ];
  //  using spread operator to return copy of our list, to prevent access to original list
  List<Collection> get wordsCollectionData {
    return [..._collections];
  }

  Future<Collection> addNewCollection(
      {String collectionTitle,
      String languageTitle,
      String collectionId}) async {
    final collection = Collection(
      // Creating object here for later adding it to _wordsCollectionData
      //create Id for collection
      id: collectionId,
      title: collectionTitle,
      language: languageTitle,
      showBtns: false,
      isEditingBtns: false,
    );

    //insert into collections table that we created in DBHelper
    DBHelper.insert(
      'collections',
      {
        'id': collection.id,
        'title': collection.title,
        'language': collection.language,
      },
    );
    return collection;
  }

  ///Fetching data from db  and setting the _collections
  Future<List<Collection>> fetchAndSetCollection() async {
    final dataList = await DBHelper.getData('collections');
    _collections = dataList
        .map(
          (item) => Collection(
              id: item['id'],
              title: item['title'],
              language: item['language'],
              isEditingBtns: false,
              showBtns: false),
        )
        .toList();
    return _collections;
  }

  void deleteCollection(String id) {
    DBHelper.delete('collections', id);
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

  // void runAnimation(AnimationController controller) {
  //   toggleIsEditingBtns();
  //   if (isEditingBtns) {
  //     controller.repeat(reverse: true);
  //   } else {
  //     controller.reset();
  //   }
  // }
}
