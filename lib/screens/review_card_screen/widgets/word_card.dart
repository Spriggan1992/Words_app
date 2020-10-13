import 'package:flutter/material.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/config/size_config.dart';

import 'widgets.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    Key key,
    this.word,
    this.index,
    this.part,
    this.side,
    this.active,
  }) : super(key: key);

  final int index;
  final Color part;
  final String side;
  final Word word;
  final bool active;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    return AnimatedContainer(
      height: 400,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutQuint,
      padding: EdgeInsets.only(
        right: defaultSize * 3,
        left: defaultSize * 3,
        top: active
            ? SizeConfig.blockSizeVertical * 2
            : SizeConfig.blockSizeVertical * 7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CardContainer(part: part, side: side, word: word),
          ExampleField(active: active, side: side, word: word),
        ],
      ),
    );
  }
}
