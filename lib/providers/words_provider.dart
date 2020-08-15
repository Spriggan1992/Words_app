import 'dart:io';

import 'package:flutter/material.dart';
import 'package:words_app/utils/DummyData.dart';
import 'package:words_app/utils/db_helper.dart';
import 'package:words_app/providers/part_data.dart';
import 'package:words_app/providers/word_data.dart';
import 'package:words_app/utils/utilities.dart';

class Words with ChangeNotifier {
  List<Word> _wordsData = [];

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

  // temporary method for pre-populating list
  Future<void> populateList(String collectionId) async {
    DummyData.words.forEach((item) async {
      File imagePath = await Utilities.assetToFile(
          'images/${item.targetLang}.jpg',
          imageName: item.targetLang);
      DBHelper.populateList('words', {
        'collectionId': collectionId,
        'id': item.id,
        'targetLang': item.targetLang,
        'ownLang': item.ownLang,
        'secondLang': item.secondLang,
        'thirdLang': item.thirdLang,
        'partName': item.part.partName,
        'partColor': item.part.partColor.toString(),
        'image': imagePath.path,
        'example': item.example,
        'exampleTranslations': item.exampleTranslations,
      });
    });
    notifyListeners();
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

  void targetLanghandleSubmit(dynamic value, Word words) {
    words.changeTargetLang(value);
    // words.toggleWord1();
    notifyListeners();
  }

  void secondLangHandleSubmit(dynamic value, Word words) {
    words.changeSecondLang(value);
    // words.toggleWord2();
    notifyListeners();
  }

  void thirdLangHandleSubmit(dynamic value, Word words) {
    words.changeThirdLang(value);
    // words.toggleWord2();
    notifyListeners();
  }

  void ownLangHandleSubmit(dynamic value, Word words) {
    words.changeOwnLang(value);
    // words.toggleTranslation();
    notifyListeners();
  }

  void toggleWord2(Word words) {
    words.toggleWord2();
    notifyListeners();
  }

  void toggleTranslation(Word words) {
    words.toggleTranslation();
    notifyListeners();
  }

  void toggleShowImgInWordsProvider(Word words) {
    words.toggleShowImg();
    notifyListeners();
  }
}
