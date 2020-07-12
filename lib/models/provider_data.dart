import 'package:flutter/material.dart';
import 'package:words_app/models/collections_data.dart';
import 'package:words_app/models/words_data.dart';
import 'dart:collection';

class ProviderData extends ChangeNotifier {
  //listCollections
  List<Collection> _wordsCollectionData = [
    Collection(title: "nouns"),
    Collection(title: "verbs"),
    Collection(title: "adjectives")
  ];

  UnmodifiableListView<Collection> get boxCollectionData {
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

  void togglingMainWord(WordsData words) {
    words.toggleMainWords();
    notifyListeners();
  }

  void handleSubmitMainWords(dynamic value, WordsData words) {
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

  void togglingShowPicture(WordsData words) {
    words.toggleShowPicture();
    notifyListeners();
  }
}

// void submitText(dynamic value, WordsData words, bool id) {

//     words.changeSecondWordTitle(value);
//     words.toggleMainWords(id);
//     print(id);
//     notifyListeners();
//   }
