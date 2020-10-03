part of 'collection_detail_bloc.dart';

@immutable
class CollectionDetailsState {
  final Collection collection;
  final bool isSubmiting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  const CollectionDetailsState(
      {this.isSubmiting,
      this.isSuccess,
      this.isFailure,
      this.errorMessage,
      this.collection});

  factory CollectionDetailsState.empty() {
    return CollectionDetailsState(
        collection: null,
        isSubmiting: false,
        isSuccess: false,
        isFailure: false,
        errorMessage: '');
  }

  factory CollectionDetailsState.submitting({@required Collection collection}) {
    return CollectionDetailsState(
      collection: collection,
      isSubmiting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
    );
  }
  factory CollectionDetailsState.success({@required Collection collection}) {
    return CollectionDetailsState(
      collection: collection,
      isSubmiting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: '',
    );
  }
  factory CollectionDetailsState.failure(
      {@required Collection collection, @required String errorMessage}) {
    return CollectionDetailsState(
      collection: collection,
      isSubmiting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }

  CollectionDetailsState update({
    Collection collection,
    bool isSubmiting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }) {
    return copyWith(
        collection: collection,
        isSubmiting: isSubmiting,
        isSuccess: isSuccess,
        isFailure: isFailure,
        errorMessage: errorMessage);
  }

  CollectionDetailsState copyWith({
    Collection collection,
    bool isSubmiting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }) {
    return CollectionDetailsState(
      collection: collection ?? this.collection,
      isSubmiting: isSubmiting ?? this.isSubmiting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String toString() => '''CollectionState {
      collection: $collection,
      isSubmiting: $isSubmiting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errorMessage: $errorMessage
  } ''';
}
