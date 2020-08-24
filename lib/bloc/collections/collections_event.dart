part of 'collections_bloc.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class CollectionsLoaded extends CollectionsEvent {}

class CollectionsAdded extends CollectionsEvent {
  final String title;
  final String language;

  CollectionsAdded({this.title, this.language});

  List<Object> get props => [title, language];
}

class CollectionsUpdated extends CollectionsEvent {
  final Collection collection;
  CollectionsUpdated({this.collection});

  @override
  List<Object> get props => [collection];
}

class CollectionsDeleted extends CollectionsEvent {
  final String id;

  CollectionsDeleted({this.id});

  @override
  List<Object> get props => [id];
}

class CollectionsCurrent extends CollectionsEvent {
  // final Collection collection;

  // CollectionsCurrent(this.collection);

  // @override
  // List<Object> get props => [collection];
}
