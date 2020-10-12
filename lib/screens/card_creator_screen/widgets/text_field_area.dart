import 'package:flutter/material.dart';

class TextFieldArea extends StatelessWidget {
  const TextFieldArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black87),
      maxLines: 5,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.black),
        labelText: 'add comments to example',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black),
        ),
      ),
    );
  }
}
