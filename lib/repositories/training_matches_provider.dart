import 'package:flutter/material.dart';
import 'package:words_app/models/training_matches_data.dart';
import 'package:words_app/models/word.dart';

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

//----------------------- Animations-------------------------------
  /// Run Shake Animation
  TickerFuture runShakeAnimation(AnimationController shakeController) {
    return shakeController.forward(from: 0.0);
  }

  /// Run Error Animation
  TickerFuture runErrorAnimation(AnimationController errorAnimationController) {
    return errorAnimationController.forward(from: 0.0);
  }

  /// Run Success Animation
  TickerFuture runSuccessAnimation(
      AnimationController successAnimationController) {
    return successAnimationController.forward(from: 0.0);
  }
//------------------------------------------------------------------------------

  // void loadNextWord(
  //   List<Word> initialData,
  //   List<String> answerWordArray,
  // ) {
  //   cleanData();
  //   if (initialData.length >= 1) {
  //     initialData.removeLast();
  //     extractAndGetDataFromProvider();
  //   } else {
  //     initialData.clear();
  //   }
  //   answerWordArray.clear();
  // }

  // void extractAndGetDataFromProvider(
  //   List<Word> initialData,
  //   String matches,
  // ) {
  //   if (initialData.length >= 1) {
  //     // Add last word in targetLangWord;
  //     for (int i = 0; i < initialData.length; i++) {
  //       matches = initialData[i].targetLang.toLowerCase();
  //     }
  //     List<String> targetSplitted = matches.toLowerCase().split('');
  //     // Check if providerData.listMatches empty or not. If it empty-> add new word, else dont add it.
  //     if (listMatches.isEmpty) {
  //       targetSplitted.forEach((item) {
  //         addWord(item, true);
  //       });
  //     }

  //     listMatches.shuffle();
  //   } else {
  //     print('Data is Empty');
  //   }
  // }
}
