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
  /// This method is responsible for adding new word to DB.
  Future<void> addNewWord(Word word) async {
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
      'difficulty': word.difficulty,
    });
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
        difficulty: item['difficulty'],
      );
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

  void removeWord(Word word) async {
    await word.image.delete();
    DBHelper.delete('words', word.id);
  }

  /// /// This method is responsible for returning picter [File].
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

  bool isEditingMode = false;
  // bool isSelected = false;

  void toggleIsEditingMode() {
    isEditingMode = !isEditingMode;
    notifyListeners();
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
    notifyListeners();
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
          await element.image.delete();
          words.remove(element);
          await DBHelper.delete('words', element.id);
        }
      },
    );

    notifyListeners();
  }
}
