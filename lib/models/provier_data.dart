import 'package:flutter/material.dart';
import 'package:words_app/models/box_collection_data.dart';
import 'package:words_app/models/words_data.dart';
import 'dart:collection';

class ProviderData extends ChangeNotifier {
  //listCollections
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

  void handleSubmitTextCollections(dynamic value, CollectionData collection) {
    collection.changeCollectionName(value);
    collection.toggleCheckTextEdit();
    notifyListeners();
  }

  // ManagerCollection
  List<WordsData> wordsData = [
    WordsData(mainWordTitle: 'Words1'),
    WordsData(mainWordTitle: 'Words2'),
    WordsData(mainWordTitle: 'Words3')
  ];

  void editWordMainText(WordsData words) {
    words.toggleWordsCheckTextEdit();

    notifyListeners();
  }

  void handleSubmitTextWords(dynamic value, WordsData words) {
    words.changeWordsTitleName(value);
    words.toggleWordsCheckTextEdit();
    notifyListeners();
  }
}
