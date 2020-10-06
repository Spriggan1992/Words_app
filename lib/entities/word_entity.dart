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
  final Part part;
  final File image;
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
    this.part,
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
        part,
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
    image: $image,
    example: $example,
    exampleTranslations: $exampleTranslations
  }''';

  Map<String, dynamic> toDb() {
    return {
      'collectionId': collectionId,
      'id': id,
      'targetLang': targetLang,
      'secondLang': secondLang,
      'thirdLang': thirdLang,
      'image': image,
      'example': example,
      'exampleTranslations': exampleTranslations,
    };
  }

  factory WordEntity.fromDb(Map<String, dynamic> data) {
    return WordEntity(
      collectionId: ['collectionId'] ?? '',
      id: ['id'] ?? '',
      targetLang: ['targetLang'] ?? '',
      secondLang: ['secondLang'] ?? '',
      thirdLang: ['thirdLang'] ?? '',
      image: ['image'] ?? '',
      example: ['example'] ?? '',
      exampleTranslations: ['exampleTranslations'] ?? '',
    );
  }
}
