import 'package:flutter/material.dart';

// Background for Login Screen

const Color kMainColorBlue = Color(0xFF498ba6);
const Color kSecondColorPink = Color(0xFFF8B6b6);
const kBackgroundColor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.5, 0.5],
    colors: [Color(0xFF498ba6), Color(0xFFf0f3f8)],
  ),
);

// Background for ListCollection
const kListCollectionBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      Color(0xFFade4ff),
    ],
  ),
);

const kInputTextLogPass = InputDecoration(
  hintText: 'Text',
  hintStyle: TextStyle(
    fontSize: 40.0,
  ),
);
