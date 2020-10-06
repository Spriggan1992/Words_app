import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:words_app/config/paths.dart';
import 'package:words_app/entities/entites.dart';
import 'package:words_app/utils/DummyData.dart';
import 'package:words_app/utils/db_helper.dart';
import 'package:words_app/models/part.dart';
import 'package:words_app/models/word_model.dart';
import 'package:words_app/utils/utilities.dart';

import '../repositories.dart';

class WordsRepository extends BaseWordsRepository {
  List<Word> _words = [];

  List<Word> get words {
    return [..._words];
  }

  // Word findById(id) {
  //   return _words.firstWhere((wordId) => wordId.id == id);
  // }
  @override
  void dispose() {}

  //Card Creator
  /// This method is responsible for adding new word to DB.
  @override
  Future<Word> addNewWord({Word word}) async {
    DBHelper.insert(Paths.words, word.toEntity().toDb());
    DBHelper.updateCounter(word.collectionId);
    return word;
  }

  //TODO: populate
  // temporary method for pre-populating list
  Future<List<Word>> populateList(String collectionId) async {
    List<Word> dummyDataList = DummyData.words;

    dummyDataList.forEach((item) async {
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
        'difficulty': item.difficulty,
      });
    });

    return dummyDataList;
  }

  /// This method is responsible fetching data from db and setting to UI words_screen.
  Future<List<Word>> fetchAndSetWords(String collectionId) async {
    final dataList =
        await DBHelper.getData('words', collectionId: collectionId);
    _words = dataList.map((item) {
      Word word = Word.fromEntity(WordEntity.fromDb(item));
      return word;
    }).toList();

    return _words;
  }

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
      'difficulty': word.difficulty,
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

  /// Method removeWord removes single file from from phone folder
  void removeWord(Word word) async {
    try {
      await word.image.delete();
    } on FileSystemException {}

    DBHelper.delete('words', word.id);
  }

  ///  This method is responsible for returning picter [File].
  // Future<dynamic> getImageFile() async {
  //   final picker = ImagePicker();
  //   PickedFile imageFile =
  //       await picker.getImage(source: ImageSource.camera, maxWidth: 600);
  //   // print('getImageFile ${imageFile.path}');

  //   //This if block checks   if we didn't take a picture  and used back button in camera;
  //   if (imageFile == null) {
  //     return;
  //   }

  //   //Call imageCropper module and crop the image. I has different looks on Android and IOS
  //   File croppedFile = await ImageCropper.cropImage(
  //     sourcePath: imageFile.path,
  //     maxWidth: 600,
  //     maxHeight: 600,
  //   );
  //   return croppedFile;
  // }

  bool isEditingMode = false;
  // bool isSelected = false;

  void toggleIsEditingMode() {
    isEditingMode = !isEditingMode;
  }

  List selectedData = [];

  void addItemInList() {
    words.forEach((item) {
      if (selectedData.contains(item)) {
        selectedData.remove(item);
      }
      if (item.isSelected == true) {
        selectedData.add(item);
      }
    });
  }

  void clearSelectedData() {
    selectedData.clear();
  }

  // This method is used when we use selecting words feature. It delets as bunch of items
  void removeSelectedWords() {
    words.forEach(
      (element) async {
        if (element.isSelected == true) {
          // Here we delete image from phisycal device
          try {
            await element.image.delete();
          } on FileSystemException {}
          words.remove(element);
          await DBHelper.delete('words', element.id);
        }
      },
    );
  }
}
