import 'package:flutter/material.dart';
import 'package:words_app/models/models.dart';

import 'widgets.dart';

class CardFrontSide extends StatelessWidget {
  const CardFrontSide({
    Key key,
    @required this.defaultSize,
    @required this.word,
  }) : super(key: key);

  final double defaultSize;
  final Word word;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: defaultSize * 3,
        ),
        TitleTextHolderContainer(
          defaultSize: defaultSize,
          wordHolder: word.targetLang == '' ? '...' : word.targetLang,
        ),
        SizedBox(height: defaultSize * 2),
        Flexible(
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(bottom: defaultSize * 1),
            width: defaultSize * 19,
            height: defaultSize * 19,
            decoration: word.image.path == '' ||
                    word.image == null ||
                    word.image.path == null
                ? BoxDecoration()
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultSize * 1),
                    image: DecorationImage(
                      image: FileImage(word.image),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
