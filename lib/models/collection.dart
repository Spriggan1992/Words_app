import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Collection extends Equatable {
  final String id;
  final String title;
  final String language;
  final bool showBtns;
  final bool isEditingBtns;
  final bool isEditingMode;
  final bool isSelected;

  Collection(
      {this.title,
      this.language,
      String id,
      this.showBtns = false,
      this.isEditingBtns,
      this.isEditingMode = false,
      this.isSelected = false})
      : this.id = id ?? Uuid().v4();
  //id for DB

  @override
  List<Object> get props =>
      [id, title, language, showBtns, isEditingBtns, isEditingMode];

  Collection copyWith({
    String id,
    String title,
    String language,
    bool showBtns,
    bool isEditingBtns,
    bool isEditingMode,
    bool isSelected,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      language: language ?? this.language,
      showBtns: showBtns ?? this.showBtns,
      isEditingBtns: isEditingBtns ?? this.isEditingBtns,
      isEditingMode: isEditingMode ?? this.isEditingMode,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
