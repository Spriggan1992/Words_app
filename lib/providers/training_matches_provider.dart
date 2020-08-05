import 'package:flutter/material.dart';
import 'package:words_app/providers/training_matches_data.dart';

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
    print(listMatches);
    notifyListeners();
  }
}
