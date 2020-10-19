import 'package:flutter/material.dart';

class Part {
  String partName;
  Color partColor;
  Part({this.partName, this.partColor});
  @override
  String toString() {
    // TODO: implement toString
    return '''{
      partName: $partName,
      partColor: $partColor
    }
    ''';
  }
}
