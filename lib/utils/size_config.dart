import 'package:flutter/material.dart';

//class SizeConfig {
//  static MediaQueryData _mediaQueryData;
//  static double screenWidth, screenHeight, defaultSize;
//  static Orientation orientation;
//
//  void init(BuildContext context) {
//    _mediaQueryData = MediaQuery.of(context);
//    screenWidth = _mediaQueryData.size.width;
//    screenHeight = _mediaQueryData.size.height;
//    orientation = _mediaQueryData.orientation;
//
//    //on Iphone 11 default size will be almost 10;
//    //if the screen size increase or decrease then our defaultSize will vary accordingly
//    //when you turn your phone landscape your width of screen became height
//    //so we check this condition in this ternary
//    defaultSize = orientation == Orientation.landscape
//        ? screenHeight * 0.024
//        : screenWidth * 0.024;
//  }
//}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth, defaultSize;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }
}
