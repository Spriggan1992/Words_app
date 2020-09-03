import 'package:flutter/material.dart';

class Difficulty {
  final int difficulty;
  final Color color;
  final String name;

  Difficulty({this.name, this.difficulty, this.color});
}

class DifficultyList {
  List<Difficulty> difficultyList = [
    Difficulty(difficulty: 0, name: 'know', color: Color(0xFFd4f1c7)),
    Difficulty(difficulty: 1, name: "know a little", color: Color(0xFFfbe7c6)),
    Difficulty(difficulty: 2, name: "don't know", color: Color(0xFFfea3ab)),
  ];
}
