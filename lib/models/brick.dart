import 'package:flutter/material.dart';

class Brick<T> with ChangeNotifier {
  Brick({
    this.targetLangWord,
    this.isVisible,
    // this.ownLangWord,
  });
  bool isVisible = true;
  final String targetLangWord;
  // final String ownLangWord;

  void toggleVisibility() {
    isVisible = !isVisible;
  }
}
