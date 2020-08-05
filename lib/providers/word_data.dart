import 'dart:io';

import 'package:flutter/material.dart';
import 'package:words_app/providers/part_data.dart';

class Word with ChangeNotifier {
  Word({
    this.id,
    this.targetLang,
    this.secondLang,
    this.thirdLang,
    this.ownLang,
    this.part,
    this.image,
    this.example,
    this.exampleTranslations,
    this.isEditingWord1 = true,
    this.isEditingWord2 = true,
    this.isEditingTranslationTitle = true,
  });

  String id;
  String targetLang;
  String secondLang;
  String thirdLang;
  String ownLang;
  Part part;
  File image;
  String example;
  String exampleTranslations;
  bool isEditingWord1;
  bool isEditingWord2;
  bool isEditingTranslationTitle;
  bool isEditingExampleTitle = true;
  bool isEditingShowImg = true;

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
    targetLang = newName;
  }

  void changeWord2Title(String newName) {
    if (newName.isEmpty) {
      secondLang = '-';
    } else
      secondLang = newName;
  }

  void changeTranslationTitle(String newName) {
    ownLang = newName;
  }
}
