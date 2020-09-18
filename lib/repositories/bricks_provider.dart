import 'package:flutter/material.dart';
import 'package:words_app/models/brick.dart';
import 'package:words_app/models/word.dart';

enum dynamicColor { normal, success, error, wrong }

class Bricks with ChangeNotifier {
  List<Word> initialData;
  List<String> answerWordArray = [];
  String answer;

  /// flag: 0 = white color;  1 = successColorAnimation; 2 = errorColorAnimation, 3 = red color;
  int flag = 0;
  bool isCheckSlideTransition = true;
  List<Brick> listBricks = [];

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

  /// Run Slide Animation
  void runSlideAnimation(AnimationController slideTransitionController) {
    slideTransitionController.forward();
  }

//------------------------------------------------------------------------------

  /// -----------------Fetch and Load Data------------------------
  ///
  ///
  /// Get Words from word_screen and pass it to initialData varible and shuffle;
  void setUpInitialData(List<Word> words) {
    initialData = [...words]..shuffle();
  }

  /// Extract Word fromn initialData and pass it to [answer] as String.
  /// Split Word by letters and add to listBricks in [bricks_provider]
  void extractAndAssingData() {
    if (initialData.length >= 1) {
      // Add last word in targetLangWord;
      for (int i = 0; i < initialData.length; i++) {
        answer = initialData[i].targetLang.toLowerCase();
      }
      List<String> targetSplitted = answer.toLowerCase().split('');
      // Check if providerData.listBricks empty or not. If it empty-> add new word, else dont add it.
      if (listBricks.isEmpty) {
        targetSplitted.forEach((item) {
          addWord(item, true);
        });
      }
      listBricks.shuffle();
    } else {
      print('Data is Empty');
    }
  }

  /// Load next word
  void loadNextWord() {
    cleanData();
    if (initialData.length >= 1) {
      initialData.removeLast();
      extractAndAssingData();
    } else {
      initialData.clear();
    }
    answerWordArray.clear();
    notifyListeners();
  }

  /// Add Words to [listBricks]
  void addWord(String targetLangWord, bool isVisible) {
    final bricks = Brick(targetLangWord: targetLangWord, isVisible: isVisible);
    listBricks.add(bricks);
    // notifyListeners();
  }

  /// cleat [listBricks]
  void cleanData() {
    listBricks.clear();
  }

  /// Make target letters(bricks) to be vissible or hidden
  void toggleAllVisibility() {
    listBricks.map((item) => item.isVisible = false);
  }

  /// Set up color depending on what the [flag] variable will be equal to
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

  /// Check Answer
  ///
  /// If answer match to matchedAnswer = right answer --> run success animation --> load next word
  /// If asnwer don't match to matchedAnswer = wrong answer --> run error animation --> start over
  void checkAnswer(
      AnimationController successAnimationController,
      AnimationController errorAnimationController,
      AnimationController slideTransitionController,
      List<Word> initialData) {
    String matchedAnswer = answerWordArray.join('');
    if (answer.startsWith(matchedAnswer) == true) {
      flag = 1;
      runSuccessAnimation(successAnimationController);
      successAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          runSlideAnimation(slideTransitionController);
          loadNextWord();
          flag = 0;
        }
      });
    } else {
      flag = 2;
      runErrorAnimation(errorAnimationController);
      errorAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          for (int i = 0; i < listBricks.length; i++) {
            listBricks[i].isVisible = true;
            answerWordArray.clear();
            flag = 0;
          }
        }
      });
    }
  }

  /// Start over to match bricks
  ///
  /// Iterate over to all bricks and make them visible and clean [answerWordArray]
  void activateTryAgan() {
    for (int i = 0; i < listBricks.length; i++) {
      listBricks[i].isVisible = true;
      answerWordArray.clear();
      flag = 0;
    }
  }

  /// Delete letter(bricks) from answerWordArray
  ///
  /// When pressing on letter(breck) in answerWordArray, remove this letter from array
  /// and make all letter visible in ListBricks
  void returnLetters(String element) {
    for (int i = 0; i < listBricks.length; i++) {
      if (element == listBricks[i].targetLangWord &&
          listBricks[i].isVisible == false) {
        listBricks[i].isVisible = true;
        break;
      }
    }
    answerWordArray.remove(element);
  }

  /// Add letters(bricks) in [answerWordArray]
  void addLetter(String element) {
    answerWordArray.add(element);
  }

  /// return bool for activating Submit button
  bool activateSubmitBtn() {
    if (answerWordArray.length != listBricks.length) {
      return false;
    }
    return true;
  }

  /// Show correct answer and start over to match bricks
  void giveUp() {
    answer.split('').forEach((element) => answerWordArray.add(element));
    for (int i = 0; i < listBricks.length; i++) {
      listBricks[i].isVisible = false;
    }
    flag = 3;
  }

  /// Reset Word
  ///
  /// Make all letters(bricks) in [listBricks] to be visible and clear [answerWordArray]
  void resetWords() {
    for (int i = 0; i < listBricks.length; i++) {
      listBricks[i].isVisible = true;
      answerWordArray.clear();
      flag = 0;
    }
  }
}
