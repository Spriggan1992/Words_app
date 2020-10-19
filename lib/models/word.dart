import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:words_app/entities/entites.dart';
import 'package:words_app/utils/utilities.dart';
import 'part.dart';

// ignore: must_be_immutable
class Word extends Equatable with ChangeNotifier {
  Word({
    this.collectionId,
    String id,
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
  })  : this.difficulty = difficulty ?? 2,
        this.id = id ?? Uuid().v4();
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

  @override
  List<Object> get props => [
        collectionId,
        id,
        targetLang,
        ownLang,
        secondLang,
        thirdLang,
        part,
        image,
        example,
        exampleTranslations,
        isSelected,
      ];

  @override
  String toString() => '''Word{
    collectionId: $collectionId,
    id: $id,
    part: $part
    targetLang: $targetLang,
    ownLanguage: $ownLang,
    secondLang: $secondLang,
    thirdLang: $thirdLang,
    image: $image,
    example: $example,
    exampleTranslations: $exampleTranslations,
  }''';

  factory Word.fromEntity(WordEntity entity) {
    // print(" Word.fromEntity $entity");
    return Word(
      collectionId: entity.collectionId,
      id: entity.id,
      targetLang: entity.targetLang,
      ownLang: entity.ownLang,
      secondLang: entity.secondLang,
      thirdLang: entity.thirdLang,
      part: Part(
        partName: entity.partName,
        partColor: Utilities.getColor(entity.partColor),
      ),
      image: File(entity.image),
      example: entity.example,
      exampleTranslations: entity.exampleTranslations,
      difficulty: entity.difficulty,
      isSelected: false,
    );
  }
  WordEntity toEntity() {
    return WordEntity(
      collectionId: collectionId,
      id: id,
      targetLang: targetLang ?? ' ',
      ownLang: ownLang ?? ' ',
      secondLang: secondLang ?? ' ',
      thirdLang: thirdLang ?? ' ',
      partName: part != null ? part.partName : ' ',
      partColor:
          part != null ? part.partColor.toString() : Colors.white.toString(),
      image: image?.path ?? '',
      example: example ?? ' ',
      exampleTranslations: exampleTranslations ?? ' ',
      difficulty: difficulty,
    );
  }

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
}
