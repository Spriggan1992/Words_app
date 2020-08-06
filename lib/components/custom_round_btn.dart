import 'package:flutter/material.dart';

class CustomRoundBtn extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color fillColor;
  final Color color;

  const CustomRoundBtn(
      {Key key, this.onPressed, this.icon, this.fillColor, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: CircleBorder(),
      constraints: BoxConstraints(
        minHeight: 35,
        minWidth: 35,
      ),
      fillColor: fillColor,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
