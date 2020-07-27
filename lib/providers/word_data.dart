import 'dart:io';

import 'package:flutter/material.dart';

class Word with ChangeNotifier {
  Word({
    this.id,
    this.word1,
    this.word2,
    this.translation,
    this.part,
    this.image,
    this.isEditingWord1 = true,
    this.isEditingWord2 = true,
    this.isEditingTranslationTitle = true,
  });

  String id;
  String word1;
  String word2;
  String translation;
  String part;
  String image;
  bool isEditingWord1;
  bool isEditingWord2;
  bool isEditingTranslationTitle;
  bool isEditingExampleTitle = true;
  bool isEditingShowImg = true;

//  void selectImages(String id) {
//    try {
//      image = 'images/$id.jpeg';
//    } catch (e) {
//      print(e);
//    }
//  }

  void toggleWord1() {
    isEditingWord1 = !isEditingWord1;
  }

  void toggleWord2() {
    isEditingWord2 = !isEditingWord2;
  }

  void toggleTranslation() {
    isEditingTranslationTitle = !isEditingTranslationTitle;
  }

  void toggleShowImg() {
    isEditingShowImg = !isEditingShowImg;
  }

  void changeWord1Title(String newName) {
    word1 = newName;
  }

  void changeWord2Title(String newName) {
    if (newName.isEmpty) {
      word2 = '-';
    } else
      word2 = newName;
  }

  void changeTranslationTitle(String newName) {
    translation = newName;
  }
}
