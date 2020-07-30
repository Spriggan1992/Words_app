import 'package:flutter/material.dart';

class Collection with ChangeNotifier {
  Collection({this.title, this.language, this.id});
  //id for DB
  String id;
  String title;
  String language;

  void changeCollectionTitle(String newName) {
    if (newName == null) {
      title = title;
    } else
      title = newName;
  }

  void changeLanguageTitle(String newLanguage) {
    if (newLanguage == null) {
      language = language;
    } else
      language = newLanguage;
  }
}
