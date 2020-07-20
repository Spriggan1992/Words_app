import 'package:flutter/material.dart';

class Collection with ChangeNotifier {
  Collection({this.title, checkTextEdit});

  String title;
  bool isEditing = true;
  bool isFront = true;

  void toggleCheckTextEditing() {
    isEditing = !isEditing;
  }

  void toggleCheckFrontBack() {
    isFront = !isFront;
  }

  void changeCollectionName(String newName) {
    title = newName;
  }
}
