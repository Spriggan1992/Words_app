import 'package:flutter/material.dart';
import 'package:words_app/models/collections_data.dart';
import 'package:words_app/models/words_data.dart';
import 'dart:collection';
// import 'package:words_app/models/validation.dart';

class ProviderData extends ChangeNotifier {
  //listCollections
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

  // ManagerCollection
  List<WordsData> wordsData = [
    WordsData(
      id: 1,
      word1: 'Summer',
      word2: '夏天',
      translation: 'Лето',
      image: null,
    ),
    WordsData(
      id: 2,
      word1: 'Winter',
      word2: '冬天',
      translation: 'Зима',
      image: null,
    ),
    WordsData(
      id: 3,
      word1: 'Spring',
      word2: '春天',
      translation: 'Весна',
      image: null,
    ),
  ];

  bool ignoreActions = false;

  //CardCreater
  void addNewWordCard(
      String main, String second, String translation, int newId, String image) {
    final wordCard = WordsData(
        word1: main,
        word2: second,
        translation: translation,
        id: newId,
        image: image);

    wordsData.add(wordCard);
    notifyListeners();
  }

  // void chooseInProvider(WordsData words, int id) {
  //   words.choosePictureInProvider(id);
  //   notifyListeners();
  // }

  void toggleWord1(WordsData words) {
    words.toggleWord1();
    ignoreActions = !ignoreActions;
    print(ignoreActions);

    notifyListeners();
  }

  void handleSubmitWord1(dynamic value, WordsData words) {
    words.changeWord1Title(value);
    words.toggleWord1();
    notifyListeners();
  }

  void toggleWord2(WordsData words) {
    words.toggleWord2();
    notifyListeners();
  }

  void handleSubmitWord2(dynamic value, WordsData words) {
    words.changeWord2Title(value);
    words.toggleWord2();
    notifyListeners();
  }

  void toggleTranslation(WordsData words) {
    words.toggleTranslation();
    notifyListeners();
  }

  void handleSubmitTranslation(dynamic value, WordsData words) {
    words.changeTranslationTitle(value);
    words.toggleTranslation();
    notifyListeners();
  }

  void toggleShowImg(WordsData words) {
    words.toggleShowImg();
    notifyListeners();
  }

//   // Validation

// Validation word1 = Validation(value: null, error: null);

//   bool get isValid{
//     if(word1.value !=null)
//   }

}
