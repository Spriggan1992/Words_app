import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';

import 'widgets.dart';

class ExampleField extends StatelessWidget {
  const ExampleField({
    Key key,
    @required this.active,
    @required this.side,
    @required this.word,
  }) : super(key: key);

  final bool active;
  final String side;
  final Word word;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutQuint,
      height: active
          ? SizeConfig.blockSizeVertical * 20
          : SizeConfig.blockSizeVertical * 16,
      decoration: innerShadow,
      margin: EdgeInsets.only(
        top: active ? defaultSize * 2 : defaultSize * 2,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: defaultSize * 1, left: defaultSize * 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            side == 'front'
                ? HighlightText(
                    text: word.example == '' ? '...' : word.example,
                    highlight: word.targetLang,
                  )
                : HighlightText(
                    text: word.exampleTranslations == ''
                        ? '...'
                        : word.exampleTranslations,
                    highlight: word.ownLang,
                  )
          ],
        ),
      ),
    );
  }
}
