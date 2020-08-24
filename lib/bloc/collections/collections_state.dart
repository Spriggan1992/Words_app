part of 'collections_bloc.dart';

abstract class CollectionsState extends Equatable {
  const CollectionsState();

  @override
  List<Object> get props => [];
}

class CollectionsInitial extends CollectionsState {}

class CollectionsLoaded extends CollectionsState {
  final List<Collection> collections;

  CollectionsLoaded([this.collections = const []]);

  @override
  List<Object> get props => [collections];

  
}

class CollectionsFailure extends CollectionsState {}
