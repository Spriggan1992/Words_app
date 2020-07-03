import 'package:flutter/material.dart';
import 'package:words_app/models/box_collection_data.dart';
import 'dart:collection';

class ProviderData extends ChangeNotifier {
  List<CollectionData> _boxCollectionData = [
    CollectionData(collectionNameTitle: "Hellow World"),
    CollectionData(collectionNameTitle: "DDDD"),
    CollectionData(collectionNameTitle: "dfsfsd")
  ];

  UnmodifiableListView<CollectionData> get boxCollectionData {
    return UnmodifiableListView(_boxCollectionData);
  }

  void addNewCollection(String newCollection) {
    final collection = CollectionData(collectionNameTitle: newCollection);
    _boxCollectionData.add(collection);
    notifyListeners();
  }

  void deleteCollection(CollectionData collection) {
    _boxCollectionData.remove(collection);
    notifyListeners();
  }

  void chooseOptions(CollectionData collection) {
    collection.toggleCheckMenu();
    notifyListeners();
  }

  void editText(CollectionData collection) {
    collection.toggleCheckTextEdit();
    collection.toggleCheckMenu();
    notifyListeners();
  }

  void handleSubmitText(dynamic value, CollectionData collection) {
    collection.changeCollectionName(value);
    collection.toggleCheckTextEdit();
    notifyListeners();
  }
}
