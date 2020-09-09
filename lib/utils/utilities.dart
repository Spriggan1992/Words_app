import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class Utilities {
  ///This method is returning [Color] object which previously was stored in String.
  static Color getColor(String color) {
    String valueString = color.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  ///Method to work with asset [image], to save it  as file
  static Future<File> assetToFile(String path,
      {String imageName = 'noimage'}) async {
    //loading data from file in assets
    final byteData = await rootBundle.load('assets/$path');
    //[name] of the file can be anything
    final String name = "$imageName.png";
    //to get current app folder path.
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    //creating savedImage in path on the phone
    final savedImage = File('${appDir.path}/$name');
    //write data from byteData to savedImage
    await savedImage.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return savedImage;
  }

  static setImage() async {
    final defaultImage = await assetToFile('images/noimage.png');
    return defaultImage;
  }
}
