import 'package:flutter/material.dart';
import 'package:words_app/models/collections_data.dart';
import 'package:words_app/models/validation.dart';
import 'package:words_app/models/words_data.dart';
import 'dart:collection';
// import 'package:words_app/models/validation.dart';

class ProviderData extends ChangeNotifier {
  bool ignore = false;

  void ignorePointer() {
    ignore = !ignore;
    notifyListeners();
  }

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

  // bool ignoreActions = false;

  // void toggle(){
  //   ignoreActions = !ignoreActions;
  // }

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

    notifyListeners();
  }

  // void toogle (WordsData words){
  //   if()
  // }

  void handleSubmitWord1(dynamic value, WordsData words) {
    words.changeWord1Title(value);
    // words.toggleWord1();
    notifyListeners();
  }

  void toggleWord2(WordsData words) {
    words.toggleWord2();
    notifyListeners();
  }

  void handleSubmitWord2(dynamic value, WordsData words) {
    words.changeWord2Title(value);
    // words.toggleWord2();
    notifyListeners();
  }

  void toggleTranslation(WordsData words) {
    words.toggleTranslation();
    notifyListeners();
  }

  void handleSubmitTranslation(dynamic value, WordsData words) {
    words.changeTranslationTitle(value);
    // words.toggleTranslation();
    notifyListeners();
  }

  void toggleShowImg(WordsData words) {
    words.toggleShowImg();
    notifyListeners();
  }

  Validation _word1 = Validation(null, null);
  Validation _word2 = Validation(null, null);
  Validation _translation = Validation(null, null);

  //Getters
  Validation get word1 => _word1;
  Validation get word2 => _word2;
  Validation get translation => _translation;

  bool get isValid {
    if (word1.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void changeWord1(String value) {
    if (value.isNotEmpty) {
      _word1 = Validation(value, null);
    } else {
      _word1 = Validation(null, 'required field');
    }
    notifyListeners();
  }

  void submitData() {
    print(word1.value);
    notifyListeners();
  }
}
