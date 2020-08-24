import 'package:equatable/equatable.dart';


 class Collection extends Equatable {
  Collection(
      {this.title,
      this.language,
      this.id,
      this.showBtns = false,
      this.isEditingBtns});
  //id for DB

  final String id;
  final String title;
  final String language;
  final bool showBtns;
  final bool isEditingBtns;

  @override
  
  List<Object> get props => [id, title, language, showBtns, isEditingBtns];

  Collection copyWith({
    String id,
    String title,
    String language,
    bool showBtns,
    bool isEditingBtns,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      language: language ?? this.language,
      showBtns: showBtns ?? this.showBtns,
      isEditingBtns: isEditingBtns ?? this.isEditingBtns,
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
