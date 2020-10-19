part of 'bricks_bloc.dart';

abstract class BricksEvent extends Equatable {
  const BricksEvent();

  @override
  List<Object> get props => [];
}

class BricksLoaded extends BricksEvent {}
