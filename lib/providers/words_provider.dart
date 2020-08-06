import 'dart:io';

import 'package:flutter/material.dart';
import 'package:words_app/db_helper.dart';
import 'package:words_app/providers/part_data.dart';
import 'package:words_app/providers/word_data.dart';
import 'package:words_app/utils/utilities.dart';

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
    String id,
    String targetLang,
    String ownLang,
    String secondLang,
    String thirdLang,
    File image,
    Part part,
    String example,
    String exampleTranslations,
  ) {
    final wordCard = Word(
      id: id,
      targetLang: targetLang,
      ownLang: ownLang,
      secondLang: secondLang,
      thirdLang: thirdLang,
      image: image,
      example: example,
      exampleTranslations: exampleTranslations,
      part: part,
    );
    _wordsData.add(wordCard);
    notifyListeners();
    DBHelper.insert('words', {
      'collectionId': collectionId,
      'id': id,
      'targetLang': targetLang,
      'ownLang': ownLang,
      'secondLang': secondLang,
      'thirdLang': thirdLang,
      'partName': part.partName,
      'partColor': part.partColor.toString(),
      'image': image.path,
      'example': example,
      'exampleTranslations': exampleTranslations,
    });
  }

  Future<void> fetchAndSetWords(String collectionId) async {
    final dataList =
        await DBHelper.getData('words', collectionId: collectionId);
//    print('DEBUG fetchAndSetWords ${dataList}');
    _wordsData = dataList.map((item) {
//      print(item['partColor']);
      Word word = Word(
        id: item['id'],
        targetLang: item['targetLang'],
        ownLang: item['ownLang'],
        secondLang: item['secondLang'],
        thirdLang: item['thirdLang'],
        part: (Part(item['partName'], Utilities.getColor(item['partColor']))),
        image: File(item['image']),
        example: item['example'],
        exampleTranslations: item['exampleTranslations'],
      );

//      print('DEBUG: ${word.image.path}');
      return word;
    }).toList();

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
