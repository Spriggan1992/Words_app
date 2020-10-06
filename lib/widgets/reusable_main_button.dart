import 'package:flutter/material.dart';

class ReusableMainButton extends StatelessWidget {
  const ReusableMainButton(
      {@required this.titleText,
      @required this.textColor,
      @required this.backgroundColor,
      @required this.onPressed,
      this.fontSize,
      this.fontWeight});

  final String titleText;
  final Color textColor;
  final Color backgroundColor;
  final Function onPressed;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          titleText,
          style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                TextStyle(fontSize: 16.0, color: Colors.white),
              ),
        ),
      ),
    );
  }
}
