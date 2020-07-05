import 'package:flutter/material.dart';

class ReusableTextFieldContainer extends StatelessWidget {
  ReusableTextFieldContainer({
    this.title,
    this.handleSubmit,
    this.fontSize,
    this.color,
    this.width,
    this.height,
  });

  final String title;
  final Function handleSubmit;
  final double fontSize;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 1),
        child: TextField(
          style: TextStyle(
            fontSize: fontSize,
            color: color,
          ),
          controller: TextEditingController(text: title),
          onSubmitted: handleSubmit,
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0),
            isDense: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
