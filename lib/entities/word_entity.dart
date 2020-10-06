import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:words_app/models/models.dart';

class WordEntity extends Equatable {
  final String collectionId;
  final String id;
  final String targetLang;
  final String ownLang;
  final String secondLang;
  final String thirdLang;
  final String partName;
  final String partColor;
  final String image;
  final String example;
  final String exampleTranslations;

  final int difficulty;

  WordEntity({
    this.collectionId,
    this.id,
    this.targetLang,
    this.secondLang,
    this.thirdLang,
    this.ownLang,
    this.partName,
    this.partColor,
    this.image,
    this.example,
    this.exampleTranslations,
    this.difficulty,
  });

  @override
  List<Object> get props => [
        collectionId,
        id,
        targetLang,
        ownLang,
        secondLang,
        thirdLang,
        partName,
        partColor,
        image,
        example,
        exampleTranslations
      ];

  @override
  String toString() => '''WordEntity{
    collectionId: $collectionId,
    id: $id,
    targetLang: $targetLang,
    secondLang: $secondLang,
    thirdLang: $thirdLang,
    partName: $partName,
    partColor: $partColor,
    image: $image,
    example: $example,
    exampleTranslations: $exampleTranslations
  }''';

  Map<String, dynamic> toDb() {
    return {
      'collectionId': collectionId,
      'id': id,
      'targetLang': targetLang,
      'ownLang': ownLang,
      'secondLang': secondLang,
      'thirdLang': thirdLang,
      'partName': partName,
      'partColor': partColor,
      'image': image ?? '',
      'example': example,
      'exampleTranslations': exampleTranslations,
      'difficulty': difficulty,
    };
  }

  factory WordEntity.fromDb(Map<String, dynamic> data) {
    return WordEntity(
        collectionId: data['collectionId'] ?? '',
        id: data['id'] ?? '',
        targetLang: data['targetLang'] ?? '',
        ownLang: data['ownLang'] ?? '',
        secondLang: data['secondLang'] ?? '',
        thirdLang: data['thirdLang'] ?? '',
        partName: data['partName'] ?? '',
        partColor: data['partColor'] ?? '',
        image: data['image'] ?? '',
        example: data['example'] ?? '',
        exampleTranslations: data['exampleTranslations'] ?? '',
        difficulty: data['difficulty'] ?? '');
  }
}
