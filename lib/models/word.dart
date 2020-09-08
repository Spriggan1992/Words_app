import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'part.dart';

// ignore: must_be_immutable
class Word extends Equatable with ChangeNotifier {
  Word({
    this.collectionId,
    this.id,
    this.targetLang,
    this.secondLang,
    this.thirdLang,
    this.ownLang,
    this.part,
    this.image,
    this.example,
    this.exampleTranslations,
    this.isSelected = false,
    int difficulty,
    // this.isEditingMode,
  }) : this.difficulty = difficulty ?? 2;
  final String collectionId;
  final String id;
  final String targetLang;
  final String ownLang;
  final String secondLang;
  final String thirdLang;
  final Part part;
  final File image;
  final String example;
  final String exampleTranslations;

  final bool isSelected;

  final int difficulty;

  Word copyWith({
    String collectionId,
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
    int difficulty,
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
      isSelected: isSelected ?? this.isSelected,
      collectionId: collectionId ?? this.collectionId,
      difficulty: difficulty ?? this.difficulty,
    );
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
        isSelected,
        collectionId,
        qdifficulty,
      ];
}
