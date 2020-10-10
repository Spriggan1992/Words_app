import 'dart:io';

import 'package:sqflite/sqflite.dart';

import 'package:words_app/config/paths.dart';
import 'package:words_app/entities/entites.dart';
import 'package:words_app/utils/DummyData.dart';
import 'package:words_app/utils/db_helper.dart';

import 'package:words_app/models/word.dart';
import 'package:words_app/utils/utilities.dart';

import '../../utils/db_helper.dart';
import '../repositories.dart';

class WordsRepository extends BaseWordsRepository {
  List<Word> _words = [];

  List<Word> get words {
    return [..._words];
  }

  @override
  void dispose() {}

  //Card Creator
  /// This method is responsible for adding new word to DB.
  @override
  Future<void> addNewWord({Word word}) async {
    DBHelper.insert(Paths.words, word.toEntity().toDb());
    DBHelper.incrementCounter(word.collectionId);
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
  @override
  Future<List<Word>> fetchAndSetWords({String collectionId}) async {
    final dataList =
        await DBHelper.getData('words', collectionId: collectionId);
    _words = dataList.map((item) {
      Word word = Word.fromEntity(WordEntity.fromDb(item));
      return word;
    }).toList();

    return _words;
  }

  ///update [Word] by ID receiving <Map>[data]
  @override
  Future<void> updateWord({Word word, String wordId}) async {
    final db = await DBHelper.database();
    db.update(
      Paths.words,
      word.toEntity().toDb(),
      where: 'id = ?',
      whereArgs: [wordId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<bool> toggleIsEditMode(bool value) async {
    bool newValue = value ? true : false;
    return newValue;
  }

  /// Method removeWord removes single file from from phone folder
  @override
  Future<void> removeWord(Word word) async {
    try {
      await word.image.delete();
    } on FileSystemException {}
    print(word.id);
    await DBHelper.dicrementtCounter(word.collectionId);
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

  // This method is used when we use selecting words feature. It delets as bunch of items
  @override
  Future<void> removeSelectedWords() async {
    words.forEach(
      (element) async {
        if (element.isSelected == true) {
          // Here we delete image from phisycal device
          try {
            await element.image.delete();
          } on FileSystemException {}
          words.remove(element);
          await DBHelper.delete(Paths.words, element.id);
        }
      },
    );
  }
}
