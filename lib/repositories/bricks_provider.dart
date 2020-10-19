import 'package:flutter/material.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/brick.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/screens/screens.dart';

enum DynamicColor { normal, success, error, wrong }

class Bricks with ChangeNotifier {
  List<Word> initialData;
  List<String> answerWordArray = [];
  String answer;
  int correct = 0;
  int wrong = 0;

  /// DynamicColor: normal = white color;  success = successColorAnimation; error = errorColorAnimation, wrong = red color;
  DynamicColor dynamicColor = DynamicColor.normal;
  bool isCheckSlideTransition = true;
  List<Brick> listBricks = [];

//----------------------- Animations-------------------------------
  /// Run Shake Animation
  void runShakeAnimation(AnimationController shakeController) {
    shakeController.forward(from: 0.0);
    notifyListeners();
  }

  /// Run Error Animation
  void runErrorAnimation(AnimationController errorAnimationController) {
    errorAnimationController.forward(from: 0.0);
    notifyListeners();
  }

  /// Run Success Animation
  void runSuccessAnimation(AnimationController successAnimationController) {
    successAnimationController.forward(from: 0.0);
    notifyListeners();
  }

  /// Run Slide Animation
  void runSlideAnimation(AnimationController slideTransitionController) {
    slideTransitionController.forward();
    notifyListeners();
  }

//------------------------------------------------------------------------------

  /// -----------------Fetch and Load Data------------------------
  ///
  ///
  /// Get Words from word_screen and pass it to initialData varible and shuffle;
  Future<void> setUpInitialData(List<Word> words) async {
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
    // notifyListeners();
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
    notifyListeners();
  }

  /// cleat [listBricks]
  void cleanData() {
    listBricks.clear();
    notifyListeners();
  }

  void toggleVisible(Brick item) {
    item.isVisible = !item.isVisible;
    notifyListeners();
  }

  /// Make target letters(bricks) to be vissible or hidden
  void toggleAllVisibility() {
    listBricks.map((item) => item.isVisible = false);
    notifyListeners();
  }

  /// Set up color depending on what the [dynamicColor] variable will be equal to
  Color setUpColor(Animation<dynamic> successColorAnimation,
      Animation<dynamic> errorColorAnimation) {
    if (dynamicColor == DynamicColor.success) {
      return successColorAnimation.value;
    }
    if (dynamicColor == DynamicColor.error) {
      return errorColorAnimation.value;
    }
    if (dynamicColor == DynamicColor.wrong) {
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
    List<Word> initialData,
    BuildContext context,
  ) {
    String matchedAnswer = answerWordArray.join('');
    if (answer.startsWith(matchedAnswer) == true) {
      dynamicColor = DynamicColor.success;
      runSuccessAnimation(successAnimationController);
      correct++;
      successAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          runSlideAnimation(slideTransitionController);
          loadNextWord();
          dynamicColor = DynamicColor.normal;
          goToResultScreen(initialData, context,
              ResultScreen(correct: correct, wrong: wrong));
        }
      });
    } else {
      dynamicColor = DynamicColor.error;
      runErrorAnimation(errorAnimationController);
      errorAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          for (int i = 0; i < listBricks.length; i++) {
            listBricks[i].isVisible = true;
            answerWordArray.clear();
            wrong++;
            dynamicColor = DynamicColor.normal;
            goToResultScreen(initialData, context,
                ResultScreen(correct: correct, wrong: wrong));
          }
        }
      });
    }

    notifyListeners();
  }

  /// Start over to match bricks
  ///
  /// Iterate over to all bricks and make them visible and clean [answerWordArray]
  void activateTryAgan() {
    for (int i = 0; i < listBricks.length; i++) {
      listBricks[i].isVisible = true;
      answerWordArray.clear();
      dynamicColor = DynamicColor.normal;
    }
    notifyListeners();
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
    notifyListeners();
  }

  /// Add letters(bricks) in [answerWordArray]
  void addLetter(String element) {
    answerWordArray.add(element);
    notifyListeners();
  }

  /// Activate submit button
  void activateSubmitBtn(successAnimationController, errorAnimationController,
      slideTransitionController, shakeController, context) {
    if (answerWordArray.length != listBricks.length) {
      runShakeAnimation(shakeController);
    } else if (dynamicColor == DynamicColor.wrong) {
      activateTryAgan();
    } else {
      checkAnswer(successAnimationController, errorAnimationController,
          slideTransitionController, initialData, context);
    }
  }

  /// Show correct answer and start over to match bricks
  void giveUp() {
    answer.split('').forEach((element) => answerWordArray.add(element));
    for (int i = 0; i < listBricks.length; i++) {
      listBricks[i].isVisible = false;
    }
    wrong++;
    dynamicColor = DynamicColor.wrong;
    notifyListeners();
  }

  /// Reset Word
  ///
  /// Make all letters(bricks) in [listBricks] to be visible and clear [answerWordArray]
  void resetWords() {
    for (int i = 0; i < listBricks.length; i++) {
      listBricks[i].isVisible = true;
      answerWordArray.clear();
      dynamicColor = DynamicColor.normal;
    }
    notifyListeners();
  }

  /// Clear all data when pressing comeback button in appbar
  void backAndClearData(BuildContext context) {
    showCustomDialog(
      context: context,
      title: 'Are you sure?',
      content: 'Do you want to finish your traning?',
      function: () {
        Navigator.pushNamed(context, TrainingManager.id);
        initialData.clear();
        cleanData();
        resetWords();
        answerWordArray.clear();
        dynamicColor = DynamicColor.normal;
      },
    );
  }
}
