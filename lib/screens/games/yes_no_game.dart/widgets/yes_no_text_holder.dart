import 'package:flutter/material.dart';

class YesNoTextHolder extends StatelessWidget {
  const YesNoTextHolder({
    Key key,
    this.title,
    this.color,
    this.fontSize,
  }) : super(key: key);
  final String title;
  final Color color;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .primaryTextTheme
          .bodyText2
          .merge(TextStyle(fontSize: fontSize, color: color)),
    );
  }
}
