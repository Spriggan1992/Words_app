import 'package:flutter/material.dart';

class Btns extends StatelessWidget {
  const Btns({
    Key key,
    this.padding = 0,
    this.icon,
    this.color,
    this.onPress,
    this.backgroundColor,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final Function onPress;
  final Color backgroundColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: IconButton(
        padding: EdgeInsets.all(padding),
        constraints: BoxConstraints(minHeight: 20, minWidth: 20),
        icon: Icon(
          icon,
          size: 18,
          color: color,
        ),
        onPressed: onPress,
      ),
    );
  }
}
