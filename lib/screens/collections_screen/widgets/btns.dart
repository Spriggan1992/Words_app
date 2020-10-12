import 'package:flutter/material.dart';
import 'package:words_app/config/size_config.dart';

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
    final double defaultSize = SizeConfig.defaultSize;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: IconButton(
        padding: EdgeInsets.all(padding),
        constraints: BoxConstraints(
            minHeight: defaultSize * 2, minWidth: defaultSize * 2),
        icon: Icon(
          icon,
          size: defaultSize * 1.8,
          color: color,
        ),
        onPressed: onPress,
      ),
    );
  }
}
