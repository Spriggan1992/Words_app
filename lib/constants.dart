import 'package:flutter/material.dart';

// Background for Login Screen
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

// Background for Registration Screen
const kRegistrationBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF5FFFE),
      Color(0xFF67FEF5),
      Color(0xFF00559C),
    ],
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
      // Color(0xFFf1f5a9),
      // Color(0xFF96de78),
      // Color(0xFF78dec1),
      // Color(0xFF6bdced),
    ],
  ),
);

const kInputTextLogPass = InputDecoration(
  hintText: 'Text',
  hintStyle: TextStyle(
    fontSize: 40.0,
  ),
);
