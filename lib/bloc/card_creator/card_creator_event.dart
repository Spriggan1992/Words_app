part of 'card_creator_bloc.dart';

abstract class CardCreatorEvent extends Equatable {
  const CardCreatorEvent();

  @override
  List<Object> get props => [];
}

class CardCreatorLoaded extends CardCreatorEvent {
  final Word word;
  final bool isEditingMode;

  CardCreatorLoaded({this.word, this.isEditingMode});

  List<Object> get props => [word, isEditingMode];
}

class CardCreatorUpdateImage extends CardCreatorEvent {
  // final File image;

  // CardCreatorUpdateImage({this.image});

  // List<Object> get props => [
  //       image,
  //     ];
}
