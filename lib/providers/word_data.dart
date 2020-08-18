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
    this.isEditingTargetLang = true,
    this.isEditingSecondLang = true,
    this.isEditingOwnLang = true,
    this.isSelected = false,
    // this.isEditingMode,
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
  bool isEditingTargetLang;
  bool isEditingSecondLang;
  bool isEditingOwnLang;
  bool isEditingExampleTitle = true;
  bool isEditingShowImg = true;
  bool isSelected;
  // bool isEditingMode;

  // void toggleIsEditingMode() {
  //   isEditingMode = !isEditingMode;
  // }

  void toggleIsSelected() {
    isSelected = !isSelected;
  }

  void changePart(Part newPart) {
    part = newPart;
  }

  void toggleTargetLang() {
    isEditingTargetLang = !isEditingTargetLang;
  }

  void toggleSecondLang() {
    isEditingSecondLang = !isEditingSecondLang;
  }

  void toggleOwnLang() {
    isEditingOwnLang = !isEditingOwnLang;
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
