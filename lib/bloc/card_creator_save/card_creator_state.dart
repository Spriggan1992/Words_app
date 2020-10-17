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
  final String collectionLang;

  CardCreatorSuccess({this.imageData, this.image, this.collectionLang});
  List<Object> get props => [image, imageData, collectionLang];
}

class CardCreatorFailure extends CardCreatorState {
  final String message;

  CardCreatorFailure({this.message});

  List<Object> get props => [message];
}
