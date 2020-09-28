import 'package:flutter/material.dart';

class TextHolder extends StatelessWidget {
  const TextHolder({
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
          TextSpan(text: titleName, style: TextStyle(fontSize: fontSize1)),
          TextSpan(
            text: titleNameValue,
            style: TextStyle(
              fontSize: fontSize2,
              color: Color(0xFF34c7b3),
            ),
          ),
        ],
      ),
    );
  }
}
