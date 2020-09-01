part of 'collections_bloc.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class CollectionsLoaded extends CollectionsEvent {}

class CollectionsAdded extends CollectionsEvent {
  final Collection collection;

  CollectionsAdded({this.collection});

  List<Object> get props => [collection];
}

class CollectionsToggleAll extends CollectionsEvent {
  final Collection collection;
  CollectionsToggleAll({this.collection});

  @override
  List<Object> get props => [collection];
}

class CollectionsUpdated extends CollectionsEvent {
  final String title;
  final String language;
  final String id;
  CollectionsUpdated({this.id, this.title, this.language});

  @override
  List<Object> get props => [title, language];
}

class CollectionsDeleted extends CollectionsEvent {
  final String id;

  CollectionsDeleted({this.id});

  @override
  List<Object> get props => [id];
}

class CollectionsSetToFalse extends CollectionsEvent {
  // final Collection collection;

  // CollectionsSetToFalse(this.collection);

  // @override
  // List<Object> get props => [collection];
}
