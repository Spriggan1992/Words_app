part of 'yes_no_game_bloc.dart';

abstract class YesNoGameEvent extends Equatable {
  const YesNoGameEvent();

  @override
  List<Object> get props => [];
}

class YesNoGameLoaded extends YesNoGameEvent {}

class YesNoGameAnswerCorrect extends YesNoGameEvent {}

class YesNoGameAnswerWrong extends YesNoGameEvent {}

class YesNoGameDeleteWords extends YesNoGameEvent {
  final Word word;

  YesNoGameDeleteWords({this.word});
  @override
  List<Object> get props => [word];
}
