import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/repositories/training_matches_provider.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/utils/size_config.dart';

class Bricks extends StatefulWidget {
  static String id = 'matches_screen';
  final List<Word> words;

  const Bricks({Key key, this.words}) : super(key: key);

  @override
  _BricksState createState() => _BricksState();
}

class _BricksState extends State<Bricks> with TickerProviderStateMixin {
  AnimationController _errorAnimationController;
  AnimationController _successAnimationController;
  AnimationController _shakeController;
  AnimationController _slideTransitionController;

  Animation<double> shakeBtnAnimation;
  Animation errorColorAnimation;
  Animation successColorAnimation;
  Animation slideTransitionAnimation;

  List<Word> initialData;
  var shuffledWord;
  List<String> answerWordArray = [];
  String matches;
  int flag = 0;
  bool isCheckSlideTransition = true;
  // bool waitingAnimation = false;

  static final tweenSequenceError = TweenSequence(<TweenSequenceItem<Color>>[
    TweenSequenceItem<Color>(
        tween: ColorTween(begin: Colors.red, end: Colors.white), weight: 33),
    TweenSequenceItem<Color>(
        tween: ColorTween(begin: Colors.white, end: Colors.red), weight: 33),
    TweenSequenceItem<Color>(
        tween: ColorTween(begin: Colors.red, end: Colors.white), weight: 33),
  ]);
  static final tweenSequenceSuccess = TweenSequence(<TweenSequenceItem<Color>>[
    TweenSequenceItem<Color>(
        tween: ColorTween(begin: Colors.green, end: Colors.white), weight: 33),
    TweenSequenceItem<Color>(
        tween: ColorTween(begin: Colors.white, end: Colors.green), weight: 33),
    TweenSequenceItem<Color>(
        tween: ColorTween(begin: Colors.green, end: Colors.white), weight: 33),
  ]);

  @override
  void initState() {
    super.initState();
    getDataFromProvider();
    extractAndGetDataFromProvider();

    _errorAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    errorColorAnimation = tweenSequenceError.animate(_errorAnimationController)
      ..addListener(() {
        setState(() {});
      });
    _successAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    successColorAnimation =
        tweenSequenceSuccess.animate(_successAnimationController)
          ..addListener(() {
            setState(() {});
          });

    _shakeController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    shakeBtnAnimation = Tween(begin: 0.0, end: 20.0)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(_shakeController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _shakeController.reverse();
            }
          });
    _slideTransitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    slideTransitionAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(2.0, 0.0))
            .animate(_slideTransitionController)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _slideTransitionController.reverse();
                }
              });
  }

  @override
  void dispose() {
    _errorAnimationController.dispose();
    _shakeController.dispose();
    _slideTransitionController.dispose();
    _successAnimationController.dispose();
    super.dispose();
  }

  void runSlideAnimation() {
    // _successAnimationController.forward(from: 0.0);
    _slideTransitionController.forward();
    Timer(Duration(milliseconds: 100), () {
      loadNextWord();
    });
    setState(() {});
  }

  // void runShakeAnimation() {
  //   _shakeController.forward(from: 0.0);
  //   setState(() {});
  // }

  // void runErrorAnimation() {
  //   _errorAnimationController.forward(from: 0.0);
  //   setState(() {});
  // }

  // void runSuccessAnimation() {
  //   _successAnimationController.forward(from: 0.0);
  //   setState(() {});
  // }

  void getDataFromProvider() {
    initialData = [...widget.words]..shuffle();
  }

  void extractAndGetDataFromProvider() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    if (initialData.length >= 1) {
      // Add last word in targetLangWord;
      for (int i = 0; i < initialData.length; i++) {
        matches = initialData[i].targetLang.toLowerCase();
      }
      List<String> targetSplitted = matches.toLowerCase().split('');
      // Check if providerData.listMatches empty or not. If it empty-> add new word, else dont add it.
      if (providerData.listMatches.isEmpty) {
        targetSplitted.forEach((item) {
          providerData.addWord(item, true);
        });
      }

      shuffledWord = providerData;
      shuffledWord.listMatches.shuffle();
      print(shuffledWord.listMatches);
    } else {
      print('Data is Empty');
    }
  }

  Future<bool> onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to finish your traning?'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                  initialData.clear();
                  Provider.of<TrainingMatches>(context, listen: false)
                      .cleanData();
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Color setUpColor() {
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

  void checkAnswer() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    String a = answerWordArray.join('');
    if (matches.startsWith(a) == true) {
      flag = 1;
      providerData.runSuccessAnimation(_successAnimationController);
      _successAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          runSlideAnimation();
          flag = 0;
        }
      });
    } else {
      flag = 2;
      providerData.runErrorAnimation(_errorAnimationController);
      _errorAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          for (int i = 0; i < providerData.listMatches.length; i++) {
            providerData.listMatches[i].isVisible = true;
            answerWordArray.clear();
            flag = 0;
          }
        }
      });
    }
    setState(() {});
  }

  void activateTryAgan() {
    setState(() {});
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    for (int i = 0; i < providerData.listMatches.length; i++) {
      providerData.listMatches[i].isVisible = true;
      answerWordArray.clear();
      flag = 0;
    }
  }

  void returnLetters(String element) {
    setState(() {
      for (int i = 0; i < shuffledWord.listMatches.length; i++) {
        if (element == shuffledWord.listMatches[i].targetLangWord &&
            shuffledWord.listMatches[i].isVisible == false) {
          shuffledWord.listMatches[i].isVisible = true;
          break;
        }
      }
      answerWordArray.remove(element);
    });
  }

  void addLetter(String element) {
    answerWordArray.add(element);
    setState(() {});
  }

  bool activateSubmitBtn() {
    if (answerWordArray.length != shuffledWord.listMatches.length) {
      return false;
    }
    return true;
  }

  void loadNextWord() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    providerData.cleanData();
    if (initialData.length >= 1) {
      initialData.removeLast();
      extractAndGetDataFromProvider();
    } else {
      initialData.clear();
    }
    answerWordArray.clear();
    setState(() {});
  }

  void giveUp() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    matches.split('').forEach((element) => answerWordArray.add(element));
    for (int i = 0; i < shuffledWord.listMatches.length; i++) {
      shuffledWord.listMatches[i].isVisible = false;
    }
    flag = 3;

    setState(() {});
  }

  List<Widget> buildAnswerContainer() {
    List<Widget> listWidget = [];
    for (int i = 0; i < answerWordArray.length; i++) {
      listWidget.add(Visibility(
        child: GestureDetector(
          onTap: flag == 3
              ? () {}
              : () {
                  setState(() {});
                  returnLetters(answerWordArray[i]);
                },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [kBoxShadow],
                color: setUpColor()),
            alignment: Alignment.center,
            width: 41,
            height: 42,
            child: Text(
              answerWordArray[i],
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ));
    }
    return listWidget;
  }

  List<Widget> buildTargetWordContainer() {
    List<Widget> listWidget = [];

    for (int i = 0; i < shuffledWord.listMatches.length; i++) {
      listWidget.add(Visibility(
        child: GestureDetector(
          onTap: () {
            setState(() {});
            addLetter(shuffledWord.listMatches[i].targetLangWord);
            shuffledWord.listMatches[i].toggleVisibility();
          },
          child: shuffledWord.listMatches[i].isVisible
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [kBoxShadow],
                      color: Colors.white),
                  alignment: Alignment.center,
                  width: 41,
                  // width: shuffledWordArray.listMatches.length < 27 ? 41 : 34.1,
                  height: 42,
                  child: Text(
                    shuffledWord.listMatches[i].targetLangWord,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : Container(width: 40, height: 40),
        ),
      ));
    }
    return listWidget;
  }

  void resetWords() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    for (int i = 0; i < providerData.listMatches.length; i++) {
      providerData.listMatches[i].isVisible = true;
      answerWordArray.clear();
      flag = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    final providerData = Provider.of<TrainingMatches>(context, listen: false);

    // Here we call Show Dialog
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: SafeArea(
            child: initialData.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // Card
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: defaultSize * 12,
                              vertical: defaultSize * 1.5),
                          height: SizeConfig.blockSizeVertical * 35,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          child: SlideTransition(
                            position: slideTransitionAnimation,
                            child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [kBoxShadow],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 4,
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                      top: defaultSize * 3.0,
                                      bottom: defaultSize * 15.0,
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: [kBoxShadow],
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      initialData.last.ownLang,
                                    ))),
                          ),
                        ),

                        // Answer
                        SingleChildScrollView(
                          child: Container(
                            height: defaultSize * 15,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: defaultSize * 20),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    runSpacing: 2,
                                    spacing: 2,
                                    direction: Axis.horizontal,
                                    children: buildAnswerContainer(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // TargetWord
                        Container(
                          height: defaultSize * 15,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxHeight: defaultSize * 20),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: 2,
                                  spacing: 2,
                                  direction: Axis.horizontal,
                                  children: buildTargetWordContainer(),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Button
                        AnimatedBuilder(
                          animation: shakeBtnAnimation,
                          builder: (context, child) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: shakeBtnAnimation.value + 20.0,
                                  right: 20.0 - shakeBtnAnimation.value),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                color: Theme.of(context).accentColor,
                                elevation: 5,
                                onPressed: flag == 3
                                    ? () {
                                        activateTryAgan();
                                      }
                                    : activateSubmitBtn()
                                        ? () {
                                            checkAnswer();
                                          }
                                        : () {
                                            providerData.runShakeAnimation(
                                                _shakeController);
                                          },
                                child: Text(flag == 3 ? 'Try Again' : 'Submit'),
                              ),
                            );
                          },
                        ),

                        // Help and Next btns
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultSize * 1.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: flag == 3
                                        ? () {}
                                        : () {
                                            giveUp();
                                          },
                                    child: Text('GIVE UP',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                GestureDetector(
                                    onTap: () {
                                      runSlideAnimation();
                                      flag = 0;
                                    },
                                    child: Text('NEXT',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                            )),
                      ],
                    ),
                  )
                : Center(child: Text('You run out of words'))),
      ),
    );
  }
}
