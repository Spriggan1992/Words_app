part of 'collections_bloc.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class CollectionsLoaded extends CollectionsEvent {}

class CollectionsAdded extends CollectionsEvent {
  final Collection collection;

  CollectionsAdded(this.collection);

  List<Object> get props => [collection];
}

class CollectionsUpdated extends CollectionsEvent {
  final Collection collection;
  CollectionsUpdated(this.collection);

  @override
  List<Object> get props => [collection];
}

class CollectionsDeleted extends CollectionsEvent {
  final Collection collection;

  CollectionsDeleted(this.collection);

  @override
  List<Object> get props => [collection];
}

class CollectionsCurrent extends CollectionsEvent {
  // final Collection collection;

  // CollectionsCurrent(this.collection);

  // @override
  // List<Object> get props => [collection];
}
