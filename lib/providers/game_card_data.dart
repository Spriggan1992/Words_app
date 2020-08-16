import 'package:flutter/material.dart';

class GameCard {
  final String id;
  final String targetLang;
  final String ownLang;
  bool isChosen = false;

  GameCard({this.ownLang, this.id, this.targetLang, this.isChosen});

  void choseCard() {
    isChosen = !isChosen;
  }
}

class MyCard {
  String id;
  bool visible = true;
  String word;
  bool isWrong;
  bool isToggled = false;
  Color color = Colors.grey[200];

  MyCard({this.id, this.word});

  void toggleMyCard() {
    isToggled = !isToggled;
//    if (isToggled == false) {
//      color = Colors.grey[200];
//    } else {
//      color = Colors.grey;
//    }
  }

  void toggleVisibility() {
    visible = false;
  }
}
