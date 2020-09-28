part of 'collection_detail_bloc.dart';

abstract class CollectionDetailEvent extends Equatable {
  const CollectionDetailEvent();

  @override
  List<Object> get props => [];
}

class CollectionLoaded extends CollectionDetailEvent {
  final Collection collection;
  const CollectionLoaded({@required this.collection});
  List<Object> get props => [collection];

  @override
  String toString() => 'CollectionLoaded { collection: $collection }';
}

class CollectionTitleUpdated extends CollectionDetailEvent {
  final String title;

  const CollectionTitleUpdated({this.title});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'CollectionTitleUpdated { title: $title }';
}

class CollectionLanguageUpdated extends CollectionDetailEvent {
  final String language;

  const CollectionLanguageUpdated({this.language});

  @override
  List<Object> get props => [language];

  @override
  String toString() => 'CollectionLanguageUpdated { language: $language }';
}

class CollectionDetailAdded extends CollectionDetailEvent {}

class CollectionDetailUpdated extends CollectionDetailEvent {}

class CollectionDetailDeleted extends CollectionDetailEvent {}
