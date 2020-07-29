import 'dart:collection';
import 'package:flutter/material.dart';
import '../providers/collection_data.dart';

class Collections with ChangeNotifier {
  List<Collection> _wordsCollectionData = [
    Collection(title: "nouns", language: 'eng'),
//    Collection(title: "verbs", language: 'ru'),
//    Collection(title: "adjectives", language: 'eng'),
//    Collection(title: 'pron', language: 'cn'),
  ];

  UnmodifiableListView<Collection> get wordsCollectionData {
    return UnmodifiableListView(_wordsCollectionData);
  }

  void addNewCollection(String collectionTitle, String languageTitle) {
    final collection =
        Collection(title: collectionTitle, language: languageTitle);
    _wordsCollectionData.add(collection);

    notifyListeners();
  }

  void deleteCollection(Collection collection) {
    _wordsCollectionData.remove(collection);
    print(_wordsCollectionData);
    notifyListeners();
  }

  void handleSubmitEditTitle(dynamic value, Collection collection) {
    collection.changeCollectionTitle(value);
    notifyListeners();
  }

  void handleSubmitEditLangugeTitle(dynamic value, Collection collection) {
    collection.changeLanguageTitle(value);
    notifyListeners();
  }
}
