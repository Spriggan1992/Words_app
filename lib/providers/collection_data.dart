import 'package:flutter/material.dart';

class Collection with ChangeNotifier {
  Collection({this.title, this.language});

  String title;
  String language;
  bool isEditing = true;
  bool isFront = true;

  void toggleCheckTextEditing() {
    isEditing = !isEditing;
  }

  void toggleCheckFrontBack() {
    isFront = !isFront;
  }

  void changeCollectionTitle(String newName) {
    title = newName;
  }

  void changeLanguageTitle(String language) {
    title = language;
  }
}
