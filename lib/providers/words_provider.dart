import 'dart:io';

import 'package:flutter/material.dart';
import 'package:words_app/db_helper.dart';
import 'package:words_app/providers/word_data.dart';

class Words with ChangeNotifier {
  List<Word> _wordsData = [
//    Word(
//      id: '1',
//      word1: 'Summer',
//      word2: '夏天',
//      translation: 'Лето',
//      part: 'n',
//      image: 'images/1.jpeg',
//    ),
//    Word(
//      id: '2',
//      word1: 'go',
//      word2: '走',
//      translation: 'идти',
//      part: 'v',
//      image: 'images/2.jpeg',
//    ),
//    Word(
//      id: '3',
//      word1: 'beautiful',
//      word2: '漂亮',
//      translation: 'красивый',
//      part: 'adj',
//      image: 'images/3.jpeg',
//    ),
  ];

  List<Word> get wordsData {
    return [..._wordsData];
  }

  Word findById(id) {
    return _wordsData.firstWhere((wordId) => wordId.id == id);
  }

  //CardCreater
  void addNewWordCard(String main, String second, String translation,
      String newId, File image, String part) {
    final wordCard = Word(
      id: newId,
      word1: main,
      word2: second,
      translation: translation,
      image: image.path,
      part: part,
    );
    _wordsData.add(wordCard);
    notifyListeners();
    DBHelper.insert('words_app', {
      'id': newId,
      'word1': main,
      'word2': second,
      'translation': translation,
      'part': part,
      'image': image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('words_app');
    _wordsData = dataList
        .map((item) => Word(
              id: item['id'],
              word1: item['id'],
              word2: item['id'],
              translation: item['id'],
              part: item['part'],
              image: item['image'],
            ))
        .toList();
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
