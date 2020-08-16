import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String id;
  final String word;
  final bool isToggled;
  final double fontSize;
  final Function onTap;
  final Color color;
  final Color shadowColor;
  const CustomChip(
      {this.id,
      this.word,
      this.fontSize,
      this.onTap,
      this.color,
      this.isToggled,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        padding: EdgeInsets.all(10),
        label: Text(
          word,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        backgroundColor: color,
        elevation: 5,
        shadowColor: isToggled ? shadowColor : Colors.black,
      ),
    );
  }
}
