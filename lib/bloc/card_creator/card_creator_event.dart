part of 'card_creator_bloc.dart';

abstract class CardCreatorEvent extends Equatable {
  const CardCreatorEvent();

  @override
  List<Object> get props => [];
}

class CardCreatorLoaded extends CardCreatorEvent {
  final String id;

  CardCreatorLoaded({this.id});

  List<Object> get props => [id];
}

class CardCreatorAddWord extends CardCreatorEvent {
  final Word word;

  CardCreatorAddWord({this.word});
  List<Object> get props => [word];
}

class CardCreatorEditWord extends CardCreatorEvent {}
