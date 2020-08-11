import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';

class InnerShadowTextField extends StatelessWidget {
  final Function onChanged;
  final String hintText;
  final double defaultSize;
  final double fontSizeMultiplyer;
  final int maxLines;
  InnerShadowTextField(
      {this.onChanged,
      this.hintText,
      this.defaultSize,
      this.fontSizeMultiplyer,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: innerShadow,
      child: TextField(
        style: TextStyle(
          color: Colors.black,
          fontSize: defaultSize * fontSizeMultiplyer,
        ),

        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(defaultSize),
          hintStyle: TextStyle(
            color: Color(0xFFDA627D).withOpacity(0.5),
          ),

          // hintText: '3rd language',
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        // onChanged: (value) => thirdLang = value,
        onChanged: onChanged,
      ),
    );
  }
}
