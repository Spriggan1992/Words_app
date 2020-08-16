import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/game_card_data.dart';

import 'package:words_app/providers/pair_game_card_provider.dart';

import 'custom_chip.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required this.defaultSize,
    @required this.blockSizeVertical,
    @required this.blockSizeHorizontal,
    // here we receive a copy of card with 2 language in it
    this.pairGameList,
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
  Animation<Color> animation;
  List<MyCard> cards = [];
  List<MyCard> chosenPair = [];
  int toggleCount = 0;

  int allDone = 0;

  /// method populate [cards] with 4 card pairs or size can be changed
  void getCards() {
    GameCard gameCard;
//    toggleCount = 0;
    cards = [];
    for (int i = 0; i <= 3; i++) {
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
    chosenPair.add(cards[index]);
    cards[index].toggleMyCard();
    cards[index].color = Colors.grey;
    if (chosenPair.length == 2) {
      if (chosenPair[0].id == chosenPair[1].id &&
          chosenPair[0].word != chosenPair[1].word) {
//        print(chosenPair[0].word != chosenPair[1].word);
        chosenPair[0].color = Colors.green;
        chosenPair[1].color = Colors.green;
        chosenPair[0].toggleVisibility();
        chosenPair[1].toggleVisibility();

        chosenPair = [];
        allDone = allDone + 2;
      } else {
//        print("before 0: ${chosenPair[0].isWrong}");
        chosenPair[0].isWrong = true;
        chosenPair[1].isWrong = true;
        _controller.forward();
//        print("before 0: ${chosenPair[0].isToggled}");
//        print("before 1:${chosenPair[1].isToggled}");
//        chosenPair[0].toggleMyCard();
//        chosenPair[1].toggleMyCard();
//        print("AFTER 0: ${chosenPair[0].isToggled}");
//        print("AFTER 1:${chosenPair[1].isToggled}");
        chosenPair = [];
      }
    }
    if (cards.length == allDone) {
      getCards();
      allDone = 0;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(
      begin: Colors.redAccent,
      end: Colors.grey[200],
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    getCards();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//
    return Padding(
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
//                    children: [
//                      CustomChip(
//                        id: '1',
//                        label: providerData.cards[0].word,
//                      )
//                    ],
                children: List<Widget>.generate(
                  cards.length,
                  (index) {
                    return AnimatedOpacity(
                      opacity: cards[index].visible ? 1 : 0,
                      duration: Duration(seconds: 1),
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
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          backgroundColor: cards[index].isWrong != null
                              ? animation.value
                              : cards[index].color,
                          elevation: 5,
//                          shadowColor: Colors.black,
                        ),
                      ),
                    );

//                    return CustomChip(
//                      id: cards[index].id,
//                      color: cards[index].color,
//                      word: cards[index].word,
//                      visible: cards[index].visible,
//                      onTap: () {
//                        setState(() {
//                          toggleCard(index);
//                        });
//                      },
//                      isToggled: cards[index].isToggled,
//                    );
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'All: 8',
                    style: TextStyle(fontSize: widget.defaultSize * 2.4),
                  ),
                  Text(
                    'Correct: 8',
                    style: TextStyle(fontSize: widget.defaultSize * 2.4),
                  ),
                  Text(
                    'Wrong: 8',
                    style: TextStyle(fontSize: widget.defaultSize * 2.4),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
