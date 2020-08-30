part of 'card_creator_bloc.dart';

abstract class CardCreatorState extends Equatable {
  const CardCreatorState();

  @override
  List<Object> get props => [];
}

class CardCreatorLoading extends CardCreatorState {}

class CardCreatorSuccess extends CardCreatorState {
  final Word word;

  CardCreatorSuccess({this.word});
  List<Object> get props => [word];
}

class CardCreatorFailure extends CardCreatorState {}
