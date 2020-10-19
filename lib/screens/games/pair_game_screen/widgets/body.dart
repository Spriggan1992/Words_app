import 'package:flutter/material.dart';
import 'package:words_app/config/constants.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/game_card.dart';
import 'package:words_app/screens/screens.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required this.defaultSize,
    @required this.blockSizeVertical,
    @required this.blockSizeHorizontal,
    // here we receive a copy of card with 2 language in it
    @required this.pairGameList,
  }) : super(key: key);

  final double defaultSize;
  final double blockSizeVertical;
  final double blockSizeHorizontal;
  final List<GameCard> pairGameList;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> animateColor;
  Animation<Opacity> animateOpacity;
  List<MyCard> cards = [];
  List<MyCard> chosenPair = [];
  int toggleCount = 0;
  bool pairIsCorrect = true;
  // allDone controls when to switch to nex bunch of cards
  int allDone = 0;
  int all = 0;
  int mistakes = 0;
  int allPairs;

  /// method populate [cards] with 4 card pairs or size can be changed
  /// it draws cards from [widget.pairGameList]
  void getCards() {
    GameCard gameCard;
    cards = [];
    for (int i = 0; i <= 4; i++) {
      try {
        gameCard = getOneCard(0);
        cards.add(MyCard(id: gameCard.id, word: gameCard.targetLang));
        cards.add(MyCard(id: gameCard.id, word: gameCard.ownLang));
      } catch (e) {
        print(e);
      }
    }
  }

  ///method removes item at given index from [_pairGameList] and return one GameCard
  GameCard getOneCard(int index) {
    GameCard gameCard = widget.pairGameList.removeAt(index);
    return gameCard;
  }

  void toggleCard(int index) {
    if (!cards[index].isToggled && cards[index].visible) {
      cards[index].toggleMyCard();
      cards[index].color = Colors.grey;
      chosenPair.add(cards[index]);

      if (chosenPair.length == 2) {
        if (chosenPair[0].id == chosenPair[1].id &&
            chosenPair[0].word != chosenPair[1].word) {
          chosenPair[0].color = Colors.green;
          chosenPair[1].color = Colors.green;
          chosenPair[0].toggleVisibility();
          chosenPair[1].toggleVisibility();
          chosenPair = [];
          allDone = allDone + 2;
          all = all + 1;
        } else {
          chosenPair[0].isWrong = true;
          chosenPair[1].isWrong = true;

          //to start animation, and always start it from 0.0 otherwise it crashes.
          _controller.forward(from: 0.0);
        }
      }
    } else {
      cards[index].toggleMyCard();
      cards[index].color = Colors.grey[200];
      chosenPair.remove(cards[index]);
    }

    if (cards.length == allDone) {
      getCards();
      allDone = 0;
    }
    goToResultScreen(
        cards, context, ResultScreen(correct: all, wrong: mistakes));
  }

  /// method resetCardsToggles fires right after animation finishes to clear cards of all toggles
  /// to reset them also it rises counter of mistakes
  void resetCardsToggles() {
    chosenPair[0].isWrong = false;
    chosenPair[1].isWrong = false;
    chosenPair[0].toggleMyCard();
    chosenPair[1].toggleMyCard();
    chosenPair[0].color = Colors.grey[200];
    chosenPair[1].color = Colors.grey[200];
    mistakes += 1;
    chosenPair = [];
  }

  @override
  void initState() {
    super.initState();
    allPairs = widget.pairGameList.length;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    animateColor = ColorTween(begin: Colors.redAccent, end: Colors.grey[200])
        .animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    //addStatusListener  check when animation is stopped, after that we execute
    //second part of code
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        resetCardsToggles();
      }
    });
    getCards();
    cards.shuffle();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          false ??
          showCustomDialog(
            context: context,
            title: 'Are you sure?',
            content: 'Do you want to delete this word?',
            function: () {
              Navigator.pushNamedAndRemoveUntil(context, TrainingManager.id,
                  ModalRoute.withName(TrainingManager.id));
            },
          ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.defaultSize * 1.6,
          vertical: widget.defaultSize,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: widget.blockSizeHorizontal * 95,
              height: widget.blockSizeVertical * 56,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Wrap(
                  spacing: widget.defaultSize * 1.5,
                  runSpacing: widget.defaultSize,
                  verticalDirection: VerticalDirection.down,
                  alignment: WrapAlignment.center,
                  children: List<Widget>.generate(
                    cards.length,
                    (index) {
                      return AnimatedOpacity(
                        opacity: cards[index].visible ? 1 : 0,
                        duration: Duration(milliseconds: 400),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              toggleCard(index);
                            });
                          },
                          child: Chip(
                            padding: EdgeInsets.all(10),
                            label: Text(
                              cards[index].word,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                            backgroundColor: cards[index].isWrong == true
                                ? animateColor.value
                                : cards[index].color,
                            elevation: 5,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: widget.defaultSize * 2,
            ),
            Expanded(
              child: Container(
                decoration: innerShadow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'All: $all / $allPairs',
                      style: TextStyle(fontSize: widget.defaultSize * 3.2),
                    ),
                    Text(
                      'Wrong: $mistakes',
                      style: TextStyle(fontSize: widget.defaultSize * 3.2),
                    ),
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
