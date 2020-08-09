import 'package:flutter/material.dart';
import 'package:words_app/components/concave_decoration.dart';

// Background for Login Screen
const Color kMainColorBackground = Color(0xFFf8e6e6);
const Color kAppBarsColor = Color(0xFFff9f9f);
const Color kMainColorBlue = Color(0xFF498ba6);
const Color kMainButtonColor = Color(0xFF34c7b3);

const kBackgroundColor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.5, 0.5],
    colors: [Color(0xFF498ba6), Color(0xFFf0f3f8)],
  ),
);

const kInputTextLogPass = InputDecoration(
  hintText: 'Text',
  hintStyle: TextStyle(
    fontSize: 40.0,
  ),
);

const kBoxShadow = BoxShadow(
    color: Color(0xFF878686),
    blurRadius: 3.0,
    spreadRadius: 1.0,
    offset: Offset(1, 0.5));

final innerShadow = ConcaveDecoration(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  depth: 3,
  colors: [Colors.grey, Colors.black],
);
