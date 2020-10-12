part of 'card_creator_bloc.dart';

abstract class CardCreatorEvent extends Equatable {
  const CardCreatorEvent();

  @override
  List<Object> get props => [];
}

class CardCreatorLoaded extends CardCreatorEvent {
  final Word word;

  CardCreatorLoaded({
    this.word,
  });

  List<Object> get props => [word];
}

class CardCreatorPartUpdate extends CardCreatorEvent {
  final Part part;

  CardCreatorPartUpdate({@required this.part});
  List<Object> get props => [part];

  @override
  String toString() => 'CardCreatorPartUpdate { part: $part }';
}

class CardCreatorTargetLanguageUpdate extends CardCreatorEvent {
  final String targetLanguage;

  CardCreatorTargetLanguageUpdate({@required this.targetLanguage});
  List<Object> get props => [targetLanguage];

  @override
  String toString() =>
      'CardCreatorTargetLanguageUpdate { targetLanguage: $targetLanguage }';
}

class CardCreatorOwnLanguageUpdate extends CardCreatorEvent {
  final String ownLanguage;

  CardCreatorOwnLanguageUpdate({@required this.ownLanguage});
  List<Object> get props => [ownLanguage];

  @override
  String toString() =>
      'CardCreatorOwnLanguageUpdate { ownLanguage: $ownLanguage }';
}

class CardCreatorSecondLanguageUpdate extends CardCreatorEvent {
  final String secondLanguage;

  CardCreatorSecondLanguageUpdate({@required this.secondLanguage});
  List<Object> get props => [secondLanguage];

  @override
  String toString() =>
      'CardCreatorSecondLanguageUpdate { secondLanguage: $secondLanguage }';
}

class CardCreatorThirdLanguageUpdate extends CardCreatorEvent {
  final String thirdLanguage;

  CardCreatorThirdLanguageUpdate({@required this.thirdLanguage});
  List<Object> get props => [thirdLanguage];

  @override
  String toString() =>
      'CardCreatorThirdLanguageUpdate { thirdLanguage: $thirdLanguage }';
}

class CardCreatorTargetExampleUpdate extends CardCreatorEvent {
  final String targetExample;

  CardCreatorTargetExampleUpdate({@required this.targetExample});
  List<Object> get props => [targetExample];

  @override
  String toString() =>
      'CardCreatorTargetExampleUpdate { targetExample: $targetExample }';
}

class CardCreatorOwnExapleUpdate extends CardCreatorEvent {
  final String ownExample;

  CardCreatorOwnExapleUpdate({@required this.ownExample});
  List<Object> get props => [ownExample];

  @override
  String toString() => 'CardCreatorOwnExapleUpdate { ownExample: $ownExample }';
}

class CardCreatorUpdateImgFromCamera extends CardCreatorEvent {}

class CardCreatorDownloadImagesFromAPI extends CardCreatorEvent {
  final String name;

  CardCreatorDownloadImagesFromAPI({this.name});

  List<Object> get props => [name];
}

class CardCreatorUpdateImagesFromAPI extends CardCreatorEvent {
  final String url;

  CardCreatorUpdateImagesFromAPI({this.url = 'cat'});

  List<Object> get props => [url];
}

class CardCreatorAdded extends CardCreatorEvent {}

class CardCreatorSaved extends CardCreatorEvent {}

class CardCreatorDeleted extends CardCreatorEvent {}
