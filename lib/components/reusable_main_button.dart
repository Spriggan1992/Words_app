import 'package:flutter/material.dart';

class ReusableMainButton extends StatelessWidget {
  const ReusableMainButton(
      {@required this.titleText,
      @required this.titleColor,
      @required this.backgroundColor,
      @required this.onPressed,
      this.fontSize});

  final String titleText;
  final Color titleColor;
  final Color backgroundColor;
  final Function onPressed;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xFF174c4f),
              blurRadius: 2,
              spreadRadius: 0.5,
              offset: Offset(1, 1))
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          titleText,
          style: TextStyle(color: titleColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
