import 'package:flutter/material.dart';

class TextFieldLogPass extends StatelessWidget {
  TextFieldLogPass(
      {this.onChanged,
      this.onTap,
      this.textLabel,
      this.focusNode,
      this.isChecked});

  final Function onChanged;
  final Function onTap;
  final String textLabel;
  final FocusNode focusNode;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
      onTap: onTap,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: textLabel,
        labelStyle: TextStyle(
            color:
                focusNode.hasFocus || isChecked ? Colors.white : Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: isChecked ? Colors.white : Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
