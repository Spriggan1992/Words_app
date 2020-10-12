import 'package:flutter/material.dart';

import 'package:words_app/widgets/concave_decoration.dart';

const Color kLanguagePickerColor = Color(0xFF34c7b3);
const Color kWordsAppbarSelectedColor = Color(0xFF9E9E9E);

// USED Constants
const Color kDifficultyKnowColor = Color(0xFFd4f1c7);
const Color kDifficultyKnowALittleColor = Color(0xFFfbe7c6);
const Color kDifficultyDontKnowColor = Color(0xFFfea3ab);

// Background for Login Screen
// ****** COLORS*******
const Color kMainColorBackground = Color(0xFFf8e6e6);
const Color kAppBarsColor = Color(0xFFff9f9f);
const Color kMainColorBlue = Color(0xFF498ba6);
const Color kMainButtonColor = Color(0xFF34c7b3);

// ****** TEXT STYLES *******
const TextStyle kAppBarTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'Anybody',
  color: Color(0xffA53860),
);

const TextStyle kHintStyle = TextStyle(
  color: Color(0xE2DA627D),
  fontSize: 20,
  // fontWeight: FontWeight.w600,
);
// USED Constants

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
    blurRadius: 1.0,
    spreadRadius: 1.0,
    offset: Offset(1.5, 1.5));

final innerShadow = ConcaveDecoration(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  depth: 3,
  colors: [Colors.grey, Colors.black],
);
