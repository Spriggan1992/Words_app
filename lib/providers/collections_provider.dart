import 'dart:collection';
import 'package:flutter/material.dart';
import '../providers/collection_data.dart';

class Collections with ChangeNotifier {
  List<Collection> _wordsCollectionData = [
    Collection(title: "nouns"),
    Collection(title: "verbs"),
    Collection(title: "adjectives")
  ];

  UnmodifiableListView<Collection> get wordsCollectionData {
    return UnmodifiableListView(_wordsCollectionData);
  }

  void addNewCollection(String newCollection) {
    final collection = Collection(title: newCollection);
    _wordsCollectionData.add(collection);
    notifyListeners();
  }

  void deleteCollection(Collection collection) {
    _wordsCollectionData.remove(collection);
    notifyListeners();
  }

  void switchFrontBack(Collection collection) {
    collection.toggleCheckFrontBack();
    notifyListeners();
  }

  void editText(Collection collection) {
    collection.toggleCheckTextEditing();
    collection.toggleCheckFrontBack();
    notifyListeners();
  }

  void handleSubmitEditTitle(dynamic value, Collection collection) {
    collection.changeCollectionName(value);
    collection.toggleCheckTextEditing();
    notifyListeners();
  }
}
