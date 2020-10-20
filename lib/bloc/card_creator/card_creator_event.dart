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

class CardCreatorExampleUpdate extends CardCreatorEvent {
  final String example;

  CardCreatorExampleUpdate({@required this.example});
  List<Object> get props => [example];

  @override
  String toString() =>
      'CardCreatorTargetExampleUpdate { targetExample: $example }';
}

class CardCreatorOwnExapleUpdate extends CardCreatorEvent {
  final String exampleTranslation;

  CardCreatorOwnExapleUpdate({@required this.exampleTranslation});
  List<Object> get props => [exampleTranslation];

  @override
  String toString() =>
      'CardCreatorOwnExapleUpdate { ownExample: $exampleTranslation }';
}

class CardCreatorUpdateImgFromCamera extends CardCreatorEvent {}

class CardCreatorUpdateImgFromApi extends CardCreatorEvent {
  final String url;

  CardCreatorUpdateImgFromApi({@required this.url});
  List<Object> get props => [url];

  @override
  String toString() => 'CardCreatorUpdateImgFromApi { image: $url }';
}

class CardCreatorAdded extends CardCreatorEvent {}

class CardCreatorSaved extends CardCreatorEvent {}

class CardCreatorDeleted extends CardCreatorEvent {}
