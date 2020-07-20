import 'package:flutter/material.dart';
import 'package:words_app/providers/word_data.dart';

class Words with ChangeNotifier {
  List<Word> wordsData = [
    Word(
      id: 1,
      word1: 'Summer',
      word2: '夏天',
      translation: 'Лето',
      image: null,
    ),
    Word(
      id: 2,
      word1: 'Winter',
      word2: '冬天',
      translation: 'Зима',
      image: null,
    ),
    Word(
      id: 3,
      word1: 'Spring',
      word2: '春天',
      translation: 'Весна',
      image: null,
    ),
  ];

  // List<Word> get wordsData {
  //   return [..._wordsData];
  // }

  //CardCreater
  void addNewWordCard(
      String main, String second, String translation, int newId, String image) {
    final wordCard = Word(
        word1: main,
        word2: second,
        translation: translation,
        id: newId,
        image: image);

    wordsData.add(wordCard);
    notifyListeners();
  }

  void toggleWord1(Word words) {
    words.toggleWord1();

    notifyListeners();
  }

  void handleSubmitWord1(dynamic value, Word words) {
    words.changeWord1Title(value);
    // words.toggleWord1();
    notifyListeners();
  }

  void toggleWord2(Word words) {
    words.toggleWord2();
    notifyListeners();
  }

  void handleSubmitWord2(dynamic value, Word words) {
    words.changeWord2Title(value);
    // words.toggleWord2();
    notifyListeners();
  }

  void toggleTranslation(Word words) {
    words.toggleTranslation();
    notifyListeners();
  }

  void handleSubmitTranslation(dynamic value, Word words) {
    words.changeTranslationTitle(value);
    // words.toggleTranslation();
    notifyListeners();
  }

  void toggleShowImgInWordsProvider(Word words) {
    words.toggleShowImg();
    notifyListeners();
  }
}
