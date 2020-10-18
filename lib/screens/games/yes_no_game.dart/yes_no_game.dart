import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/screenDefiner.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/screens/screens.dart';

import 'package:words_app/config/size_config.dart';
import 'package:words_app/widgets/base_appbar.dart';

import 'package:words_app/config/constants.dart';
import 'package:words_app/models/word.dart';

import 'widgets/yes_no_btns.dart';
import 'widgets/yes_no_text_holder.dart';

class YesNoGame extends StatefulWidget {
  static String id = 'training_screen';
  YesNoGame({this.words});

  final List<Word> words;

  @override
  _YesNoGameState createState() => _YesNoGameState();
}

class _YesNoGameState extends State<YesNoGame> with TickerProviderStateMixin {
  AnimationController _correctController;
  AnimationController _wrongController;
  Animation<Color> _correctAnimation;
  Animation<Color> _wrongAnimation;
  List<Word> _targetWords;
  List<Word> _ownLanguageWords;

  int correct = 0;
  int wrong = 0;

  @override
  void initState() {
    super.initState();

    // createData();

    _correctController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _wrongController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _correctAnimation = ColorTween(begin: Colors.black, end: Colors.green)
        .animate(_correctController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _correctController.reverse();
            }
          });
    _wrongAnimation = ColorTween(begin: Colors.black, end: Colors.red)
        .animate(_wrongController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _wrongController.reverse();
            }
          });
  }

  @override
  void dispose() {
    _correctController.dispose();
    _wrongController.dispose();
    super.dispose();
  }

  void createData() {
    _targetWords = [...widget.words];
    _targetWords.shuffle();
    _ownLanguageWords = [...widget.words];
    _ownLanguageWords.shuffle();
  }

  void toggleAnswerCorrect() {
    setState(() {
      correct++;
      _correctController.forward();
    });
  }

  void toggleAnswerWrong() {
    setState(() {
      wrong++;
      _wrongController.forward();
    });
  }

  void removeTWords(value) {
    setState(() {
      _targetWords.remove(value);
      _ownLanguageWords.removeLast();
      if (_ownLanguageWords.length < 1) {
        _ownLanguageWords.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return WillPopScope(
        onWillPop: () async => onBackPressed(
              context,
              () {
                setState(() {
                  Navigator.pushNamedAndRemoveUntil(context, TrainingManager.id,
                      ModalRoute.withName(TrainingManager.id));
                });
              },
            ),
        child: BlocBuilder<YesNoGameBloc, YesNoGameState>(
          builder: (context, state) {
            if (state is YesNoGameLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is YesNoGameSuccess) {
              return Scaffold(
                appBar: BaseAppBar(
                  screenDefiner: ScreenDefiner.trainings,
                  title: Text('YES/NO'),
                  appBar: AppBar(),
                ),
                body: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                          // child: targetWords.length > 0
                          // ?
                          child: Stack(
                              alignment: Alignment.center,
                              children: deck(
                                _correctController,
                                _wrongController,
                                state,
                                context,
                                _targetWords,
                                removeTWords,
                                _ownLanguageWords,
                                toggleAnswerCorrect,
                                toggleAnswerWrong,
                                defaultSize,
                                correct,
                                wrong,
                              ))),
                      // : Text('Hey there')),
                      Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children:
                              matchWords(state, _ownLanguageWords, defaultSize),
                        ),
                      ),
                      YesNoBtns(
                        title: 'YES',
                        top: SizeConfig.blockSizeVertical * 60,
                        left: defaultSize * 32,
                        icon: Icons.redo,
                        animationController: _correctAnimation,
                      ),
                      YesNoBtns(
                        title: 'NO',
                        top: SizeConfig.blockSizeVertical * 60,
                        left: defaultSize * 6,
                        icon: Icons.undo,
                        animationController: _wrongAnimation,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: defaultSize * 2),
                          height: defaultSize * 7,
                          width: SizeConfig.blockSizeHorizontal * 90,
                          decoration: innerShadow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(3, (index) {
                                return YesNoTextHolder(
                                    title: [wrong, ' : ', correct][index]
                                        .toString(),
                                    fontSize: defaultSize * 3,
                                    color: [
                                      Theme.of(context).accentColor,
                                      Colors.black,
                                      Colors.green
                                    ][index]);
                              }),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else
              return Text('Somthing went wrong...');
          },
        ));
  }
}

List matchWords(YesNoGameSuccess state, List<Word> words, double defaultSize) {
  var matches = state.ownLang.map(
    (item) {
      // print('ownLang: ${item.id} + ${item.ownLang}');
      return Positioned(
        top: SizeConfig.blockSizeVertical * 47,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.1,
                  offset: Offset(1.5, 1.5),
                  color: Colors.grey,
                  spreadRadius: 0.1)
            ],
            borderRadius: BorderRadius.circular(defaultSize * 0.5),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          height: defaultSize * 4.0,
          width: defaultSize * 25.0,
          child: YesNoTextHolder(title: item.ownLang),
        ),
      );
    },
  ).toList();

  return matches;
}

List<Widget> deck(
  AnimationController correctController,
  AnimationController wrongController,
  YesNoGameSuccess state,
  BuildContext context,
  List<Word> targetWords,
  Function removieItem,
  List<Word> ownLanguageWords,
  Function toogleAnswerCorrect,
  Function toogleAnswerWrong,
  double defaultSize,
  int correct,
  int wrong,
) {
  List<Widget> cardList = List();
  double topPadding = SizeConfig.blockSizeVertical * 10;
  double leftPadding = defaultSize * 10.5;

  for (int i = 0;
      i < (state.targetLang.length < 4 ? state.targetLang.length : 4);
      i++) {
    topPadding -= defaultSize * 0.35;
    leftPadding += defaultSize * 0.25;
    // print('targetLang: ${targetWords[i].targetLang}');

    cardList.insert(
      0,
      Positioned(
        top: topPadding,
        left: leftPadding,
        child: Dismissible(
          direction: i == 0 ? DismissDirection.horizontal : null,
          onDismissed: (DismissDirection derection) {
            if (derection == DismissDirection.startToEnd) {
              if (state.targetLang.first.id == state.targetLang.last.id) {
                context.bloc<YesNoGameBloc>().add(YesNoGameAnswerCorrect());
                // correctController.forward();
                // toogleAnswerCorrect();
              } else {
                context.bloc<YesNoGameBloc>().add(YesNoGameAnswerWrong());
                // wrongController.forward();
                // toogleAnswerWrong();
              }
              context
                  .bloc<YesNoGameBloc>()
                  .add(YesNoGameDeleteWords(word: targetWords[i]));
              // removieItem(targetWords[i]);
              goToResultScreen(targetWords, context,
                  ResultScreen(correct: correct, wrong: wrong));
            }
            if (derection == DismissDirection.endToStart) {
              if (targetWords.first.id == ownLanguageWords.last.id) {
                context.bloc<YesNoGameBloc>().add(YesNoGameAnswerWrong());
                // wrongController.forward();
                // toogleAnswerWrong();
              } else {
                // toogleAnswerCorrect();
                context.bloc<YesNoGameBloc>().add(YesNoGameAnswerCorrect());
                // correctController.forward();
              }
              context
                  .bloc<YesNoGameBloc>()
                  .add(YesNoGameDeleteWords(word: targetWords[i]));
              // removieItem(targetWords[i]);
              goToResultScreen(targetWords, context,
                  ResultScreen(correct: correct, wrong: wrong));
            }
          },
          key: UniqueKey(),
          child: Card(
            elevation: 3,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultSize * 0.5),
                    color: Colors.white,
                  ),
                  width: defaultSize * 20,
                  height: defaultSize * 25,
                ),
                Positioned(
                  top: defaultSize * 4,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [kBoxShadow],
                      borderRadius: BorderRadius.circular(defaultSize * 0.5),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    width: defaultSize * 16,
                    height: defaultSize * 3,
                    child:
                        YesNoTextHolder(title: state.targetLang[i].targetLang),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  return cardList;
}
