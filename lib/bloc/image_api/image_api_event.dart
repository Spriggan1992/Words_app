part of 'image_api_bloc.dart';

abstract class ImageApiEvent extends Equatable {
  const ImageApiEvent();

  @override
  List<Object> get props => [];
}

class ImageApiLoaded extends ImageApiEvent {
  final String search;

  ImageApiLoaded({
    this.search,
  });

  List<Object> get props => [search];
}

class ImageApiSearchUpdated extends ImageApiEvent {
  final String search;

  ImageApiSearchUpdated({@required this.search});
  List<Object> get props => [search];

  @override
  String toString() => 'ImageApiSearchUpdated { search: $search }';
}

class ImageApiDownloadImagesFromAPI extends ImageApiEvent {}

class ImageApiUpdateImagesFromAPI extends ImageApiEvent {
  final String url;

  ImageApiUpdateImagesFromAPI({this.url = 'cat'});

  List<Object> get props => [url];
}

// class CardCreatorTargetLanguageUpdate extends ImageApiEvent {
//   final String targetLanguage;

//   CardCreatorTargetLanguageUpdate({@required this.targetLanguage});
//   List<Object> get props => [targetLanguage];

//   @override
//   String toString() =>
//       'CardCreatorTargetLanguageUpdate { targetLanguage: $targetLanguage }';
// }

// class CardCreatorOwnLanguageUpdate extends ImageApiEvent {
//   final String ownLanguage;

//   CardCreatorOwnLanguageUpdate({@required this.ownLanguage});
//   List<Object> get props => [ownLanguage];

//   @override
//   String toString() =>
//       'CardCreatorOwnLanguageUpdate { ownLanguage: $ownLanguage }';
// }

// class CardCreatorSecondLanguageUpdate extends ImageApiEvent {
//   final String secondLanguage;

//   CardCreatorSecondLanguageUpdate({@required this.secondLanguage});
//   List<Object> get props => [secondLanguage];

//   @override
//   String toString() =>
//       'CardCreatorSecondLanguageUpdate { secondLanguage: $secondLanguage }';
// }

// class CardCreatorThirdLanguageUpdate extends ImageApiEvent {
//   final String thirdLanguage;

//   CardCreatorThirdLanguageUpdate({@required this.thirdLanguage});
//   List<Object> get props => [thirdLanguage];

//   @override
//   String toString() =>
//       'CardCreatorThirdLanguageUpdate { thirdLanguage: $thirdLanguage }';
// }

// class CardCreatorExampleUpdate extends ImageApiEvent {
//   final String example;

//   CardCreatorExampleUpdate({@required this.example});
//   List<Object> get props => [example];

//   @override
//   String toString() =>
//       'CardCreatorTargetExampleUpdate { targetExample: $example }';
// }

// class CardCreatorOwnExapleUpdate extends ImageApiEvent {
//   final String exampleTranslation;

//   CardCreatorOwnExapleUpdate({@required this.exampleTranslation});
//   List<Object> get props => [exampleTranslation];

//   @override
//   String toString() =>
//       'CardCreatorOwnExapleUpdate { ownExample: $exampleTranslation }';
// }

// class CardCreatorUpdateImgFromCamera extends ImageApiEvent {}

// class CardCreatorAdded extends ImageApiEvent {}

// class CardCreatorSaved extends ImageApiEvent {}

// class CardCreatorDeleted extends ImageApiEvent {}
