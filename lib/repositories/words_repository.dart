import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:words_app/utils/DummyData.dart';
import 'package:words_app/utils/db_helper.dart';
import 'package:words_app/models/part.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/utils/utilities.dart';

class WordsRepository with ChangeNotifier {
  List<Word> _words = [];

  List<Word> get words {
    return [..._words];
  }

  Word findById(id) {
    return _words.firstWhere((wordId) => wordId.id == id);
  }

  //Card Creator

  Future<void> addNewWord(Word word) async {
    // print("Print from AddNEwWord ${word.id}");
    print('PRINT FROM Words_repository:  ${word.collectionId}');
    DBHelper.insert('words', {
      'collectionId': word.collectionId,
      'id': word.id,
      'targetLang': word.targetLang,
      'ownLang': word.ownLang,
      'secondLang': word.secondLang,
      'thirdLang': word.thirdLang,
      'partName': word.part.partName,
      'partColor': word.part.partColor.toString(),
      'image': word.image?.path ?? '',
      'example': word.example,
      'exampleTranslations': word.exampleTranslations,
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
      // print(
      //     "FROM WORDS REPOSITORY IMAGE PATH: ${File(item['image'])}");
//      print(item['partColor']);
      Word word = Word(
        collectionId: item['collectionId'],
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

  // ///update [Word] by ID receiving <Map>[data]
  // Future<void> updateWord({Map<String, Object> data}) async {
  //   final db = await DBHelper.database();
  //   db.update(
  //     'words',
  //     data,
  //     where: 'id = ?',
  //     whereArgs: [data['id']],
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  ///update [Word] by ID receiving <Map>[data]
  Future<void> updateWord({Word word}) async {
    final db = await DBHelper.database();
    Map<String, Object> data = {
      'collectionId': word.collectionId,
      'id': word.id,
      'targetLang': word.targetLang,
      'ownLang': word.ownLang,
      'secondLang': word.secondLang,
      'thirdLang': word.thirdLang,
      'partName': word.part.partName,
      'partColor': word.part.partColor.toString(),
      'image': word.image?.path ?? '',
      'example': word.example,
      'exampleTranslations': word.exampleTranslations,
    };
    db.update(
      'words',
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> toggleIsEditMode(bool value) async {
    bool newValue = value ? true : false;
    return newValue;
  }

  void removeWord(Word word) {
    DBHelper.delete('words', word.id);
  }

  Future<dynamic> getImageFile() async {
    final picker = ImagePicker();
    PickedFile imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
//    final imageFile2 = await assetToFile('images/noimages.png');
//    print(imageFile2.path);
    //This check is needed if we didn't take a picture  and used back button in camera;

    if (imageFile == null) {
      return;
    }

    //Call imageCropper module and crop the image. I has different looks on Android and IOS
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 600,
      maxHeight: 600,
    );
    return croppedFile;
  }

  // void toggleTargetLang(Word words) {
  //   words.toggleTargetLang();

  //   notifyListeners();
  // }

  // void partHandleSubmit(dynamic value, Word words) {
  //   words.changePart(value);
  //   DBHelper.update('words', {
  //     'id': words.id,
  //     'partName': words.part.partName,
  //     'partColor': words.part.partColor.toString(),
  //   });
  //   notifyListeners();
  // }

  // void targetLangHandleSubmit(dynamic value, Word words) {
  //   words.changeTargetLang(value);
  //   DBHelper.update('words', {
  //     'id': words.id,
  //     'targetLang': words.targetLang,
  //   });
  //   notifyListeners();
  // }

  // void secondLangHandleSubmit(dynamic value, Word words) {
  //   words.changeSecondLang(value);
  //   DBHelper.update('words', {
  //     'id': words.id,
  //     'secondLang': words.secondLang,
  //   });
  //   notifyListeners();
  // }

  // void thirdLangHandleSubmit(dynamic value, Word words) {
  //   words.changeThirdLang(value);
  //   DBHelper.update('words', {
  //     'id': words.id,
  //     'thirdLang': words.thirdLang,
  //   });
  //   notifyListeners();
  // }

  // void ownLangHandleSubmit(dynamic value, Word words) {
  //   words.changeOwnLang(value);
  //   DBHelper.update('words', {
  //     'id': words.id,
  //     'ownLang': words.ownLang,
  //   });
  //   notifyListeners();
  // }

  // void toggleSecondLang(Word words) {
  //   words.toggleSecondLang();
  //   notifyListeners();
  // }

  // void toggleOwnLang(Word words) {
  //   words.toggleOwnLang();
  //   notifyListeners();
  // }

  // void toggleShowImgInWordsProvider(Word words) {
  //   words.toggleShowImg();
  //   notifyListeners();
  // }

  bool isEditingMode = false;
  // bool isSelected = false;

  void toggleIsEditingMode() {
    isEditingMode = !isEditingMode;
    notifyListeners();
  }

  // void toggleisSelectedWord(Word words) {
  //   words.toggleIsSelected();
  //   // DBHelper.update('words', {
  //   //   'id': words.id,
  //   //   'isSelected': words.isSelected,
  //   // });
  //   notifyListeners();
  // }

  List selectedData = [];

  // void toogleAllSelectedWords(List<Word> words) {
  //   var dataList = [];
  //   words.forEach((item) => {dataList.add(item.isSelected)});
  //   for (int i = 0; i < words.length; i++) {
  //     if (dataList.every((element) => element == false)) {
  //      words[i].isSelected = true;
  //     } else if (dataList.every((element) => element == true)) {
  //       wordsData[i].isSelected = false;
  //     } else if (dataList.contains(true)) {
  //       wordsData[i].isSelected = true;
  //     }
  //   }

  //   notifyListeners();
  // }

  void addItemInList() {
    words.forEach((item) {
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
    print(words.length);
    words.forEach((element) {
      if (element.isSelected == true) {
        words.remove(element);
        DBHelper.delete('words', element.id);
      }
    });

    notifyListeners();
  }
}
