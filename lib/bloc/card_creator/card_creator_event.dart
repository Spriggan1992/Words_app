part of 'card_creator_bloc.dart';

abstract class CardCreatorEvent extends Equatable {
  const CardCreatorEvent();

  @override
  List<Object> get props => [];
}

class CardCreatorLoaded extends CardCreatorEvent {
  final String id;
  final Word word;
  final List<Word> words;

  CardCreatorLoaded({this.id, this.word, this.words});

  List<Object> get props => [id, word, words];
}

class CardCreatorAddWord extends CardCreatorEvent {
  final Word word;

  CardCreatorAddWord({this.word});
  List<Object> get props => [word];
}

class CardCreatorEditWord extends CardCreatorEvent {
  final Word word;

  CardCreatorEditWord({this.word});
  List<Object> get props => [word];
}
