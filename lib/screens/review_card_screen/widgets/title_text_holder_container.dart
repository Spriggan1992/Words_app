import 'package:flutter/material.dart';
import 'package:words_app/config/constants.dart';

class TitleTextHolderContainer extends StatelessWidget {
  const TitleTextHolderContainer({
    Key key,
    @required this.defaultSize,
    @required this.wordHolder,
  }) : super(key: key);

  final double defaultSize;
  final String wordHolder;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: defaultSize * 8,
        minHeight: wordHolder.length > 13 ? defaultSize * 7 : defaultSize * 4,
      ),
      alignment: Alignment.center,
      width: defaultSize * 24,
      height: defaultSize * 4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultSize * 0.5),
        boxShadow: [kBoxShadow],
      ),
      child: Text(
        wordHolder,
        textScaleFactor: wordHolder.length > 72 ? 0.7 : 1,
        textAlign: TextAlign.center,
        style: Theme.of(context).primaryTextTheme.bodyText2.merge(
              TextStyle(
                  fontSize: wordHolder.length > 31
                      ? defaultSize * 1.4
                      : defaultSize * 2.6,
                  height: 1.2),
            ),
      ),
    );
  }
}
