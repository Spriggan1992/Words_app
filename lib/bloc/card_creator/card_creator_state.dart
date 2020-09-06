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
  final List<ImgData> imageData;

  CardCreatorSuccess({this.imageData, this.image});
  List<Object> get props => [image, imageData];
}

class CardCreatorFailure extends CardCreatorState {
  final String message;

  CardCreatorFailure({this.message});

  List<Object> get props => [message];
}
