part of 'card_creator_bloc.dart';

abstract class CardCreatorState extends Equatable {
  const CardCreatorState();

  @override
  List<Object> get props => [];

  get image => null;
}

class CardCreatorLoading extends CardCreatorState {}

class CardCreatorSuccess extends CardCreatorState {
  final File image;

  CardCreatorSuccess({this.image});
  List<Object> get props => [image];
}

class CardCreatorFailure extends CardCreatorState {}
