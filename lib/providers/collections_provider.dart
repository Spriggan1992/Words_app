import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:words_app/utils/db_helper.dart';
import '../providers/collection_data.dart';

class Collections with ChangeNotifier {
  List<Collection> _wordsCollectionData = [
    Collection(title: "nouns", language: 'eng'),
  ];
  //  using spread operator to return copy of our list, to prevent access to original list
  List<Collection> get wordsCollectionData {
    return [..._wordsCollectionData];
  }

  void addNewCollection(String collectionTitle, String languageTitle) {
    final collection = Collection(
      // Creating object here for later adding it to _wordsCollectionData
      id: Uuid().v4(), //create Id for collection
      title: collectionTitle,
      language: languageTitle,
      showBtns: false,
    );
    _wordsCollectionData.add(collection);
    notifyListeners();
    //insert into collections table that we created in DBHelper
    DBHelper.insert(
      'collections',
      {
        'id': collection.id,
        'title': collection.title,
        'language': collection.language,
      },
    );
  }

  ///Fetching data from db  and setting the _wordsCollectionData
  Future<void> fetchAndSetCollection() async {
    final dataList = await DBHelper.getData('collections');
    _wordsCollectionData = dataList
        .map(
          (item) => Collection(
            id: item['id'],
            title: item['title'],
            language: item['language'],
          ),
        )
        .toList();
    notifyListeners();
  }

  void deleteCollection(Collection collection) {
    _wordsCollectionData.remove(collection);
    notifyListeners();
    DBHelper.delete('collections', collection.id);
  }

// we utilize DBHelper method insert,  which can also modify data if it finds this entry in db
  //TODO: think of making two methods below  into one method with
  void handleSubmitEditTitle(dynamic value, Collection collection) {
    collection.changeCollectionTitle(value);

    notifyListeners();
    DBHelper.update(
      'collections',
      {
        'id': collection.id,
        'title': collection.title,
        'language': collection.language,
      },
    );
  }

  void handleSubmitEditLanguageTitle(dynamic value, Collection collection) {
    collection.changeLanguageTitle(value);
    notifyListeners();

    // we utilize DBHelper method insert,  which can also modify data if it finds this entry in db
    DBHelper.update(
      'collections',
      {
        'id': collection.id,
        'title': collection.title,
        'language': collection.language,
      },
    );
  }

  /// toggle [showBtns] in path: [providers\collection_data.dart]
  void toggleBtns() {
    for (int i = 0; i < wordsCollectionData.length; i++) {
      wordsCollectionData[i].toggleShowBtns();

      notifyListeners();
    }
  }

  bool isEditingBtns = false;
  void toggleIsEditingBtns() {
    isEditingBtns = !isEditingBtns;
    notifyListeners();
  }

  void checkIsEditingBtns(AnimationController controller) {
    if (isEditingBtns == true) {
      isEditingBtns = false;
      controller.reset();
    }
    notifyListeners();
  }

  void runAnimation(AnimationController controller) {
    toggleIsEditingBtns();
    if (isEditingBtns) {
      controller.repeat(reverse: true);
    } else {
      controller.reset();
    }
  }
}
