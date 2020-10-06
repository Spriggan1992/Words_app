import 'package:flutter/material.dart';

class CollectionTextHolder extends StatelessWidget {
  const CollectionTextHolder({
    this.titleName,
    this.titleNameValue,
    this.fontSize1,
    this.fontSize2,
    Key key,
  }) : super(key: key);

  final String titleName;
  final String titleNameValue;
  final double fontSize1;
  final double fontSize2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: titleName,
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText2
                .merge(TextStyle(fontSize: fontSize1, color: Colors.black)),
          ),
          TextSpan(
            text: titleNameValue,
            style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                TextStyle(fontSize: fontSize1, color: Color(0xFF34c7b3))),
          ),
        ],
      ),
    );
  }
}
