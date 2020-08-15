import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';

class InnerShadowTextField extends StatefulWidget {
  final Function onChanged;
  final String hintText;
  final double defaultSize;
  final double fontSizeMultiplyer;
  final int maxLines;
  final String title;
  InnerShadowTextField(
      {this.onChanged,
      this.hintText,
      this.defaultSize,
      this.fontSizeMultiplyer,
      this.maxLines = 1,
      this.title});

  @override
  _InnerShadowTextFieldState createState() => _InnerShadowTextFieldState();
}

class _InnerShadowTextFieldState extends State<InnerShadowTextField> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: innerShadow,
      child: TextField(
        controller: myController,
        style: TextStyle(
          color: Colors.black,
          fontSize: widget.defaultSize * widget.fontSizeMultiplyer,
        ),

        maxLines: widget.maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(widget.defaultSize),
          hintStyle: TextStyle(
            color: Color(0xFFDA627D).withOpacity(0.5),
          ),

          // hintText: '3rd language',
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        // onChanged: (value) => thirdLang = value,
        onChanged: widget.onChanged,
      ),
    );
  }
}
