import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';

import 'widgets.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    Key key,
    @required this.part,
    @required this.side,
    @required this.word,
  }) : super(key: key);

  final Color part;
  final String side;
  final Word word;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      height: SizeConfig.blockSizeVertical * 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(defaultSize * 1),
        color: Colors.white,
        boxShadow: [kBoxShadow],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                SpeechPart(defaultSize: defaultSize, part: part),
                side == 'front'
                    ? CardFrontSide(defaultSize: defaultSize, word: word)
                    : CardBackSide(defaultSize: defaultSize, word: word)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
