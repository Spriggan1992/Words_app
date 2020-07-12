import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';

class ReusableFloatActionButton extends StatelessWidget {
  ReusableFloatActionButton({this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: kMainColorBlue,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
