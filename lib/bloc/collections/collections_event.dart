part of 'collections_bloc.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class CollectionsLoaded extends CollectionsEvent {}

class CollectionsToggleAll extends CollectionsEvent {
  final Collection collection;
  const CollectionsToggleAll({this.collection});

  @override
  List<Object> get props => [collection];
}

class CollectionsSetToFalse extends CollectionsEvent {}
