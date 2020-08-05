import 'dart:io';

import 'package:flutter/material.dart';
import 'package:words_app/db_helper.dart';
import 'package:words_app/providers/part_data.dart';
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

  //Card Creator

  void addNewWordCard(
      String collectionId,
      String main,
      String second,
      String translation,
      String newId,
      File image,
      Part part,
      String example,
      String exampleTranslations) {
    final wordCard = Word(
      id: newId,
      targetLang: main,
      secondLang: second,
      ownLang: translation,
      image: image,
      example: example,
      exampleTranslations: exampleTranslations,
      part: part,
    );
    _wordsData.add(wordCard);
    notifyListeners();
    DBHelper.insert('words', {
      'collectionId': collectionId,
      'id': newId,
      'word1': main,
      'word2': second,
      'translation': translation,
      'part': part.part,
      'partColor': part.color.value.toString(),
      'image': image.path,
      'example': example,
      'exampleTranslations': exampleTranslations,
    });
  }

  Future<void> fetchAndSetWords(String collectionId) async {
    final dataList =
        await DBHelper.getData('words', collectionId: collectionId);
//    print('DEBUG fetchAndSetWords ${dataList}');
    _wordsData = dataList
        .map(
          (item) => Word(
            id: item['id'],
            targetLang: item['word1'],
            secondLang: item['word2'],
            ownLang: item['translation'],
            part: Part(item['part'], Color(item['partColor'])),
            example: item['example'],
            exampleTranslations: item['exampleTranslations'],
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }

  void removeWord(value) {
    _wordsData.remove(value);
    notifyListeners();
    DBHelper.delete('words', value.id);
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
