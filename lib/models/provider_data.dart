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
    WordsData(
        mainWordTitle: 'Words1',
        secondWordTitle: '1Second Word',
        translationTitle: '1Translation'),
    WordsData(
        mainWordTitle: 'Words2',
        secondWordTitle: '2Second Word',
        translationTitle: '1Translation'),
    WordsData(
        mainWordTitle: 'Words3',
        secondWordTitle: '3Second Word',
        translationTitle: '1Translation')
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
