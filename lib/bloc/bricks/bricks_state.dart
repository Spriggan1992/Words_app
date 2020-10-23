part of 'bricks_bloc.dart';

abstract class BricksState extends Equatable {
  const BricksState();

  @override
  List<Object> get props => [];
}

class BricksLoading extends BricksState {}

class BricksSuccess extends BricksState {
  final List<Word> initialData;
  final List<String> answersListOfBricks;
  final List<Brick> listBricks;
  final String answer;
  final int correct;
  final int wrong;

  BricksSuccess(
      {this.initialData,
      this.answersListOfBricks,
      this.listBricks,
      this.answer,
      this.correct,
      this.wrong});

  @override
  List<Object> get props =>
      [initialData, answersListOfBricks, answer, correct, wrong, listBricks];
}

class BricksFailure extends BricksState {}
