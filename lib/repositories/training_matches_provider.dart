import 'dart:async';

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

  List<Word> initialData;
  var shuffledWord;
  List<String> answerWordArray = [];
  String matches;
  int flag = 0;
  bool isCheckSlideTransition = true;

//----------------------- Animations-------------------------------
  /// Run Shake Animation
  void runShakeAnimation(AnimationController shakeController) {
    shakeController.forward(from: 0.0);
  }

  /// Run Error Animation
  void runErrorAnimation(AnimationController errorAnimationController) {
    errorAnimationController.forward(from: 0.0);
  }

  /// Run Success Animation
  void runSuccessAnimation(AnimationController successAnimationController) {
    successAnimationController.forward(from: 0.0);
  }

  void runSlideAnimation(AnimationController slideTransitionController) {
    slideTransitionController.forward();

    loadNextWord();
    notifyListeners();
  }

  // Timer(Duration(milliseconds: 100), () {
  //     loadNextWord();
  //   });
//------------------------------------------------------------------------------

  void loadNextWord() {
    cleanData();
    if (initialData.length >= 1) {
      initialData.removeLast();
      extractAndGetDataFromProvider();
    } else {
      initialData.clear();
    }
    answerWordArray.clear();
    notifyListeners();
  }

  /// -----------------Fetch data------------------------
  ///
  ///
  ///
  void getDataFromProvider(List<Word> words) {
    initialData = [...words]..shuffle();
  }

  void extractAndGetDataFromProvider() {
    if (initialData.length >= 1) {
      // Add last word in targetLangWord;
      for (int i = 0; i < initialData.length; i++) {
        matches = initialData[i].targetLang.toLowerCase();
      }
      List<String> targetSplitted = matches.toLowerCase().split('');
      // Check if providerData.listMatches empty or not. If it empty-> add new word, else dont add it.
      if (listMatches.isEmpty) {
        targetSplitted.forEach((item) {
          addWord(item, true);
        });
      }

      listMatches.shuffle();
      print(listMatches);
    } else {
      print('Data is Empty');
    }
  }

  Color setUpColor(Animation<dynamic> successColorAnimation,
      Animation<dynamic> errorColorAnimation) {
    if (flag == 1) {
      return successColorAnimation.value;
    }
    if (flag == 2) {
      return errorColorAnimation.value;
    }
    if (flag == 3) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  void checkAnswer(
      AnimationController successAnimationController,
      AnimationController errorAnimationController,
      AnimationController slideTransitionController,
      List<Word> initialData) {
    String a = answerWordArray.join('');
    if (matches.startsWith(a) == true) {
      flag = 1;
      runSuccessAnimation(successAnimationController);
      successAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          runSlideAnimation(slideTransitionController);
          flag = 0;
        }
      });
    } else {
      flag = 2;
      runErrorAnimation(errorAnimationController);
      errorAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          for (int i = 0; i < listMatches.length; i++) {
            listMatches[i].isVisible = true;
            answerWordArray.clear();
            flag = 0;
          }
        }
      });
    }
  }

  void activateTryAgan() {
    for (int i = 0; i < listMatches.length; i++) {
      listMatches[i].isVisible = true;
      answerWordArray.clear();
      flag = 0;
    }
  }

  void returnLetters(String element) {
    for (int i = 0; i < listMatches.length; i++) {
      if (element == listMatches[i].targetLangWord &&
          listMatches[i].isVisible == false) {
        listMatches[i].isVisible = true;
        break;
      }
    }
    answerWordArray.remove(element);
  }

  void addLetter(String element) {
    answerWordArray.add(element);
  }

  bool activateSubmitBtn() {
    if (answerWordArray.length != listMatches.length) {
      return false;
    }
    return true;
  }

  void giveUp() {
    matches.split('').forEach((element) => answerWordArray.add(element));
    for (int i = 0; i < listMatches.length; i++) {
      listMatches[i].isVisible = false;
    }
    flag = 3;
  }

  void resetWords() {
    for (int i = 0; i < listMatches.length; i++) {
      listMatches[i].isVisible = true;
      answerWordArray.clear();
      flag = 0;
    }
  }
}
