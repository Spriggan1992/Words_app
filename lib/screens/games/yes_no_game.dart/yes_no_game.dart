import 'package:flutter/material.dart';

import 'package:words_app/utils/size_config.dart';
import 'package:words_app/widgets/base_appbar.dart';

import 'package:words_app/constants/constants.dart';
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
  List<Word> targetWords;
  List<Word> ownLanguageWords;
  bool isCorrect = false;
  bool isWrong = false;
  int correct = 0;
  int wrong = 0;

  @override
  void initState() {
    super.initState();
    createData();

    _correctController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _wrongController = AnimationController(
      duration: Duration(milliseconds: 500),
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

  void toggleAnswerCorrect() {
    setState(() {
      isCorrect = true;
      isWrong = false;
      correct++;
      _correctController.forward();
    });
  }

  void toggleAnswerWrong() {
    setState(() {
      isCorrect = false;
      isWrong = true;
      wrong++;
      _wrongController.forward();
    });
  }

  void getData(List data) {}

  void createData() {
    targetWords = [...widget.words];
    targetWords.shuffle();
    ownLanguageWords = [...widget.words];
    ownLanguageWords.shuffle();
  }

  void removeTWords(value) {
    setState(() {
      targetWords.remove(value);
      ownLanguageWords.removeLast();
      if (ownLanguageWords.length < 1) {
        ownLanguageWords.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('YES/NO'),
        appBar: AppBar(),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
                child: targetWords.length > 0
                    ? Stack(
                        alignment: Alignment.center,
                        children: deck(
                            targetWords,
                            removeTWords,
                            ownLanguageWords,
                            toggleAnswerCorrect,
                            toggleAnswerWrong,
                            defaultSize))
                    : Text('fdskjajfds')),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: matchWords(ownLanguageWords, defaultSize),
              ),
            ),
            YesNoBtns(
              title: 'YES',
              top: defaultSize * 42,
              left: defaultSize * 32,
              icon: Icons.redo,
              animationController: _correctAnimation,
            ),
            YesNoBtns(
              title: 'NO',
              top: defaultSize * 42,
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
                          title: [wrong, ' : ', correct][index].toString(),
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
  }
}

List matchWords(List<Word> words, double defaultSize) {
  var matches = words.map(
    (item) {
      return Positioned(
        top: defaultSize * 35.0,
        child: Card(
          elevation: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultSize * 0.5),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            height: defaultSize * 4.0,
            width: defaultSize * 25.0,
            child: YesNoTextHolder(title: item.ownLang),
          ),
        ),
      );
    },
  ).toList();
  return matches;
}

List<Widget> deck(
  List<Word> targetWords,
  Function removieItem,
  List<Word> ownLanguageWords,
  Function toogleAnswerCorrect,
  Function toogleAnswerWrong,
  double defaultSize,
) {
  List<Widget> cardList = List();
  int count = 0;
  double padding = 40.0;
  for (int i = 0; i < targetWords.length; i++) {
    if (count >= 1) {
      padding += 1;
    } else if (count >= 2) {
      padding += 3;
    } else if (count >= 4) {
      padding += 1;
    } else {
      padding += 0.4;
    }
    cardList.add(
      Positioned(
        top: padding,
        child: Dismissible(
          onDismissed: (DismissDirection derection) {
            if (derection == DismissDirection.startToEnd) {
              if (targetWords.last.id == ownLanguageWords.last.id) {
                toogleAnswerCorrect();
              } else {
                toogleAnswerWrong();
              }
              removieItem(targetWords[i]);
            }
            if (derection == DismissDirection.endToStart) {
              if (targetWords.last.id == ownLanguageWords.last.id) {
                toogleAnswerWrong();
              } else {
                toogleAnswerCorrect();
              }
              removieItem(targetWords[i]);
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
                    child: YesNoTextHolder(title: targetWords[i].targetLang),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    count++;
  }

  return cardList;
}
