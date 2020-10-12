part of 'card_creator_bloc.dart';

@immutable
class CardCreatorState {
  final Word word;
  final String collectionId;
  final bool isSubmiting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  CardCreatorState({
    this.word,
    this.collectionId,
    this.isSubmiting,
    this.isSuccess,
    this.isFailure,
    this.errorMessage,
  });

  factory CardCreatorState.empty() {
    return CardCreatorState(
      word: null,
      collectionId: '',
      isSubmiting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: "",
    );
  }
  factory CardCreatorState.submitting({@required Word word}) {
    return CardCreatorState(
      word: word,
      isSubmiting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: "",
    );
  }
  factory CardCreatorState.success({@required Word word}) {
    return CardCreatorState(
      word: word,
      isSubmiting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: "",
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
    );
  }
  CardCreatorState update({
    Word word,
    bool isSubmiting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }) {
    return copyWith(
        word: word,
        isSubmiting: isSubmiting,
        isSuccess: isSuccess,
        isFailure: isFailure,
        errorMessage: errorMessage);
  }

  CardCreatorState copyWith({
    Word word,
    bool isSubmiting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }) {
    return CardCreatorState(
      word: word ?? this.word,
      isSubmiting: isSubmiting ?? this.isSubmiting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() => '''CardCreatorState
      word: $word, 
      isSubmiting: $isSubmiting,
      isSuccess: $isSuccess, 
      isFailure: $isFailure, 
      errorMessage: $errorMessage, 
  ''';
}
