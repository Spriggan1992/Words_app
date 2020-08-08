import 'package:flutter/material.dart';

class Collection with ChangeNotifier {
  Collection({this.title, this.language, this.id});
  //id for DB
  String id, title, language;

  /// this method is for textField, to change [title]
  void changeCollectionTitle(String newName) {
    if (newName == null) {
      title = title;
    } else
      title = newName;
  }

  /// this method is for textField, to change [language]
  void changeLanguageTitle(String newLanguage) {
    if (newLanguage == null) {
      language = language;
    } else
      language = newLanguage;
  }
}
