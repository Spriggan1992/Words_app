import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'part.dart';

// ignore: must_be_immutable
class Word extends Equatable with ChangeNotifier {
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
  final String id;
  final String targetLang;
  final String ownLang;
  final String secondLang;
  final String thirdLang;
  final Part part;
  final File image;
  final String example;
  final String exampleTranslations;
  final bool isEditingTargetLang;
  final bool isEditingSecondLang;
  final bool isEditingOwnLang;
  final bool isEditingExampleTitle = true;
  final bool isEditingShowImg = true;
  final bool isSelected;
  // bool isEditingMode;

  // void toggleIsEditingMode() {
  //   isEditingMode = !isEditingMode;
  // }

  Word copyWith({
    String id,
    String targetLang,
    String ownLang,
    String secondLang,
    String thirdLang,
    Part part,
    File image,
    String example,
    String exampleTranslations,
    bool isSelected,
  }) {
    return Word(
        id: id ?? this.id,
        targetLang: targetLang ?? this.targetLang,
        secondLang: secondLang ?? this.secondLang,
        thirdLang: thirdLang ?? this.thirdLang,
        ownLang: ownLang ?? this.ownLang,
        part: part ?? this.part,
        image: image ?? this.image,
        example: example ?? this.example,
        exampleTranslations: exampleTranslations ?? this.exampleTranslations,
        isSelected: isSelected ?? this.isSelected);

    
  }

  @override
  
  List<Object> get props => [
        targetLang,
        ownLang,
        secondLang,
        thirdLang,
        part,
        image,
        example,
        exampleTranslations,
        isSelected
      ];

      // void toggleIsSelected() {
    //   isSelected = !isSelected;
    // }

    // void changePart(Part newPart) {
    //   part = newPart;
    // }

    // void toggleTargetLang() {
    //   isEditingTargetLang = !isEditingTargetLang;
    // }

    // void toggleSecondLang() {
    //   isEditingSecondLang = !isEditingSecondLang;
    // }

    // void toggleOwnLang() {
    //   isEditingOwnLang = !isEditingOwnLang;
    // }

    // void toggleShowImg() {
    //   isEditingShowImg = !isEditingShowImg;
    // }

    // void changeTargetLang(String newName) {
    //   targetLang = newName;
    // }

    // void changeSecondLang(String newName) {
    //   secondLang = newName;
    // }

    // void changeOwnLang(String newName) {
    //   ownLang = newName;
    // }

    // void changeThirdLang(String newName) {
    //   thirdLang = newName;
    // }
}
