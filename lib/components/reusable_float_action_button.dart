import 'package:flutter/material.dart';

class ReusableFloatActionButton extends StatelessWidget {
  ReusableFloatActionButton({this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.add,
        color: Color(0xFF262d31),
      ),
    );
  }
}
