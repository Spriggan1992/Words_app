import 'package:flutter/material.dart';
import 'package:words_app/models/training_matches_data.dart';

class TrainingMatches with ChangeNotifier {
  List<MatchesWord> listMatches = [];

  // List<MatchesWord> get listMatches {
  //   return [..._listMatches];
  // }

  void addWord(String targetLangWord, bool isVisible) {
    final matches =
        MatchesWord(targetLangWord: targetLangWord, isVisible: isVisible);
    listMatches.add(matches);
    // notifyListeners();
  }

  void cleanData() {
    listMatches.clear();
    notifyListeners();
  }

  void toggleAllVisibility() {
    listMatches.map((item) => item.isVisible = false);
  }
}
