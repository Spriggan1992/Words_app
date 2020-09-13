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
    initialData = [...widget.words]..shuffle();
    // initialData = [...widget.dataWord];
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
                borderRadius: BorderRadius.circular(5),
                boxShadow: [kBoxShadow],
                color: Colors.white),
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
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [kBoxShadow],
                      color: Colors.white),
                  alignment: Alignment.center,
                  width: 41,
                  // width: shuffledWordArray.listMatches.length < 27 ? 41 : 34.1,
                  height: 42,
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
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;

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

                        // Container(
                        //   color: Colors.white,
                        //   padding: EdgeInsets.symmetric(vertical: 10),
                        //   width: SizeConfig.blockSizeHorizontal * 100,
                        //   height: SizeConfig.blockSizeVertical * 40,
                        //   child: SlideTransition(
                        //     position: slideTransitionAnimation,
                        //     child: Container(
                        //       margin: EdgeInsets.symmetric(
                        //           horizontal: defaultSize * 11),
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           boxShadow: [kBoxShadow],
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(5),
                        //         ),
                        //         child: Container(
                        //             alignment: Alignment.center,
                        //             decoration: BoxDecoration(
                        //               boxShadow: [kBoxShadow],
                        //               color: Colors.white,
                        //               borderRadius: BorderRadius.circular(5),
                        //             ),
                        //             margin: EdgeInsets.only(
                        //               right: SizeConfig.blockSizeHorizontal * 5,
                        //               left: SizeConfig.blockSizeHorizontal * 5,
                        //               top: defaultSize * 3.0,
                        //               bottom: defaultSize * 18.0,
                        //             ),
                        //             child: Text(initialData.last.ownLang)),
                        //       ),
                        //     ),
                        //   ),
                        // ),
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

                        AnimatedBuilder(
                          animation: shakeBtnAnimation,
                          builder: (context, child) {
                            return RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Theme.of(context).accentColor,
                              elevation: 5,
                              onPressed: activateSubmitBtn()
                                  ? () {
                                      checkAnswer();
                                    }
                                  : () {
                                      runShakeAnimation();
                                    },
                              child: Text('Submit'),
                            );
                          },
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                // vertical: defaultSize * 3,
                                horizontal: defaultSize * 1.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('HELP'),
                                GestureDetector(
                                    onTap: () {
                                      runSlideAnimation();
                                    },
                                    child: Text('NEXT')),
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
