part of 'card_creator_bloc.dart';

@immutable
class CardCreatorState {
  final Word word;
  final String collectionId;
  final bool isSubmiting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final List<ImgData> imageData;

  CardCreatorState({
    this.word,
    this.collectionId,
    this.isSubmiting,
    this.isSuccess,
    this.isFailure,
    this.errorMessage,
    this.imageData,
  });

  factory CardCreatorState.empty() {
    return CardCreatorState(
        word: null,
        collectionId: '',
        isSubmiting: false,
        isSuccess: false,
        isFailure: false,
        errorMessage: "",
        imageData: []);
  }
  factory CardCreatorState.submitting({@required Word word}) {
    return CardCreatorState(
      word: word,
      isSubmiting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: "",
      imageData: [],
    );
  }
  factory CardCreatorState.success({@required Word word}) {
    return CardCreatorState(
      word: word,
      isSubmiting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: "",
      imageData: [],
    );
  }
  factory CardCreatorState.failure(
      {@required Word word, @required String errorMessage}) {
    return CardCreatorState(
      word: word,
      isSubmiting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
      imageData: [],
    );
  }
  CardCreatorState update(
      {Word word,
      bool isSubmiting,
      bool isSuccess,
      bool isFailure,
      String errorMessage,
      List<ImgData> imageData}) {
    return copyWith(
        word: word,
        isSubmiting: isSubmiting,
        isSuccess: isSuccess,
        isFailure: isFailure,
        errorMessage: errorMessage,
        imageData: imageData);
  }

  CardCreatorState copyWith(
      {Word word,
      bool isSubmiting,
      bool isSuccess,
      bool isFailure,
      String errorMessage,
      List<ImgData> imageData}) {
    return CardCreatorState(
      word: word ?? this.word,
      isSubmiting: isSubmiting ?? this.isSubmiting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      imageData: imageData ?? this.imageData,
    );
  }

  @override
  String toString() => '''CardCreatorState
      word: $word, 
      isSubmiting: $isSubmiting,
      isSuccess: $isSuccess, 
      isFailure: $isFailure, 
      errorMessage: $errorMessage, 
      imageData: $imageData,
  ''';
}
