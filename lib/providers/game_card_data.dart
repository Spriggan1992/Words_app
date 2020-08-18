import 'package:flutter/material.dart';

class GameCard {
  final String id;
  final String targetLang;
  final String ownLang;
//  bool isChosen = false;

  GameCard({
    this.ownLang,
    this.id,
    this.targetLang,
//    this.isChosen,
  });

//  void choseCard() {
//    isChosen = !isChosen;
//  }
}

class MyCard {
  String id;
  bool visible = true;
  String word;
  bool isWrong = false;
  bool isToggled = false;
  Color color = Colors.grey[200];

  MyCard({this.id, this.word});

  ///toggleMyCard() changes the state of [isToggled]
  void toggleMyCard() {
    isToggled = !isToggled;
  }

  void toggleVisibility() {
    visible = false;
  }
}
