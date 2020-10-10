import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:words_app/entities/collection_entity.dart';

class Collection extends Equatable {
  final String id;
  final String title;
  final String language;
  final bool isEditingBtns;
  final int wordCount;

  Collection({
    this.wordCount,
    this.title,
    this.language,
    String id,
    this.isEditingBtns = false,
  }) : this.id = id ?? Uuid().v4();
  //id for DB

  @override
  List<Object> get props => [id, title, language, isEditingBtns, wordCount];

  @override
  String toString() => '''UserEntity{
    id: $id,
    title: $title,
    language: $language,
    isEditingBtns: $isEditingBtns,
    wordCount: $wordCount,
  }''';

  factory Collection.fromEntity(CollectionEntity entity) {
    return Collection(
        id: entity.id,
        title: entity.title,
        language: entity.language,
        isEditingBtns: false,
        wordCount: entity.wordCount);
  }
  CollectionEntity toEntity() {
    return CollectionEntity(
      id: id,
      title: title,
      language: language,
    );
  }

  Collection copyWith({
    String id,
    String title,
    String language,
    bool isEditingBtns,
    int wordCount,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      language: language ?? this.language,
      isEditingBtns: isEditingBtns ?? this.isEditingBtns,
      wordCount: wordCount ?? this.wordCount,
    );
  }
}
