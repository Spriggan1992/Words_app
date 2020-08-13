import 'package:flutter/material.dart';

class ReusableBottomIconBtn extends StatelessWidget {
  const ReusableBottomIconBtn({
    this.onPress,
    this.color,
    this.icons,
    Key key,
  }) : super(key: key);

  final IconData icons;
  final Color color;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 5),
        alignment: Alignment.center,
        child: IconButton(
          iconSize: 20,
          icon: Icon(icons),
          color: color,
          onPressed: onPress,
        ));
  }
}
