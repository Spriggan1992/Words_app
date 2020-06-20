import 'package:flutter/material.dart';

const kGradientBackgroundColor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.pink,
      Colors.red,
      Colors.purple,
      Colors.blue,
    ],
  ),
);

const kInputTextLogPass = InputDecoration(
  hintText: 'Text',
  hintStyle: TextStyle(
    fontSize: 40.0,
  ),
);
