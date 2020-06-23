import 'package:flutter/material.dart';

class TextFieldLogPass extends StatelessWidget {
  TextFieldLogPass(
      {this.onChanged,
      this.onTap,
      this.textLabel,
      this.focusNode,
      this.isChecked,
      this.color1,
      this.color2,
      this.borderColor});

  final Function onChanged;
  final Function onTap;
  final String textLabel;
  final FocusNode focusNode;
  final bool isChecked;
  final Color color1;
  final Color color2;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
      onTap: onTap,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: textLabel,
        labelStyle:
            TextStyle(color: focusNode.hasFocus || isChecked ? color1 : color2),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: isChecked ? color1 : color2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
