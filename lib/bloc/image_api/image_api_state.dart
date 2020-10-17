part of 'image_api_bloc.dart';

@immutable
class ImageApiState {
  final String collectionId;
  final bool isSubmiting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final List<ImgData> imageData;
  final String search;
  final File image;

  ImageApiState({
    this.search,
    this.collectionId,
    this.isSubmiting,
    this.isSuccess,
    this.isFailure,
    this.errorMessage,
    this.imageData,
    this.image,
  });

  factory ImageApiState.empty({String search}) {
    return ImageApiState(
        search: null,
        collectionId: '',
        isSubmiting: false,
        isSuccess: false,
        isFailure: false,
        errorMessage: "",
        imageData: []);
  }
  factory ImageApiState.submitting({@required String search}) {
    return ImageApiState(
      search: search,
      isSubmiting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: "",
      imageData: [],
    );
  }
  factory ImageApiState.success({@required String search}) {
    return ImageApiState(
      search: search,
      isSubmiting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: "",
      imageData: [],
    );
  }
  factory ImageApiState.failure(
      {@required String search, @required String errorMessage}) {
    return ImageApiState(
      search: search,
      isSubmiting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
      imageData: [],
    );
  }
  ImageApiState update(
      {String search,
      bool isSubmiting,
      bool isSuccess,
      bool isFailure,
      String errorMessage,
      List<ImgData> imageData,
      File image}) {
    return copyWith(
        search: search,
        isSubmiting: isSubmiting,
        isSuccess: isSuccess,
        isFailure: isFailure,
        errorMessage: errorMessage,
        imageData: imageData,
        image: image);
  }

  ImageApiState copyWith(
      {String search,
      bool isSubmiting,
      bool isSuccess,
      bool isFailure,
      String errorMessage,
      List<ImgData> imageData,
      File image}) {
    return ImageApiState(
      search: search ?? this.search,
      isSubmiting: isSubmiting ?? this.isSubmiting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      imageData: imageData ?? this.imageData,
      image: image ?? this.image,
    );
  }

  @override
  String toString() => '''ImageApiState
      search: $search, 
      isSubmiting: $isSubmiting,
      isSuccess: $isSuccess, 
      isFailure: $isFailure, 
      errorMessage: $errorMessage, 
      imageData: $imageData,
      image: $image,
  ''';
}
