part of 'yes_no_game_bloc.dart';

abstract class YesNoGameState extends Equatable {
  const YesNoGameState();

  @override
  List<Object> get props => [];
}

class YesNoGameLoading extends YesNoGameState {}

class YesNoGameSuccess extends YesNoGameState {
  final List<Word> targetLang;
  final List<Word> ownLang;
  final int correct;
  final int wrong;
  YesNoGameSuccess({
    this.targetLang = const [],
    this.ownLang = const [],
    this.correct = 0,
    this.wrong = 0,
  });
  @override
  List<Object> get props => [targetLang, ownLang, correct, wrong];
}

class YesNoGameFailure extends YesNoGameState {}
