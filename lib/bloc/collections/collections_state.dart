part of 'collections_bloc.dart';


abstract class CollectionsState extends Equatable {
  const CollectionsState();

  @override
  List<Object> get props => [];
}

class CollectionsLoading extends CollectionsState {}

class CollectionsSuccess extends CollectionsState {
  final List<Collection> collections;

  // CollectionsSuccess([this.collections = const []]);
  CollectionsSuccess(this.collections );

  @override
  List<Object> get props => [collections];

  
}

class CollectionsFailure extends CollectionsState {}
