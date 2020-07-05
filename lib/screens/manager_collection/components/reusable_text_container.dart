import 'package:flutter/material.dart';

class ReusableTextContainer extends StatelessWidget {
  ReusableTextContainer(
      {this.height, this.width, this.title, this.fontSize, this.color});

  final double height;
  final double width;
  final String title;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
          ),
        ),
      ),
    );
  }
}
