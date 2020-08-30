part of 'card_creator_bloc.dart';

abstract class CardCreatorState extends Equatable {
  const CardCreatorState();

  @override
  List<Object> get props => [];
}

class CardCreatorLoading extends CardCreatorState {}

class CardCreatorSuccess extends CardCreatorState {
  final List<Word> words;
  final Word word;

  CardCreatorSuccess({this.words, this.word});

  List<Object> get props => [words, word];
}

class CardCreatorFailure extends CardCreatorState {}
