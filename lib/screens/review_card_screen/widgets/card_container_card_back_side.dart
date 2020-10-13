import 'package:flutter/material.dart';
import 'package:words_app/models/models.dart';

import 'widgets.dart';

class CardBackSide extends StatelessWidget {
  const CardBackSide({
    Key key,
    @required this.defaultSize,
    @required this.word,
  }) : super(key: key);

  final double defaultSize;
  final Word word;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TitleTextHolderContainer(
            defaultSize: defaultSize,
            wordHolder: word.ownLang == '' ? '...' : word.ownLang,
          ),
          TitleTextHolderContainer(
            defaultSize: defaultSize,
            wordHolder: word.secondLang == '' ? '...' : word.secondLang,
          ),
          TitleTextHolderContainer(
            defaultSize: defaultSize,
            wordHolder: word.thirdLang == '' ? '...' : word.thirdLang,
          )
        ],
      ),
    );
  }
}
