import 'package:equatable/equatable.dart';

class CollectionEntity extends Equatable {
  final String id;
  final String title;
  final String language;

  CollectionEntity({this.id, this.title, this.language});

  @override
  List<Object> get props => [id, title, language];

  @override
  String toString() => '''UserEntity{
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
    );
  }
}
