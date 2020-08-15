import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/reusable_card.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/game_card_data.dart';
import 'package:words_app/providers/pair_game_card_provider.dart';
import 'package:words_app/screens/pair_game_screen/pair_game_engine.dart';

import 'game_card.dart';

GameEngine gameEngine;

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required this.defaultSize,
    @required this.blockSizeVertical,
    @required this.blockSizeHorizontal,
  }) : super(key: key);

  final double defaultSize;
  final double blockSizeVertical;
  final double blockSizeHorizontal;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<MyCard> cards = [];

//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    Provider.of<GameCards>(context, listen: false).getNumberOfCards();
//  }

  @override
  Widget build(BuildContext context) {
    var pairGameList =
        Provider.of<GameCards>(context, listen: false).pairGameList;
    List<MyCard> myCards = Provider.of<GameCards>(context).cards;
//    Provider.of<GameCards>(context, listen: false).getNumberOfCards();
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
                children: List<CustomChip>.generate(
                  myCards.length,
                  (index) => CustomChip(
                    id: myCards[index].id,
                    color: myCards[index].color,
                    word: myCards[index].word,
                    onTap: () {
                      Provider.of<GameCards>(context, listen: false)
                          .toggleCard(index);
                    },
                    isToggled: myCards[index].isToggled,
                  ),
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
                  FlatButton(
                    color: Colors.pink,
                    child: Text('GET WORDS'),
                    onPressed: () {
                      Provider.of<GameCards>(context, listen: false).getCards();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String id;
  final String word;
  final bool isToggled;
  final double fontSize;
  final Function onTap;
  final Color color;
  final Color shadowColor;
  const CustomChip(
      {this.id,
      this.word,
      this.fontSize,
      this.onTap,
      this.color,
      this.isToggled,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        padding: EdgeInsets.all(10),
        label: Text(
          word,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        backgroundColor: color,
        elevation: 5,
        shadowColor: isToggled ? shadowColor : Colors.black,
      ),
    );
  }
}
