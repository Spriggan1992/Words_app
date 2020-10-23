part of 'bricks_bloc.dart';

abstract class BricksEvent extends Equatable {
  const BricksEvent();

  @override
  List<Object> get props => [];
}

class BricksLoaded extends BricksEvent {}

class BricksAddedLetter extends BricksEvent {
  final String letter;

  BricksAddedLetter({this.letter});

  @override
  List<Object> get props => [letter];
}

class BricksToggledVisibility extends BricksEvent {}
