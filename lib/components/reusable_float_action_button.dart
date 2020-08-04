import 'package:flutter/material.dart';

class ReusableFloatActionButton extends StatelessWidget {
  ReusableFloatActionButton({this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Color(0xffDA627D),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 48,
        
      ),
    );
  }
}
