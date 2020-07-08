import 'package:flutter/material.dart';
import 'package:words_app/models/box_collection_data.dart';
import 'package:words_app/models/words_data.dart';
import 'dart:collection';

class ProviderData extends ChangeNotifier {
  //listCollections
  List<CollectionData> _boxCollectionData = [
    CollectionData(collectionNameTitle: "nouns"),
    CollectionData(collectionNameTitle: "verbs"),
    CollectionData(collectionNameTitle: "adjectives")
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

  void chooseBetweenFrontBackContainers(CollectionData collection) {
    collection.toggleCheckFrontBack();
    notifyListeners();
  }

  void editText(CollectionData collection) {
    collection.toggleCheckTextEditing();
    collection.toggleCheckFrontBack();
    notifyListeners();
  }

  void handleSubmitTextCollections(dynamic value, CollectionData collection) {
    collection.changeCollectionName(value);
    collection.toggleCheckTextEditing();
    notifyListeners();
  }

  // ManagerCollection
  List<WordsData> wordsData = [
    WordsData(
        mainWordTitle: 'Summer',
        secondWordTitle: '夏天',
        translationTitle: 'Лето'),
    WordsData(
        mainWordTitle: 'Winter',
        secondWordTitle: '冬天',
        translationTitle: 'Зима'),
    WordsData(
        mainWordTitle: 'Spring',
        secondWordTitle: '春天',
        translationTitle: 'Весна')
  ];

  void togglingMainWord(WordsData words) {
    words.toggleMainWords();
    notifyListeners();
  }

  void handleSubmitMainWords(value, WordsData words) {
    words.changeMainWordTitle(value);
    words.toggleMainWords();
    notifyListeners();
  }

  void togglingSecondWord(WordsData words) {
    words.toggleSecondWords();
    notifyListeners();
  }

  void handleSubmitSecondWords(dynamic value, WordsData words) {
    words.changeSecondWordTitle(value);
    words.toggleSecondWords();
    notifyListeners();
  }

  void togglingTranslation(WordsData words) {
    words.toggleTranslations();
    notifyListeners();
  }

  void handleSubmitTranslation(dynamic value, WordsData words) {
    words.changeTranslationTitle(value);
    words.toggleTranslations();
    notifyListeners();
  }
}

// void submitText(dynamic value, WordsData words, bool id) {

//     words.changeSecondWordTitle(value);
//     words.toggleMainWords(id);
//     print(id);
//     notifyListeners();
//   }
