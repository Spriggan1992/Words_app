part of 'trainings_bloc.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoading extends TrainingsState {}

class TrainingsSuccess extends TrainingsState {
  final List<Word> words;

  TrainingsSuccess({this.words});
  List<Object> get props => [words];
}

class TrainingsFailure extends TrainingsState {}
