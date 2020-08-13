import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/training_matches_provider.dart';
import 'package:words_app/providers/word_data.dart';

class Matches extends StatefulWidget {
  static String id = 'matches_screen';

  Matches({this.dataWord});
  final List<Word> dataWord;

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> with TickerProviderStateMixin {
  AnimationController errorAnimationController;
  AnimationController shakeController;
  AnimationController slideTransitionController;

  Animation<double> shakeBtnAnimation;
  Animation errorColorAnimation;
  Animation slideTransitionAnimation;

  List<Word> initialData;
  var shuffledWordArray;
  List answerWordArray = [];
  var matches;
  int flag = 0;
  bool disableAnswersWordArray = false;
  bool isCheckSlideTransition = true;
  // bool waitingAnimation = false;

  @override
  void initState() {
    super.initState();
    getDataFromProvider();
    extractAndGetDataFromProvider();

    errorAnimationController = AnimationController(
      duration: Duration(milliseconds: 130),
      vsync: this,
    );
    errorColorAnimation =
        ColorTween(begin: Colors.lightBlueAccent, end: Colors.red)
            .animate(errorAnimationController);
    errorAnimationController.addListener(() {
      setState(() {});
    });

    shakeController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);

    shakeBtnAnimation = Tween(begin: 0.0, end: 20.0)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(shakeController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              shakeController.reverse();
            }
          });
    slideTransitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    slideTransitionAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(2.0, 0.0))
            .animate(slideTransitionController)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  slideTransitionController.reverse();
                }
              });
  }

  @override
  void dispose() {
    errorAnimationController.dispose();
    shakeController.dispose();
    slideTransitionController.dispose();
    super.dispose();
  }

  void runSlideAnimation() {
    slideTransitionController.forward();
    Timer(Duration(milliseconds: 100), () {
      loadNextWord();
    });
    setState(() {});
  }

  void runShakeAnimation() {
    shakeController.forward(from: 0.0);

    setState(() {});
  }

  void runAnimation() {
    TickerFuture tickerFuture = errorAnimationController.repeat();
    tickerFuture.timeout(Duration(milliseconds: 300), onTimeout: () {
      errorAnimationController.forward(from: 0);
      errorAnimationController.stop(canceled: true);
    });
    setState(() {});
  }

  void getDataFromProvider() {
    initialData = [...widget.dataWord];
  }

  void extractAndGetDataFromProvider() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    if (initialData.length >= 1) {
      // Add last word in targetLangWord;
      String targetLangWord;
      for (int i = 0; i < initialData.length; i++) {
        targetLangWord = initialData[i].targetLang;
        matches = targetLangWord.toLowerCase();
      }
      List<String> targetSplitted = targetLangWord.toLowerCase().split('');
      // Check if providerData.listMatches empty or not. If it empty-> add new word, else dont add it.
      if (providerData.listMatches.isEmpty) {
        targetSplitted.forEach((item) {
          providerData.addWord(item, true);
        });
      }

      shuffledWordArray = providerData;
      shuffledWordArray.listMatches.shuffle();
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
      return Colors.green;
    }
    if (flag == 2) {
      return errorColorAnimation.value;
    } else {
      return Colors.lightBlueAccent;
    }
  }

  void checkAnswer() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    String a = answerWordArray.join('');
    String b = matches;
    if (b.startsWith(a) == true) {
      flag = 1;
      runSlideAnimation();

      flag = 0;
    } else {
      flag = 2;
      runAnimation();
      errorAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
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

  void returnLetters(String element) {
    for (int i = 0; i < shuffledWordArray.listMatches.length; i++) {
      if (element == shuffledWordArray.listMatches[i].targetLangWord &&
          shuffledWordArray.listMatches[i].isVisible == false) {
        shuffledWordArray.listMatches[i].isVisible = true;
        break;
      }
      setState(() {});
    }
    answerWordArray.remove(element);
    setState(() {});
  }

  void addLetter(String element) {
    answerWordArray.add(element);
    setState(() {});
  }

  bool activateSubmitBtn() {
    if (answerWordArray.length != shuffledWordArray.listMatches.length) {
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

  List<Widget> buildAnswerContainer() {
    List<Widget> listWidget = [];
    for (int i = 0; i < answerWordArray.length; i++) {
      listWidget.add(Visibility(
        child: GestureDetector(
          onTap: !disableAnswersWordArray
              ? () {
                  setState(() {});
                  returnLetters(answerWordArray[i]);
                }
              : () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: setUpColor(),
            ),
            alignment: Alignment.center,
            width: 40,
            height: 40,
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

    for (int i = 0; i < shuffledWordArray.listMatches.length; i++) {
      listWidget.add(Visibility(
        child: GestureDetector(
          onTap: () {
            setState(() {});
            addLetter(shuffledWordArray.listMatches[i].targetLangWord);
            shuffledWordArray.listMatches[i].toggleVisibility();
          },
          child: shuffledWordArray.listMatches[i].isVisible
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.lightBlueAccent),
                  alignment: Alignment.center,
                  width: 45,
                  height: 45,
                  child: Text(
                    shuffledWordArray.listMatches[i].targetLangWord,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    // Here we call Show Dialog
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          runSlideAnimation();
        }),
        body: SafeArea(
            child: initialData.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SlideTransition(
                        position: slideTransitionAnimation,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.white,
                              width: 200,
                              height: 300,
                              child: Text(initialData.last.ownLang),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: screenWidth, maxHeight: screenHeight),
                          child: Wrap(
                            runSpacing: 2,
                            spacing: 2,
                            direction: Axis.horizontal,
                            children: buildAnswerContainer(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: screenWidth, maxHeight: screenHeight),
                          child: Wrap(
                            runSpacing: 2,
                            spacing: 2,
                            direction: Axis.horizontal,
                            children: buildTargetWordContainer(),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: shakeBtnAnimation,
                        builder: (context, child) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: shakeBtnAnimation.value + 20.0,
                                right: 20.0 - shakeBtnAnimation.value),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: Alignment.center,
                              width: 100,
                              height: 40,
                              color: Colors.grey[400],
                              child: FlatButton(
                                onPressed: activateSubmitBtn()
                                    ? () {
                                        checkAnswer();
                                      }
                                    : () {
                                        runShakeAnimation();
                                      },
                                child: Text('Submit'),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
                : Center(child: Text('You run out of words'))),
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.width;
//     // Here we call Show Dialog
//     return WillPopScope(
//       onWillPop: onBackPressed,
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(onPressed: () {
//           runAnimation();
//         }),
//         body: SafeArea(
//             child: initialData.isNotEmpty
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Expanded(
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 30.0),
//                             child: Container(
//                               alignment: Alignment.center,
//                               color: Colors.white,
//                               width: 200,
//                               height: 300,
//                               child: Text(initialData.last.ownLang),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                           child: Container(
//                         child: buildSliverGridAnswerContainer(),
//                       )),
//                       Flexible(
//                         child: Wrap(
//                           direction: Axis.vertical,
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: screenWidth,
//                                 height: 800,
//                                 child: buildSliverGridShuffeldContainer(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Flexible(
//                         child: FlatButton(
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: 100,
//                               height: 40,
//                               color: Colors.grey[400],
//                               child: Text('Submit'),
//                             ),
//                             onPressed: activateSubmitBtn()
//                                 ? () {
//                                     checkAnswer();
//                                     if (flag == 2) {
//                                       print('2');
//                                     } else if (flag == 1) {
//                                       loadNextWord();
//                                       flag = 0;
//                                     }
//                                   }
//                                 : () {}),
//                       )
//                     ],
//                   )
//                 : Center(child: Text('You run out of words'))),
//       ),
//     );
//   }
// }
