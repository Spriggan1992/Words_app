import 'package:equatable/equatable.dart';
import 'package:words_app/models/word.dart';

class Collection extends Equatable {
  Collection(
      {this.collection,
      this.title,
      this.language,
      this.id,
      this.showBtns = false,
      this.isEditingBtns,
      this.isEditingMode = false});
  //id for DB

  final String id;
  final String title;
  final String language;
  final bool showBtns;
  final bool isEditingBtns;
  List<Word> collection;
  final bool isEditingMode;

  @override
  List<Object> get props =>
      [id, title, language, showBtns, isEditingBtns, collection, isEditingMode];

  Collection copyWith({
    String id,
    String title,
    String language,
    bool showBtns,
    bool isEditingBtns,
    bool isEditingMode,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      language: language ?? this.language,
      showBtns: showBtns ?? this.showBtns,
      isEditingBtns: isEditingBtns ?? this.isEditingBtns,
      isEditingMode: isEditingMode ?? this.isEditingMode,
    );
  }

  // /// this method is for textField, to change [title]
  // void changeCollectionTitle(String newName) {
  //   if (newName == null) {
  //     title = title;
  //   } else
  //     title = newName;
  // }

  // /// this method is for textField, to change [language]
  // void changeLanguageTitle(String newLanguage) {
  //   if (newLanguage == null) {
  //     language = language;
  //   } else
  //     language = newLanguage;
  // }

  // void toggleShowBtns() {
  //   showBtns = !showBtns;
  // }
}
