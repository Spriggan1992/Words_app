import 'package:flutter/material.dart';

class Utilities {
  static Color getColor(String color) {
    String valueString = color.split('(0x')[1].split(')')[0];
    print(valueString);
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }
}
