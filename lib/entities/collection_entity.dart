import 'package:equatable/equatable.dart';

class CollectionEntity extends Equatable {
  final String id;
  final String title;
  final String language;
  final int wordCount;

  CollectionEntity({this.wordCount, this.id, this.title, this.language});

  @override
  List<Object> get props => [id, title, language, wordCount];

  @override
  String toString() => '''CollectionEntity{
    id: $id,
    title: $title,
    language: $language
    
  }''';

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'title': title,
      'language': language,
    };
  }

  factory CollectionEntity.fromDb(Map<String, dynamic> data) {
    return CollectionEntity(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      language: data['language'] ?? '',
      wordCount: data['wordCount'] ?? 0,
    );
  }
}
