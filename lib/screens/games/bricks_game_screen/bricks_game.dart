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

  // List<Word> initialData;
  // var shuffledWord;
  // List<String> answerWordArray = [];
  // String matches;
  // int flag = 0;
  // bool isCheckSlideTransition = true;
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
    loadData();
    // getDataFromProvider();
    // extractAndGetDataFromProvider();

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

  void loadData() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    providerData.getDataFromProvider(widget.words);
    providerData.extractAndGetDataFromProvider();
  }

  Future<bool> onBackPressed() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
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
                  providerData.initialData.clear();
                  providerData.cleanData();
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  List<Widget> buildAnswerContainer() {
    final providerData = Provider.of<TrainingMatches>(context, listen: false);
    List<Widget> listWidget = [];
    for (int i = 0; i < providerData.answerWordArray.length; i++) {
      listWidget.add(Visibility(
        child: GestureDetector(
          onTap: providerData.flag == 3
              ? () {}
              : () {
                  setState(() {
                    providerData.returnLetters(providerData.answerWordArray[i]);
                  });
                },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [kBoxShadow],
                color: providerData.setUpColor(
                    successColorAnimation, errorColorAnimation)),
            alignment: Alignment.center,
            width: 41,
            height: 42,
            child: Text(
              providerData.answerWordArray[i],
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
    final providerData = Provider.of<TrainingMatches>(context, listen: false);

    for (int i = 0; i < providerData.listMatches.length; i++) {
      listWidget.add(Visibility(
        child: GestureDetector(
          onTap: () {
            setState(() {
              providerData
                  .addLetter(providerData.listMatches[i].targetLangWord);
              providerData.listMatches[i].toggleVisibility();
            });
          },
          child: providerData.listMatches[i].isVisible
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
                    providerData.listMatches[i].targetLangWord,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : Container(width: 40, height: 40),
        ),
      ));
    }
    return listWidget;
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
            child: providerData.initialData.isNotEmpty
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
                                      providerData.initialData.last.ownLang,
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
                                onPressed: providerData.flag == 3
                                    ? () {
                                        setState(() {
                                          providerData.activateTryAgan();
                                        });
                                      }
                                    : providerData.activateSubmitBtn()
                                        ? () {
                                            setState(() {
                                              providerData.checkAnswer(
                                                  _successAnimationController,
                                                  _errorAnimationController,
                                                  _slideTransitionController,
                                                  providerData.initialData);
                                            });
                                          }
                                        : () {
                                            setState(() {
                                              providerData.runShakeAnimation(
                                                  _shakeController);
                                            });
                                          },
                                child: Text(providerData.flag == 3
                                    ? 'Try Again'
                                    : 'Submit'),
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
                                    onTap: providerData.flag == 3
                                        ? () {}
                                        : () {
                                            setState(() {
                                              providerData.giveUp();
                                            });
                                          },
                                    child: Text('GIVE UP',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      providerData.runSlideAnimation(
                                          _slideTransitionController);
                                      providerData.flag = 0;
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
