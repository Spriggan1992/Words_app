import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utilities {
  ///This method is returning [Color] object which previously was stored in String.
  static Color getColor(String color) {
    String valueString = color.split('(0x')[1].split(')')[0];
    print(valueString);
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  ///Method to work with asset [image], to save it  as file
  static Future<File> assetToFile(String path) async {
    //loading data from file in assets
    final byteData = await rootBundle.load('assets/$path');
    //name of the file
    String name = "noimage.png";
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final savedImage = await File('${appDir.path}/$name');
    await savedImage.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    print(savedImage.path);
    return (savedImage);
  }

  static setImage() async {
    final defaultImage = await assetToFile('images/noimage.png');
    return defaultImage;
  }
}
