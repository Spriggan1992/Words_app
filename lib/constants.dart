import 'package:flutter/material.dart';

const kLoginBackground = BoxDecoration(
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

const Color c1 = Color(0xFFF5FFFE);
const Color c2 = Color(0xFF67FEF5);
const Color c3 = Color(0xFF00559C);

const kRegistrationBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      c1,
      c2,
      c3,
    ],
  ),
);

const kInputTextLogPass = InputDecoration(
  hintText: 'Text',
  hintStyle: TextStyle(
    fontSize: 40.0,
  ),
);
