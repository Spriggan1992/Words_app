import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';

class BrickContainer extends StatelessWidget {
  final String letter;
  final Color color;

  const BrickContainer({
    Key key,
    this.letter,
    this.color = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultSize * 0.5),
          boxShadow: [kBoxShadow],
          color: color),
      alignment: Alignment.center,
      width: defaultSize * 4.1,
      height: defaultSize * 4.2,
      child: Text(
        letter,
        style: TextStyle(fontSize: defaultSize * 2),
      ),
    );
  }
}
