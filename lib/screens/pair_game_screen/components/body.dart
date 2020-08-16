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
    this.pairGameList,
  }) : super(key: key);

  final double defaultSize;
  final double blockSizeVertical;
  final double blockSizeHorizontal;
  final List<GameCard> pairGameList;

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
    List<MyCard> cards = [];
    int toggleCount = 0;
    List<MyCard> chosenPair = [];
    int allDone = 0;

    List<MyCard> myCards = Provider.of<GameCards>(context).cards;
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
