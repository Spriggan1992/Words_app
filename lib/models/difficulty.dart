import 'package:flutter/material.dart';
import 'package:words_app/config/constants.dart';

class Difficulty {
  final int difficulty;
  final Color color;
  final String name;

  Difficulty({this.name, this.difficulty, this.color});

  Difficulty copyWith({int difficulty}) {
    return Difficulty(difficulty: difficulty ?? this.difficulty);
  }
}

class DifficultyList {
  List<Difficulty> difficultyList = [
    Difficulty(difficulty: 0, name: 'know', color: kDifficultyKnowColor),
    Difficulty(
        difficulty: 1,
        name: "know a little",
        color: kDifficultyKnowALittleColor),
    Difficulty(
        difficulty: 2, name: "don't know", color: kDifficultyDontKnowColor),
  ];
}
