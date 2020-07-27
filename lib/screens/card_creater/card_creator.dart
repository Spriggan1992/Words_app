import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import './components/card_creator_front.dart';
import './components/card_creator_back.dart';

class CardCreator extends StatefulWidget {
  static const id = 'card_creator';
  @override
  _CardCreatorState createState() => _CardCreatorState();
}

class _CardCreatorState extends State<CardCreator> {
  //Global key for Flip card
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('Create your word card'),
        appBar: AppBar(),
        actions: [
          InkWell(
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          SizedBox(
            width: 10,
          ),
//   dismiss button poping the context back to list of words
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          )
        ],
      ),
      body: FlipCard(
        //Card key  is used to pass the toggle card method into card
        key: cardKey,
        flipOnTouch: false,
        direction: FlipDirection.HORIZONTAL,
        speed: 500,
        onFlipDone: (status) {
          print(status);
        },
        front: CardCreatorFront(() => cardKey.currentState.toggleCard()),
        back: CardCreatorBack(() => cardKey.currentState.toggleCard()),
      ),
    );
  }
}
