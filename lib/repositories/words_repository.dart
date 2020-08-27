import 'dart:io';

import 'package:flutter/material.dart';
import 'package:words_app/utils/DummyData.dart';
import 'package:words_app/utils/db_helper.dart';
import 'package:words_app/models/part.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/utils/utilities.dart';

class WordsRepository with ChangeNotifier {
  List<Word> _words = [];

  List<Word> get wordsData {
    return [..._words];
  }

  Word findById(id) {
    return _words.firstWhere((wordId) => wordId.id == id);
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
    // bool isEditingMode,
    bool isSelected,
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
      // isEditingMode: false,
      isSelected: isSelected,
    );
    _words.add(wordCard);
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
      'isSelected': isSelected,
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

  Future<List<Word>> fetchAndSetWords(String collectionId) async {
    final dataList =
        await DBHelper.getData('words', collectionId: collectionId);
//    print('DEBUG fetchAndSetWords ${dataList}');
    _words = dataList.map((item) {
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

    return _words;
  }

  Future<bool> toggleIsEditMode(bool value) async {
    bool newValue = value ? true : false;
    return newValue;
  }

  void removeWord(value) {
    _words.remove(value);
    notifyListeners();
    DBHelper.delete('words', value.id);
  }

  void toggleTargetLang(Word words) {
    words.toggleTargetLang();

    notifyListeners();
  }

  void partHandleSubmit(dynamic value, Word words) {
    words.changePart(value);
    DBHelper.update('words', {
      'id': words.id,
      'partName': words.part.partName,
      'partColor': words.part.partColor.toString(),
    });
    notifyListeners();
  }

  void targetLangHandleSubmit(dynamic value, Word words) {
    words.changeTargetLang(value);
    DBHelper.update('words', {
      'id': words.id,
      'targetLang': words.targetLang,
    });
    notifyListeners();
  }

  void secondLangHandleSubmit(dynamic value, Word words) {
    words.changeSecondLang(value);
    DBHelper.update('words', {
      'id': words.id,
      'secondLang': words.secondLang,
    });
    notifyListeners();
  }

  void thirdLangHandleSubmit(dynamic value, Word words) {
    words.changeThirdLang(value);
    DBHelper.update('words', {
      'id': words.id,
      'thirdLang': words.thirdLang,
    });
    notifyListeners();
  }

  void ownLangHandleSubmit(dynamic value, Word words) {
    words.changeOwnLang(value);
    DBHelper.update('words', {
      'id': words.id,
      'ownLang': words.ownLang,
    });
    notifyListeners();
  }

  void toggleSecondLang(Word words) {
    words.toggleSecondLang();
    notifyListeners();
  }

  void toggleOwnLang(Word words) {
    words.toggleOwnLang();
    notifyListeners();
  }

  void toggleShowImgInWordsProvider(Word words) {
    words.toggleShowImg();
    notifyListeners();
  }

  bool isEditingMode = false;
  // bool isSelected = false;

  void toggleIsEditingMode() {
    isEditingMode = !isEditingMode;
    notifyListeners();
  }

  void toggleisSelectedWord(Word words) {
    words.toggleIsSelected();
    // DBHelper.update('words', {
    //   'id': words.id,
    //   'isSelected': words.isSelected,
    // });
    notifyListeners();
  }

  List selectedData = [];

  void toogleAllSelectedWords() {
    var dataList = [];
    wordsData.forEach((item) => {dataList.add(item.isSelected)});
    for (int i = 0; i < wordsData.length; i++) {
      if (dataList.every((element) => element == false)) {
        wordsData[i].isSelected = true;
      } else if (dataList.every((element) => element == true)) {
        wordsData[i].isSelected = false;
      } else if (dataList.contains(true)) {
        wordsData[i].isSelected = true;
      }
      // DBHelper.update('words', {
      //   'id': wordsData[i].id,
      //   'isSelected': wordsData[i].isSelected,
      // });
    }

    notifyListeners();
  }

  void addItemInList() {
    wordsData.forEach((item) {
      if (selectedData.contains(item)) {
        selectedData.remove(item);
      }
      if (item.isSelected == true) {
        selectedData.add(item);
      }
    });
    notifyListeners();
  }

  void clearSelectedData() {
    selectedData.clear();
  }

  void removeSelectedWords() {
    print(wordsData.length);
    wordsData.forEach((element) {
      if (element.isSelected == true) {
        wordsData.remove(element);
        DBHelper.delete('words', element.id);
      }
    });

    notifyListeners();
  }
}
