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
  String ownLang;
  String secondLang;
  String thirdLang;
  Part part;
  File image;
  String example;
  String exampleTranslations;
  bool isEditingWord1;
  bool isEditingWord2;
  bool isEditingTranslationTitle;
  bool isEditingExampleTitle = true;
  bool isEditingShowImg = true;

  void changePart(Part newPart) {
    part = newPart;
  }

  void toggleTargetLang() {
    isEditingWord1 = !isEditingWord1;
  }

  void toggleSecondLang() {
    isEditingWord2 = !isEditingWord2;
  }

  void toggleOwnLang() {
    isEditingTranslationTitle = !isEditingTranslationTitle;
  }

  void toggleShowImg() {
    isEditingShowImg = !isEditingShowImg;
  }

  void changeTargetLang(String newName) {
    targetLang = newName;
  }

  void changeSecondLang(String newName) {
    secondLang = newName;
  }

  void changeOwnLang(String newName) {
    ownLang = newName;
  }

  void changeThirdLang(String newName) {
    thirdLang = newName;
  }
}
