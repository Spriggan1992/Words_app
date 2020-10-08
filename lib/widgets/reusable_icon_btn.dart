import 'package:flutter/material.dart';

class ReusableIconBtn extends StatelessWidget {
  const ReusableIconBtn({
    this.onPress,
    this.color,
    this.icon,
    Key key,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 5),
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          iconSize: 25,
          icon: Icon(icon),
          color: color ?? Theme.of(context).accentColor,
          onPressed: onPress,
        ));
  }
}
