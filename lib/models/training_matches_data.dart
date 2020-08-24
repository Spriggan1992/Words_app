import 'package:flutter/material.dart';

class MatchesWord<T> with ChangeNotifier {
  MatchesWord({
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
